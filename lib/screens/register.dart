import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_fireabase_auth_project/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static String routeName = '/register';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String fomatedMobile = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
                    child: Image.asset(
                        "assets/images/Logo-1-removebg-preview.png")),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final response = await http.post(
                              Uri.parse('https://porartable.com/api/register'),
                              headers: {
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode({
                                'mobile': fomatedMobile,
                                'name': nameController.text,
                                'password': passwordController.text,
                              }));
                          print(response.body);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text('Register Now'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text("Already have account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Text(
                          'Login Now !',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
