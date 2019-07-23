import 'package:Desenvolver/screens/AlunoAtividade.dart';
import 'package:flutter/material.dart';
import 'package:Desenvolver/screens/welcome_screen.dart';
import 'package:Desenvolver/screens/login_screen.dart';
import 'package:Desenvolver/screens/registration_screen.dart';
import 'package:Desenvolver/screens/chat_screen.dart';
import 'package:Desenvolver/screens/MenuInicial.dart';
import 'package:Desenvolver/screens/MenuInicialUsuario.dart';
import 'package:Desenvolver/screens/RegistroAtividadeIndividualScreen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white30),
        ),
      ),
      initialRoute: WelcomeScreen.ID,
      routes: {
        WelcomeScreen.ID: (context) => WelcomeScreen(),
        LoginScreen.ID: (context) => LoginScreen(),
        RegistrationScreen.ID: (context) => RegistrationScreen(),
        ChatScreen.ID: (context) => ChatScreen(),
        MenuInicialScreen.ID: (context) => MenuInicialScreen(),
        MenuInicialUsuarioScreen.ID: (context) => MenuInicialUsuarioScreen(),
        RegistroAtividadeIndividualScreen.ID: (context) =>
            RegistroAtividadeIndividualScreen(),
        AlunoAtividadeScreen.ID: (context) => AlunoAtividadeScreen(),
      },
    );
  }
}
