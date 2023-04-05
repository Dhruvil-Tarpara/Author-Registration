import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../globals/global.dart';
import '../../helpar/firebase_auth_helper.dart';
import '../../models/author.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: const Image(
                    image: AssetImage("assets/images/Logo.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () async{
                      Massage data = await FirebaseAuthHelper.firebaseAuthHelper.signInWithGoogle();
                      if(data.user != null)
                      {
                        Global.snackBar(context: context, message: "Sign is successful...", color: Colors.greenAccent, icon: Icons.supervised_user_circle_outlined);
                        Get.offAndToNamed("/",arguments: data);
                      }
                      else
                      {
                        Global.snackBar(context: context, message: "Sign is failed... \nException : ${data.error} ", color: Colors.redAccent, icon: Icons.no_accounts_outlined);
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          image: AssetImage(
                            "assets/images/search.png",
                          ),
                        ),
                        Text(
                          "Sign In with Google",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () async{
                      Massage data = await FirebaseAuthHelper.firebaseAuthHelper.signInWithGitHub();
                      if(data.user != null)
                      {
                        Global.snackBar(context: context, message: "Sign is successful...", color: Colors.greenAccent, icon: Icons.supervised_user_circle_outlined);
                        Get.offAndToNamed("/",arguments: data);
                      }
                      else
                      {
                        Global.snackBar(context: context, message: "Sign is failed... \nException : ${data.error} ", color: Colors.redAccent, icon: Icons.no_accounts_outlined);
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          image: AssetImage(
                            "assets/images/github-sign.png",
                          ),
                        ),
                        Text(
                          "Sign In with Github",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}