import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'registration_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'RegistroAtividadeIndividualScreen.dart';

import 'package:flutter/material.dart';

class MenuInicialScreen extends StatefulWidget {
  @override
  static String ID = 'MenuInicial_screen';

  _MenuInicialScreenState createState() => _MenuInicialScreenState();
}

class _MenuInicialScreenState extends State<MenuInicialScreen> {
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
        print(user.email);
        print('qwertyu');
      }
    } catch (e) {
      print(e);
    }
  }

  void gotoRegistration() {
    setState(() {
      showSpinner = true;
    });

    try {
      Navigator.pushNamed(context, RegistrationScreen.ID);
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print("Erro");
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Auti app - Cuidador'),
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
                icon: new Icon(Icons.error_outline,
                    size: myIconSize, color: Colors.orange),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        // onPressed: () {
        // Add your onPressed code here!
        // },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        children: [
          SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: Colors.blue,
              label: 'Novo usuario',
              //labelStyle: TextTheme(fontSize: 18.0),
              onTap: () => gotoRegistration()),
          SpeedDialChild(
            child: Icon(Icons.person_add),
            backgroundColor: Colors.green,
            label: 'Nova atividade individual',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => Navigator.pushNamed(
                context, RegistroAtividadeIndividualScreen.ID),
          ),
          SpeedDialChild(
            child: Icon(Icons.group_add),
            backgroundColor: Colors.lightGreen,
            label: 'Nova atividade todos',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
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
        color: Colors.white70,
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Row(
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}
