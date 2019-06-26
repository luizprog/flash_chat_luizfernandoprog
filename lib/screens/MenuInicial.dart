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
      }
    } catch (e) {
      print(e);
    }
  }

  ListView getProcedimentosUsuarioAdmLogado() {
    return ListView(
      children: const <Widget>[
        Card(child: ListTile(title: Text('One-line ListTile'))),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line with trailing widget'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with both widgets'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line dense ListTile'),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Two-line ListTile'),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
        Card(
            color: Colors.blueGrey,
            child: ListTile(title: Text('One-line ListTile'))),
        Card(
            color: Colors.blueGrey,
            child: ListTile(title: Text('One-line ListTile'))),
        Card(
            color: Colors.blueGrey,
            child: ListTile(title: Text('One-line ListTile'))),
        Card(
            color: Colors.blueGrey,
            child: ListTile(title: Text('One-line ListTile'))),
        Card(
            color: Colors.blueGrey,
            child: ListTile(title: Text('One-line ListTile'))),
        Card(
            color: Colors.blueGrey,
            child: ListTile(title: Text('One-line ListTile'))),
        Card(
          color: Colors.blueGrey,
          child: ListTile(
            //leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
      ],
    );
    // async {
    /* final permissao = await _firestore.collection('usuarios').getDocuments();

    for (var usuariosLogado in permissao.documents) {
      if (usuariosLogado.data['usuario'].toString() == usuario) {
        if (usuariosLogado.data['nivelDeAcesso'] == 'administrador') {
          Navigator.pushNamed(context, MenuInicialScreen.ID);
        } else {
          Navigator.pushNamed(context, MenuInicialUsuarioScreen.ID);
        }
      }
    }*/
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
        child: Container(
          child: getProcedimentosUsuarioAdmLogado(),
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
