import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample/Models/UserData.dart';
import 'package:sample/features/authentication/screens/PeopleList/ListData.dart';

import '../../../../API/API_Methods.dart';
import '../../../../utils/constants/api_constants.dart';

class PeopleList extends StatefulWidget {
  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  List<User> users = [];
  List<User> filteredUsers = [];
  bool isLoading = true;
  commonApi apiRequest = commonApi();

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    final url = 'http://10.0.2.2:5064/api/user/getBirthdayForDays';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['isSuccess']) {
          setState(() {
            users = List<User>.from(data['data'].map((user) => User.fromJson(user)));
            filteredUsers = users; // Show all users by default
            isLoading = false;
          });
        } else {
          print('Error: ${data['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Failed to retrieve data')),
          );
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request failed with status: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }



  void filterUsers(String filter) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime tomorrow = today.add(Duration(days: 1));

    setState(() {
      if (filter == 'Yesterday') {
        //filteredUsers = users.where((user) => user.dateOfBirth.month == yesterday.month && user.dateOfBirth.day == yesterday.day).toList();
        filteredUsers = users.where((user) => _matchesDayAndMonth(user.dateOfBirth, yesterday)).toList();
      } else if (filter == 'Today') {
        filteredUsers = users.where((user) => _matchesDayAndMonth(user.dateOfBirth, today)).toList();
      } else if (filter == 'Tomorrow') {
        filteredUsers = users.where((user) => _matchesDayAndMonth(user.dateOfBirth, tomorrow)).toList();
      } else {
        filteredUsers = users;
      }
    });
  }

  bool _matchesDayAndMonth(String userDob, DateTime dateToMatch) {
    // Assuming userDob is in the format "dd-MM-yyyy"
    final userDobDate = DateTime.parse(_formatToIsoDate(userDob));
    return userDobDate.day == dateToMatch.day && userDobDate.month == dateToMatch.month;
  }

  String _formatToIsoDate(String dob) {
    // Convert "dd-MM-yyyy" to "yyyy-MM-dd" for DateTime parsing
    final parts = dob.split('-');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: const Text('Birthday List'),
        backgroundColor: Colors.purple[100],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['Yesterday', 'Today', 'Tomorrow']
                  .map((e) => Container(
                margin: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    filterUsers(e);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(e),
                ),
              ))
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Container(
                  margin:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(3, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
                      fit: BoxFit.cover,
                      width: 60,  // Adjust the width as needed
                      height: 60, // Adjust the height as needed
                    ),
                    title: Text(
                      user.userName,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(user.dateOfBirth),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BirthdayDetailPage(
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
