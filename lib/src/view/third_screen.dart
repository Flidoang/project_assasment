// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:test_project/src/model/model.dart';
import 'package:test_project/src/partials/custome.dart';
import 'package:test_project/src/service/service.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int _page = 1;
  int per_page = 10;
  List<User> _users = [];
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<User> fetchedUsers = await fetchUsers(_page, per_page);
      setState(() {
        _page++;
        _users.addAll(fetchedUsers);
        if (fetchedUsers.length < 11) {
          _hasMore = false;
        }
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _page = 2;
      _users.clear();
      _hasMore = true;
    });

    await Future.delayed(Duration(milliseconds: 300));
    await _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Third Screen",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: _isLoading && _users.isEmpty
              ? Center(child: CircularProgressIndicator())
              : _users.isEmpty
                  ? Center(child: Text('No Data'))
                  : ListView.builder(
                      itemCount: _users.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _users.length) {
                          if (_hasMore) {
                            _loadUsers();
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text(''));
                          }
                        }

                        final user = _users[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(user.avatar),
                              ),
                              title: Text(
                                '${user.firstName} ${user.lastName}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: fontTheme,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                user.email.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: fontTheme,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context, user);
                              },
                            ),
                            Divider(
                              color: grey2,
                            )
                          ],
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
