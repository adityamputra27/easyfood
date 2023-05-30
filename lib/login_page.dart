import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
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
                    'Book Your Favorite Food',
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
                    'Login To Your Account',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
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
                          )),
                      onPressed: () {},
                      child: Text(
                        'Login',
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
                  Text(
                    'Dont have an account?',
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
