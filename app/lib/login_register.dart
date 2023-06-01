import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachmewell/profile.dart';
import 'globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  // Login page
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      globals.loggedIn = true;
      return Profile(FirebaseAuth.instance.currentUser!.email!);
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF2574A8), //#2574A8
        body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 20),
                  child: Image(image: AssetImage('media/teachmewell_logo.png')),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 0,
                      right: 10,
                      bottom: 0,
                    ),
                  child: TextField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: "   Introduza o email",
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        fillColor: const Color(0xFF3983B9),
                        filled: true,
                      )
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                      bottom: 20,
                    ),
                  child: TextField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: "   Introduza a palavra-passe",
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        fillColor: const Color(0xFF3983B9),
                        filled: true,
                      )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          elevation: 4,
                          backgroundColor: const Color(0xFF3D3D3D)),
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;

                        if(email == ''){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  content: const Text("Deve preencher o email!",
                                  textAlign: TextAlign.center,
                                  ),
                                  actions: <Widget>[
                                    Center(
                                        child: TextButton(
                                            child: const Text('Fechar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }
                                        )
                                    ),
                                  ]
                              ));
                          return;
                        }

                        else if(password == ''){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  content: const Text("Deve preencher a palavra-passe!"),
                                  actions: <Widget>[
                                    Center(
                                        child: TextButton(
                                            child: const Text('Fechar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }
                                        )
                                    ),
                                  ]
                              ));
                          return;
                        }

                        try{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                        } on FirebaseAuthException {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  content: const Text("Email ou Password errados!"),
                                  actions: <Widget>[
                                    TextButton(
                                        child: const Text('Fechar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }
                                    )
                                  ]
                              ));
                          return;
                        }
                        if(context.mounted) {
                          globals.loggedIn = true;
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Profile(email),
                          ));
                        }
                      },
                      child: const Text('Login', style: TextStyle(
                          color: Colors.white,
                        fontSize: 19,
                      )),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            elevation: 4,
                            backgroundColor: const Color(0xFF3D3D3D)),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()
                          ));
                        },
                        child: const Text('Registar', style: TextStyle(
                            color: Colors.white,
                          fontSize: 19,
                        )),
                      ),
                    ),
                  ],
                ),
                TextButton(
                onPressed: () async {
                  globals.loggedIn = false;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profile('')
                  ));
                },
                child: const Text('Entrar como convidado', style: TextStyle(color: Colors.white),),
                )
              ],
            )
        )
    );
  }
}

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late final TextEditingController _up;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _up = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _up.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void createPopUp(int num) {
    String message = '';

    switch (num) {
      case 1:
        message = 'Todos os campos devem ser preenchidos';
        break;
      case 2:
        message = 'Insira um email @up.pt válido';
        break;
      case 3:
        message = 'O número UP é diferente do usado no email';
        break;
      case 4:
        message = 'A password deve ter entre 6 e 20 caracteres';
        break;
      case 5:
        message = 'As passwords não coincidem';
        break;
      case 6:
        message = 'Palavra-passe fraca';
        break;
      case 7:
        message = 'E-mail já em uso';
        break;
      case 8:
        message = 'Conta registada';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  // Register page
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF2574A8), //#2574A8
        appBar: AppBar(
          title: const Text('Registar'),
          backgroundColor: const Color(0xFF2574A8), //#2574A8
          shadowColor: const Color.fromARGB(48, 0, 0, 0),
        ),
        body: SingleChildScrollView(
            child : Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        right: 10,
                        bottom: 0,
                      ),
                    child: SizedBox(
                      child: TextField(
                        cursorColor: Colors.white,
                        style: const TextStyle(
                            color: Colors.white
                        ),
                        controller: _up,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white),
                          hintText: "   Introduza o UP",
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          fillColor: const Color(0xFF3983B9),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 20,
                      right: 10,
                      bottom: 0,
                    ),
                    child: SizedBox(
                      child: TextField(
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          controller: _email,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            hintText: "   Introduza o Email (up---------@up.pt)",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            fillColor: const Color(0xFF3983B9),
                            filled: true,
                          )
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        right: 10,
                        bottom: 0,
                      ),
                    child: SizedBox(
                      child: TextField(
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            hintText: "   Introduza a palavra-passe",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            fillColor: const Color(0xFF3983B9),
                            filled: true,
                          )
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: SizedBox(
                        child: TextField(
                            cursorColor: Colors.white,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                            controller: _confirmPassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              hintText: "   Confirme a palavra-passe",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              fillColor: const Color(0xFF3983B9),
                              filled: true,
                            )
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      top: 20,
                      right: 0,
                      bottom: 0,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if(_up.text == '' || _email.text == '' || _password.text == '' || _confirmPassword.text == ''){
                          createPopUp(1);
                          return;
                        }
                        else if(_email.text.substring(11) != '@up.pt'){
                          createPopUp(2);
                          return;
                        }
                        else if(_up.text != _email.text.substring(2, 11)){
                          createPopUp(3);
                          return;
                        }
                        else if(_password.text.length < 6 || _password.text.length > 20){
                          createPopUp(4);
                          return;
                        }
                        else if(_password.text != _confirmPassword.text){
                          createPopUp(5);
                          return;
                        }
                        else{
                          final String up = _up.text;
                          final String email = _email.text;
                          final String password = _password.text;

                          try{
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
                              FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
                                'up': up,
                                'email': email,
                                'password': password,
                              });
                            });
                            createPopUp(8);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              createPopUp(6);
                              return;
                            } else if (e.code == 'email-already-in-use') {
                              createPopUp(7);
                              return;
                            }
                          }
                          if(context.mounted) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage()
                            ));
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          elevation: 4,
                          backgroundColor: const Color(0xFF3D3D3D)
                      ),
                      child: const Text('Registar',
                      style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ]
            )
        ));
  }
}
