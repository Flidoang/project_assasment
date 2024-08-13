// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:test_project/src/partials/custome.dart';
import 'package:test_project/src/view/seccond_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _palindromeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String? _inputValueName;
  String? _inputValue;

  final _formKey = GlobalKey<FormState>();

  final List<String> _validWords = [
    'kasur rusak',
    'step on no pets',
    'put it up'
  ];

  final List<String> _invalidWords = ['suitmedia'];

  @override
  void dispose() {
    _palindromeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white38,
                  child: Icon(
                    Icons.person_add_alt_1,
                    color: white,
                    size: 30,
                  ),
                ),
                //
                SizedBox(height: 40),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: textFieldNama(),
                      ),
                      SizedBox(height: 20),

                      //
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: textFieldPalindrome(),
                      ),
                      SizedBox(height: 60),

                      //
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: btnCheck(),
                      ),
                      SizedBox(height: 20),

                      //
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: btnNext(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  textFieldNama() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        hintText: 'Name',
        hintStyle: TextStyle(
          color: grey,
          fontFamily: fontTheme,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      validator: (value) {
        _inputValueName = value?.trim().toLowerCase();
        if (_inputValueName == null || _inputValueName!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  textFieldPalindrome() {
    return TextFormField(
      controller: _palindromeController,
      decoration: InputDecoration(
        hintText: 'Palindrome',
        hintStyle: TextStyle(
          color: grey,
          fontFamily: fontTheme,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      validator: (value) {
        _inputValue = value?.trim().toLowerCase();
        if (_inputValue == null || _inputValue!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  btnCheck() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          if (_invalidWords.contains(_inputValue)) {
            _showErrorDialog(context,
                'Invalid word. You cannot use: ${_invalidWords.join(', ')}');
          } else if (!_validWords.contains(_inputValue)) {
            _showErrorDialog(context,
                'Invalid word. Please enter one of: ${_validWords.join(', ')}');
          } else {
            _showSuccesDialog(context, 'You hit the palindrome word');
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 43, 99, 123),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
      ),
      child: Text(
        'CHECK',
        style: TextStyle(
          fontSize: 14,
          color: white,
          fontFamily: fontTheme,
        ),
      ),
    );
  }

  btnNext() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          String enteredName = _nameController.text.trim();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeccondScreen(name: enteredName),
            ),
          ).then((_) {
            _nameController.clear();
            _palindromeController.clear();
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 43, 99, 123),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
      ),
      child: Text(
        'NEXT',
        style: TextStyle(
          fontSize: 14,
          color: white,
          fontFamily: fontTheme,
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not Palindrome'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ).then((_) {
      _palindromeController.clear();
    });
  }

  void _showSuccesDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('isPalindrome'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
