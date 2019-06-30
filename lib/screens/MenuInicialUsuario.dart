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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_play),

            //onPressed: ,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: '.....',
            //onPressed: _restitchDress,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add_check),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      {
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          //Navigator.pushNamed(context, RegistrationScreen.ID);
                          //setState(() {
                          //  showSpinner = false;
                          //});
                          print("qwe,mn");
                        } catch (e) {
                          //print("Erro");
                          print(e);
                        }
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Tarefas',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
