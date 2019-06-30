import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MenuInicial.dart';
import 'MenuInicialUsuario.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            Container(
              child: TextField(
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.black,
                  ),
                  hintText: 'nome do aluno/paciente',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
                onChanged: (String value) {
                  this.nomeInformado = value;
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
              child: TextField(
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  hintText: 'Dias da semana',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  helperText: 'dia da semana ',
                ),
                onChanged: (String value) {
                  this.agendaDiaInformado = value;
                },
              ),
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

            Container(
              child: TextField(
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  icon: Icon(
                    Icons.cloud_done,
                    color: Colors.black,
                  ),
                  hintText: 'Conclusao',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  helperText: 'tipo de conclusao',
                ),
                onChanged: (String value) {
                  this.tipoConclusaoInformado = value;
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
