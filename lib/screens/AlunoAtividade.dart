import 'package:Desenvolver/screens/DialogAtividade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'registration_screen.dart';
import 'MenuInicial.dart';

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
  String agendadiaSelecionada;
  String agendahoraSelecionada;
  String descricaoSelecionada;

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
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              centerTitle: true,
              title: Text('Atividades'),
            ),
            backgroundColor: Colors.white,
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                child: new Container(
                  child: Column(
                    children: <Widget>[
                      new MyCard(
                        title: new Text(
                          usuarioSelecionado,
                          style: myTextStyle,
                        ),
                        icon: new Icon(
                          Icons.done,
                          //size: myIconSize,
                          //color: Colors.deepOrangeAccent,
                        ),
                      ),
                      new MyCard(
                        title: new Text(
                          atividadeSelecionada,
                          style: myTextStyle,
                        ),
                        icon: new Icon(
                          Icons.done,
                          //size: myIconSize,
                          //color: Colors.deepOrangeAccent,
                        ),
                      ),
                      new MyCard(
                        title: new Text(
                          agendadiaSelecionada,
                          style: myTextStyle,
                        ),
                        icon: new Icon(
                          Icons.done,
                          //size: myIconSize,
                          //color: Colors.deepOrangeAccent,
                        ),
                      ),
                      new MyCard(
                        title: new Text(
                          agendahoraSelecionada,
                          style: myTextStyle,
                        ),
                        icon: new Icon(
                          Icons.done,
                          //size: myIconSize,
                          //color: Colors.deepOrangeAccent,
                        ),
                      ),
                      new MyCard(
                        title: new Text(
                          descricaoSelecionada,
                          style: myTextStyle,
                        ),
                        icon: new Icon(
                          Icons.done,
                          //size: myIconSize,
                          //color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Text("Tipo de ajuda:"),
            persistentFooterButtons: <Widget>[
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.thumb_down,
                    color: Colors.deepOrangeAccent,
                  ),
                  label: Text("Total")),
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.thumbs_up_down,
                    color: Colors.lightBlueAccent,
                  ),
                  label: Text("Parcial")),
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                  ),
                  label: Text("Sucesso")),
            ],
          );
        },
        fullscreenDialog: true));
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
                          agendadiaSelecionada = document['agendadia'];
                          agendahoraSelecionada = document['agendahora'];
                          descricaoSelecionada = document['descricao'];

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
                          usuarioSelecionado = document['usuario'];
                          atividadeSelecionada = document['procedimento'];
                          agendadiaSelecionada = document['agendadia'];
                          agendahoraSelecionada = document['agendahora'];
                          descricaoSelecionada = document['descricao'];
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
