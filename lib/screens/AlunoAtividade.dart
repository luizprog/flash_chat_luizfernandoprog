import 'package:Desenvolver/screens/DialogAtividade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'registration_screen.dart';
import 'MenuInicial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoAtividadeScreen extends StatefulWidget {
  @override
  static String ID = 'AlunoAtividade_screen';

  _AlunoAtividadeScreenState createState() => _AlunoAtividadeScreenState();
}

class _AlunoAtividadeScreenState extends State<AlunoAtividadeScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String senha;
  String usuario;
  FirebaseUser loggedInUser;
  String messageText;
  bool TemDados;

  String usuarioSelecionado;
  String atividadeSelecionada;

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
      }
    } catch (e) {
      print(e);
    }
  }


  void _openAddEntryDialog() {

  String usuarioSelecionado;
  String atividadeSelecionada;
    Firestore.instance.collection('procedimento').where('usuario', isEqualTo: usuarioSelecionado.toString()).where('procedimento', isEqualTo: atividadeSelecionada.toString())
    .snapshots().listen(
          (data) => print('grower ${data.documents[0]['name']}')
    );
    /*
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new DialogAtividade();
        },
      fullscreenDialog: true
    ));
    */
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text('Atividades'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('procedimento')
                .where('usuario',
                    isEqualTo: MenuInicialScreen.usuarioSelecionado)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return new Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return new Column(
                  mainAxisSize: MainAxisSize.max,
                  verticalDirection: VerticalDirection.down,
                  children: snapshot.data.documents.map((document) {
                    print(document['conclusao'].toString());
                    if (document['conclusao'] == "sucesso") {
                      return new FlatButton(
                        child: Column(
                          children: <Widget>[
                            new MyCard(
                              title: new Text(
                                document['procedimento'],
                                style: myTextStyle,
                              ),
                              icon: new Icon(
                                Icons.done,
                                size: myIconSize,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          /*
                          print(document['procedimento']);
                          print(document['usuario']);
                          */
                          usuarioSelecionado = document['usuario'];
                          atividadeSelecionada = document['procedimento'];
                          _openAddEntryDialog();
                        },
                      ); //Column
                    } else {
                      return new FlatButton(
                        child: Column(
                          children: <Widget>[
                            new MyCard(
                              title: new Text(
                                document['procedimento'],
                                style: myTextStyle,
                              ),
                              icon: new Icon(
                                Icons.done,
                                size: myIconSize,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          /*
                          print(document['procedimento']);
                          print(document['usuario']);*/
                          usuarioSelecionado = document['usuario'];
                          atividadeSelecionada = document['procedimento'];
                          _openAddEntryDialog();
                        },
                      ); //Column
                    }
                  }).toList(),
                ); //ListView
              }
            },
          ),
        ),
      ),
    );
  }

  getModal() {
    print("Chamou a funcao");
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
      padding: const EdgeInsets.all(5.0),
      child: new Card(
        color: Colors.white70,
        child: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}

