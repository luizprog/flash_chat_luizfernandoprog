import 'package:AutiApp/screens/AlunoAtividade.dart';
import 'package:flutter/material.dart';
import 'package:AutiApp/screens/welcome_screen.dart';
import 'package:AutiApp/screens/login_screen.dart';
import 'package:AutiApp/screens/registration_screen.dart';
import 'package:AutiApp/screens/chat_screen.dart';
import 'package:AutiApp/screens/MenuInicial.dart';
import 'package:AutiApp/screens/MenuInicialUsuario.dart';
import 'package:AutiApp/screens/RegistroAtividadeIndividualScreen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
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
