import 'package:easyfood/url.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String url = URL().getURL();

  register() async {
    try {
      var response = await http.post(
        Uri.parse("$url/auth/register"),
        body: {
          "fullname": fullname.text.toString(),
          "phone": phone.text.toString(),
          "password": password.text.toString(),
        },
      );
      var result = json.decode(response.body);

      if (result['status'] == false) {
        _showMyDialog(result['message'], 'Mengerti', () {
          Navigator.pop(context);
        });
      } else {
        _showMyDialog(result['message'], 'OK', () {
          Navigator.pushNamed(context, '/login');
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog(
      String text, String subtext, Function() onPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            text.toString(),
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Text(
                subtext.toString(),
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.w700,
                  color: const Color(
                    0xff15BE77,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/pattern.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 75,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 175,
                  ),
                  Text(
                    'EasyFood',
                    style: GoogleFonts.viga(
                      fontSize: 40,
                      color: const Color(0xff15BE77),
                    ),
                  ),
                  Text(
                    'Order Your Favorite Food',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Create Your Account',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      hintStyle: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 183, 183, 183),
                        letterSpacing: 0.25,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xffF4F4F4),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xffF4F4F4),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 183, 183, 183),
                        letterSpacing: 0.25,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xffF4F4F4),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xffF4F4F4),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 183, 183, 183),
                        letterSpacing: 0.25,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xffF4F4F4),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xffF4F4F4),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff15BE77),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        register();
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Already have an account?',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(
                          0xff15BE77,
                        ),
                        decoration: TextDecoration.underline,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
