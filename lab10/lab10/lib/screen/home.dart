import 'package:flutter/material.dart';
import 'package:lab9/screen/login.dart';
import 'package:lab9/screen/register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register & Login with Firebase')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/art.png'),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      icon: Icon(Icons.login),
                      label: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 20),
                      ))),
              SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                      icon: Icon(Icons.login),
                      label: Text(
                        'สร้างบัญชีใหม่',
                        style: TextStyle(fontSize: 20),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}