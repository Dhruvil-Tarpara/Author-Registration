import 'package:author_app/models/author.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();

  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Massage> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    Map data = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      data.addAll({"user": user});
    } on FirebaseAuthException catch (e) {
      data.addAll({"error": e.code});
    }
    Massage object = Massage.fromData(data: data);
    return object;
  }

  Future<Massage> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    Map data = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      data.addAll({"user": user});
    } on FirebaseAuthException catch (e) {
      data.addAll({"error": e.code});
    }
    Massage object = Massage.fromData(data: data);
    return object;
  }

  Future<Massage> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;
    Map data = {};
    data.addAll({"user": user, "error": "Authentication Problems..."});
    Massage object = Massage.fromData(data: data);
    return object;
  }

  Future<Massage> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();

    UserCredential userCredential =
        await firebaseAuth.signInWithProvider(githubProvider);

    User? user = userCredential.user;

    Map data = {};
    data.addAll({"user": user, "error": "Authentication Problems..."});
    Massage object = Massage.fromData(data: data);
    return object;
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
