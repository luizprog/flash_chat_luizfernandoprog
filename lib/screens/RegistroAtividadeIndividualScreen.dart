import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MenuInicial.dart';
import 'MenuInicialUsuario.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RegistroAtividadeIndividualScreen extends StatefulWidget {
  static String ID = 'RegistroAtividadeIndividualScreen';
  @override
  _RegistroAtividadeIndividualScreenState createState() =>
      _RegistroAtividadeIndividualScreenState();
}

class _RegistroAtividadeIndividualScreenState
    extends State<RegistroAtividadeIndividualScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final firestore = Firestore.instance;
  var _mySelection;
  var _mySelection2;
  var _mySelection3;

  List<String> _comboTipo = new List<String>();
  bool showSpinner = false;
  String usuario;
  String senha;
  String tipo;

  String nomeInformado;
  String procedimentoInformado;
  String descricaoInformado;
  String agendaDiaInformado;
  String agendaHoraInformado;
  DatePickerMode diaCadastro;
  String tipoConclusaoInformado;
  String instrutorInformado;

  String dropdownValue = 'One';

  List _cities = ['administrador', 'comum'];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _comboTipo.addAll(['administrador', 'comum']);
    _dropDownMenuItems = getDropDownMenuItems();
    tipo = _dropDownMenuItems[0].value;
    usuario = _dropDownMenuItems[1].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
      print(selectedCity);
    });
  }

  String validadorDeNome(String value) {
    if (value.isEmpty) {
      return 'O nome deve ser informaado.';
    }
    return '';
  }

  String lastSelectedValue;
  void showDemoDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Auti app - Cuidador'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),

            Container(
              height: 200.0,
              child: Image.asset('images/auti.png'),
            ),

            // "Nome do form"
            SizedBox(
              height: 48.0,
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('usuarios').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Carregando...');
                  return new DropdownButton<String>(
                    isDense: true,
                    hint: new Text(
                      "Selecione o aluno",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: _mySelection,
                    onChanged: (String newValue) {
                      this.nomeInformado = newValue;
                    },
                    items: snapshot.data.documents.map((map) {
                      return new DropdownMenuItem<String>(
                        value: map["usuario"].toString(),
                        child: new Text(
                          map["usuario"],
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            SizedBox(
              height: 48.0,
            ),

            // "Nome do form"

            Container(
              child: TextField(
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  icon: Icon(
                    Icons.featured_play_list,
                    color: Colors.black,
                  ),
                  hintText: 'Procedimento',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  helperText: 'Informe o procedimento atividade',
                ),
                maxLines: 2,
                onChanged: (String value) {
                  this.procedimentoInformado = value;
                },
              ),
            ),

            // "Nome do form"

            Container(
              child: TextField(
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  icon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  hintText: 'descricao do procedimento',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  helperText: 'Informe como e oque deve ser feito na atividade',
                ),
                maxLines: 5,
                onChanged: (String value) {
                  this.descricaoInformado = value;
                },
              ),
            ),

            // "Nome do form"

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                shape: BoxShape.rectangle,
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('diasAtividades').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Carregando...');
                  return new DropdownButton<String>(
                    hint: new Text(
                      _mySelection2,
                      style: TextStyle(color: Colors.black),
                    ),
                    value: _mySelection2,
                    onChanged: (String newValue) {
                      this.agendaDiaInformado = newValue;
                      _mySelection2 = newValue;
                      return;
                    },
                    items: snapshot.data.documents.map((map) {
                      return new DropdownMenuItem<String>(
                        value: map["descricao"].toString(),
                        child: new Text(
                          map["descricao"],
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            SizedBox(
              height: 48.0,
            ),

            Container(
              child: TextField(
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  icon: Icon(
                    Icons.watch_later,
                    color: Colors.black,
                  ),
                  hintText: 'Hora de fazer a atividade',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  helperText: 'Hora de fazer a atividade',
                ),
                onChanged: (String value) {
                  this.agendaHoraInformado = value;
                },
              ),
            ),

            SizedBox(
              height: 48.0,
            ),

            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('tipoEntrega').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Carregando...');
                  return new DropdownButton<String>(
                    isDense: true,
                    hint: new Text(
                      "Selecione o status de entrega",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: _mySelection3,
                    onChanged: (String newValue) {
                      this.tipoConclusaoInformado = newValue;
                    },
                    items: snapshot.data.documents.map((map) {
                      return new DropdownMenuItem<String>(
                        value: map["situacao"].toString(),
                        child: new Text(map["situacao"],
                            style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            //button save
            SizedBox(
              height: 48.0,
            ),
            Container(
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      _firestore.collection('procedimento').add({
                        'usuario': nomeInformado,
                        'procedimento': procedimentoInformado,
                        'descricao': descricaoInformado,
                        'conclusao': tipoConclusaoInformado,
                        'agendadia': agendaDiaInformado,
                        'agendahora': agendaHoraInformado,
                        'dataDaInclusao': DateTime.now(),
                        'instrutor': usuario,
                      });

                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, MenuInicialScreen.ID);
                    } catch (e) {
                      print("Erro");
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Salvar',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoDessertDialog extends StatelessWidget {
  const CupertinoDessertDialog({Key key, this.title, this.content})
      : super(key: key);

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Cheesecake'),
          onPressed: () {
            Navigator.pop(context, 'Cheesecake');
          },
        ),
        CupertinoDialogAction(
          child: const Text('Tiramisu'),
          onPressed: () {
            Navigator.pop(context, 'Tiramisu');
          },
        ),
        CupertinoDialogAction(
          child: const Text('Apple Pie'),
          onPressed: () {
            Navigator.pop(context, 'Apple Pie');
          },
        ),
        CupertinoDialogAction(
          child: const Text("Devil's food cake"),
          onPressed: () {
            Navigator.pop(context, "Devil's food cake");
          },
        ),
        CupertinoDialogAction(
          child: const Text('Banana Split'),
          onPressed: () {
            Navigator.pop(context, 'Banana Split');
          },
        ),
        CupertinoDialogAction(
          child: const Text('Oatmeal Cookie'),
          onPressed: () {
            Navigator.pop(context, 'Oatmeal Cookies');
          },
        ),
        CupertinoDialogAction(
          child: const Text('Chocolate Brownie'),
          onPressed: () {
            Navigator.pop(context, 'Chocolate Brownies');
          },
        ),
        CupertinoDialogAction(
          child: const Text('Cancel'),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
      ],
    );
  }
}
