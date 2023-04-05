import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:author_app/helpar/firebase_auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../globals/global.dart';
import '../../helpar/firebase_db_helper.dart';
import '../../models/author.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateKey = GlobalKey<FormState>();

  TextEditingController bookController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  TextEditingController bookUpDateController = TextEditingController();
  TextEditingController authorUpDateController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  String? title;
  String? body;
  String? img;

  @override
  Widget build(BuildContext context) {
    Massage data = ModalRoute.of(context)!.settings.arguments as Massage;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff1d3557),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Registration",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
              onPressed: () async {
                await FirebaseAuthHelper.firebaseAuthHelper.logout();
                Get.offAndToNamed("/login_page");
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(data.user.photoURL ?? ""),
                ),
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              Text(
                " ${data.user.displayName}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " ${data.user.email}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Author").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>> data =
                  snapshot.data as QuerySnapshot<Map<String, dynamic>>;

              List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                  data.docs;

              return ListView.builder(
                itemCount: allDocs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 200,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Image(
                              image: MemoryImage(base64Decode(
                                  allDocs[i].data()['image'] as String)),
                              height: 80,
                              width: w,
                              fit: BoxFit.cover,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Book Name :",
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${allDocs[i].data()['title']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Author Name :",
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${allDocs[i].data()['body']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.copy,color: Colors.blue,)),
                                Spacer(),
                                IconButton(onPressed: (){}, icon: Icon(Icons.star,color: Colors.orange,)),
                                Spacer(),
                                IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.black,)),
                                Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.brown,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Update Notes"),
                                        content: SizedBox(
                                          height: 300,
                                          width: 250,
                                          child: Form(
                                            key: updateKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    XFile? xFile =
                                                        await imagePicker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery,
                                                                imageQuality:
                                                                    20);

                                                    Uint8List bytes =
                                                        await xFile!
                                                            .readAsBytes();
                                                    img = base64Encode(bytes);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundImage: (img !=
                                                            null)
                                                        ? MemoryImage(
                                                            img as Uint8List)
                                                        : null,
                                                    radius: 50,
                                                    child: Text(
                                                      (img != null)
                                                          ? ""
                                                          : "ADD",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  validator: (val) => (val!
                                                          .isEmpty)
                                                      ? "Enter title First..."
                                                      : null,
                                                  onSaved: (val) {
                                                    title = val;
                                                  },
                                                  controller:
                                                      bookUpDateController,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          "Enter title Here....",
                                                      labelText: "title"),
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  validator: (val) => (val!
                                                          .isEmpty)
                                                      ? "Enter body First..."
                                                      : null,
                                                  onSaved: (val) {
                                                    body = val;
                                                  },
                                                  controller:
                                                      authorUpDateController,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          "Enter body Here....",
                                                      labelText: "body"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (updateKey.currentState!
                                                  .validate()) {
                                                updateKey.currentState!.save();
                                              }

                                              Map<String, dynamic> recode = {
                                                "title": title,
                                                "body": body,
                                                "image": img,
                                              };

                                              await FirebaseDBHelper
                                                  .firebaseDBHelper
                                                  .updateBook(
                                                      data: recode,
                                                      id: allDocs[i].id);

                                              Navigator.of(context).pop();

                                              setState(() {
                                                bookUpDateController.clear();
                                                authorUpDateController.clear();

                                                title = null;
                                                body = null;
                                                img = null;
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Notes update successfully...",
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            },
                                            child: const Text("update"),
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Close"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Not in stock'),
                                          content: const Text(
                                              'This item is no longer available'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                FirebaseDBHelper
                                                    .firebaseDBHelper
                                                    .deleteBook(
                                                        id: allDocs[i].id);

                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("YES"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("NO"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff1d3557),
        label: const Text("Add"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          validate(context);
        },
      ),
    );
  }

  validate(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Author Add",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          )),
          content: SizedBox(
            height: 290,
            width: 250,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      XFile? xFile = await imagePicker.pickImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      Uint8List bytes = await xFile!.readAsBytes();
                      img = base64Encode(bytes);
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          (img != null) ? MemoryImage(img as Uint8List) : null,
                      backgroundColor: Color(0xff1d3557),
                      radius: 50,
                      child: Text(
                        (img != null) ? "" : "ADD",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter The title...";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        title = val;
                      },
                      controller: bookController,
                      decoration: const InputDecoration(
                        hintText: "Enter The Book Name...",
                        label: Text("Book Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter The body...";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      onSaved: (val) {
                        body = val;
                      },
                      controller: authorController,
                      decoration: const InputDecoration(
                        hintText: "Enter The Author Name ...",
                        label: Text("Author Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1d3557)),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }

                    Map<String, dynamic> recode = {
                      "title": title,
                      "body": body,
                      "image": img
                    };
                    await FirebaseDBHelper.firebaseDBHelper
                        .insertBook(data: recode);
                    setState(() {
                      Get.back();
                      bookController.clear();
                      authorController.clear();
                      title = null;
                      body = null;
                      img = null;
                    });
                    Global.snackBar(
                        context: context,
                        message: "Recode inserted successfully...",
                        color: Colors.green,
                        icon: Icons.arrow_right_alt_outlined);
                  },
                  child: const Text(
                    "Insert",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
