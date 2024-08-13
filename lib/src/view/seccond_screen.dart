// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:test_project/src/model/model.dart';
import 'package:test_project/src/partials/custome.dart';
import 'package:test_project/src/view/third_screen.dart';

class SeccondScreen extends StatefulWidget {
  final String name;
  const SeccondScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<SeccondScreen> createState() => _SeccondScreenState();
}

class _SeccondScreenState extends State<SeccondScreen> {
  String? _selectedUserName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Second Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: fontTheme,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          //rgb(85,74,240)
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 85, 74, 240),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.3,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: fontTheme,
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: fontTheme,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),

            //
            Center(
              child: Text(
                _selectedUserName ?? 'Selected User Name',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: fontTheme,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),

            //
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: btnPickUser(),
            ),
          ],
        ),
      ),
    );
  }

  btnPickUser() {
    return ElevatedButton(
      onPressed: () async {
        final selectedUser = await Navigator.push<User>(
          context,
          MaterialPageRoute(builder: (context) => ThirdScreen()),
        );
        if (selectedUser != null) {
          setState(() {
            _selectedUserName =
                '${selectedUser.firstName} ${selectedUser.lastName}';
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
        'Choose a User',
        style: TextStyle(
          color: Colors.white,
          fontFamily: fontTheme,
          fontSize: 14,
        ),
      ),
    );
  }
}
