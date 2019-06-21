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
        title: Text('My Fancy Dress'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_play),
            tooltip: 'Air it',
            //onPressed: ,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: 'Restitch it',
            //onPressed: _restitchDress,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add_check),
            tooltip: 'Repair it',
            //onPressed: _repairDress,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            color: Colors.blueAccent,
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
      ),
    );
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }
}
