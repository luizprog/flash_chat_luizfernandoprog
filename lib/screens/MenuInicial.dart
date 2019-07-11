import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'registration_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'RegistroAtividadeIndividualScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  static final double myTextSize = 20.0;
  final double myIconSize = 20.0;
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
        centerTitle: true,
        title: Text('Auti app - Cuidador'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('procedimento')
                .where('instrutor', isEqualTo: loggedInUser.email.toString())
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');

              return new Column(
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.down,
                children: snapshot.data.documents.map((document) {
                  if (document['conclusao'] == "sucesso") {
                    return new Column(
                      children: <Widget>[
                        new MyCard(
                            title: new Text(
                              document['procedimento'],
                              style: myTextStyle,
                            ),
                            icon: new Icon(Icons.done,
                                size: myIconSize, color: Colors.green)),
                      ],
                      //title: new Text(document['procedimento']),
                      //subtitle: new Text(document['descricao']),
                      //dense: true,
                      //enabled: true,
                      //contentPadding:EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                      //isThreeLine: true,
                    ); //ListTile
                  } else {
                    return new Column(
                      children: <Widget>[
                        new MyCard(
                            title: new Text(
                              document['procedimento'],
                              style: myTextStyle,
                            ),
                            icon: new Icon(Icons.done,
                                size: myIconSize, color: Colors.redAccent)),
                      ],
                      //title: new Text(document['procedimento']),
                      //subtitle: new Text(document['descricao']),
                      //dense: true,
                      //enabled: true,
                      //contentPadding:EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                      //isThreeLine: true,
                    ); //ListTile
                  }
                }).toList(),
              ); //ListView
            },
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
              label: 'Novo aluno',
              //labelStyle: TextTheme(fontSize: 18.0),
              onTap: () => gotoRegistration()),
          SpeedDialChild(
            child: Icon(Icons.person_add),
            backgroundColor: Colors.green,
            label: 'Nova atividade',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => Navigator.pushNamed(
                context, RegistroAtividadeIndividualScreen.ID),
          ),
          SpeedDialChild(
            child: Icon(Icons.group_add),
            backgroundColor: Colors.lightGreen,
            labelStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
            label: 'Nova atividade compartilhada',
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
      padding: const EdgeInsets.all(2.0),
      child: new Card(
        color: Colors.white70,
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}
