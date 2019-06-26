import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'registration_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
        title: Text('...'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_play),
            tooltip: '....',
            //onPressed: ,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: '.....',
            //onPressed: _restitchDress,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add_check),
            tooltip: '......',
            //onPressed: _repairDress,
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
                          Navigator.pushNamed(context, RegistrationScreen.ID);
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print("Erro");
                          print(e);
                        }
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Registrar',
                    ),
                  ),
                ),
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
            label: 'Novo procedimento para usuario',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.group_add),
            backgroundColor: Colors.lightGreen,
            label: 'Novo procedimento todos usuarios',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }
}
