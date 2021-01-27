import 'package:flutter/material.dart';
import 'package:packlog/home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF49D27),
      body: Center(
        child: Container(
          height: 500,
          width: 600,
          child: Card(
            elevation: 10,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 124, vertical: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset('assets/icons/logo.jpeg'),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 70,
                    child: Center(
                      child: TextFormField(
                        controller: controller,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.all(24),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      if (controller.text == 'ABSCHALELEMENT') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
