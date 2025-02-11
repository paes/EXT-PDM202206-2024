import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_fila/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  // Tela de login, permitindo autenticação via email/senha e Google
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signupNavigation(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color(0xffF7F7F9),
              shape: BoxShape.circle
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Hello Again',
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32
                    )
                  ),
                ),
              ),
              const SizedBox(height: 80,),
              _emailAddress(),
              const SizedBox(height: 20,),
              _password(),
              const SizedBox(height: 50,),
              _signin(context),
              const SizedBox(height: 20),
              _googleSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Campo de email do usuário
  Widget _emailAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16
            )
          ),
        ),
        const SizedBox(height: 16,),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'seuemail@example.com',
            hintStyle: const TextStyle(
              color: Color(0xff6A6A6A),
              fontSize: 14
            ),
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14)
            )
          ),
        )
      ],
    );
  }

  // Campo de senha do usuário
  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16
            )
          ),
        ),
        const SizedBox(height: 16,),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14)
            )
          ),
        )
      ],
    );
  }

  // Botão para fazer login com email e senha
  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context
        );
      },
      child: const Text("Sign In"),
    );
  }

  // Botão para fazer login com o Google
  Widget _googleSignInButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        side: const BorderSide(color: Colors.black12),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      icon: Image.asset(
        'assets/images/google.png',
        height: 24,
        width: 24,
      ),
      label: const Text("Sign in with Google"),
      onPressed: () async {
        await AuthService().signinWithGoogle(context: context);
      },
    );
  }

  // Rodapé com opção para ir para a tela de cadastro
  Widget _signupNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Não tem uma conta? ",
              style: TextStyle(
                color: Color(0xff6A6A6A),
                fontSize: 16
              ),
            ),
            TextSpan(
              text: "Cadastre-se",
              style: const TextStyle(
                color: Color(0xff1A1D1E),
                fontSize: 16
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                Navigator.pushNamed(context, '/signup');
              }
            ),
          ]
        )
      ),
    );
  }
}
