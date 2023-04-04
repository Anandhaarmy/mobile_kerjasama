import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fireabase_auth_project/screens/register.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static String routeName = '/login';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String fomatedMobile = '';
  final String errorMessage = 'ths is error';

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
                    child: Image.asset("assets/images/logo.jpg")),
                IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'BD',
                  controller: mobileController,
                  onChanged: (phone) {
                    fomatedMobile = phone.completeNumber;
                    print(phone.completeNumber);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(10),
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
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
                    ),
                    onPressed: () async {
                      final response = await http.post(
                          Uri.parse('some'),
                          headers: {
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode({
                            'mobile': fomatedMobile,
                            'password': passwordController.text,
                          }));
                      print('ok');

                    },
                    child: Text('Login'),
                  ),
                ),
                Text(errorMessage == '' ? errorMessage : ''),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text("Create a new account ?", style: TextStyle(color: Colors.black),),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                          // Get.to(RegisterScreen());
                        },
                        child: Text(
                          'Register Now !',
                          style: TextStyle(
                            color:Colors.redAccent,
                            fontWeight: FontWeight.w900,
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