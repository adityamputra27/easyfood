import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
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

    logout() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        preferences.setBool("is_logged_in", false);
        preferences.setString("id", 'null');
        preferences.setString("fullname", 'null');
        preferences.setString("phone", 'null');
        preferences.setString("address", 'null');
      });
      _showMyDialog('Logout Berhasil!', 'OK', () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 150,
          height: 57,
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff15BE77),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                )),
            onPressed: () {
              logout();
            },
            child: Text(
              'Logout',
              style: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
