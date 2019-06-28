import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'registration_screen.dart';

class MenuInicialUsuarioScreen extends StatefulWidget {
  @override
  static String ID = 'MenuInicialUsuario_screen';

  _MenuInicialUsuarioScreenState createState() =>
      _MenuInicialUsuarioScreenState();
}

class _MenuInicialUsuarioScreenState extends State<MenuInicialUsuarioScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String senha;
  String usuario;
  FirebaseUser loggedInUser;
  String messageText;

  static final double myTextSize = 30.0;
  final double myIconSize = 30.0;
  final TextStyle myTextStyle =
      new TextStyle(color: Colors.black, fontSize: myTextSize);

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Auti app - Paciente'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // Makes the cards stretch in horizontal axis
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Setup the card
              new MyCard(
                  title: new Text(
                    "Feito pelos pais",
                    style: myTextStyle,
                  ),
                  icon: new Icon(Icons.done,
                      size: myIconSize, color: Colors.deepOrange)),
              new MyCard(
                  title: new Text(
                    "Feito com ajuda",
                    style: myTextStyle,
                  ),
                  icon: new Icon(Icons.done,
                      size: myIconSize, color: Colors.green)),
              new MyCard(
                  title: new Text(
                    "Sucesso",
                    style: myTextStyle,
                  ),
                  icon: new Icon(Icons.done_all,
                      size: myIconSize, color: Colors.green)),
              new MyCard(
                  title: new Text(
                    "Atrasado",
                    style: myTextStyle,
                  ),
                  icon: new Icon(
                    Icons.error_outline,
                    size: myIconSize,
                    color: Colors.orange,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final Widget icon;
  final Widget title;

  // Constructor. {} here denote that they are optional values i.e you can use as: new MyCard()
  MyCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        elevation: 1.0,
        color: Colors.white70,
        child: new Container(
          padding: const EdgeInsets.all(15.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}
