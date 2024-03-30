import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datch Call API"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          final user = users[index];
          final email = user["email"];
          final name = user["name"]['first'];
          final imageUrl = user["picture"]['thumbnail'];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(imageUrl),
            ),
            title: Text(name),
            subtitle: Text(email),
          );
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: callAPI,
        ),
    );
  }

  void callAPI() async{
    print("Calling API Now...");
    const url = "https://randomuser.me/api/?results=20";
    final uri = Uri.parse(url);
    final res = await http.get(uri);
    final body = res.body;
    final jsonRes = jsonDecode(body);
    setState(() {
      users = jsonRes['results'];
    });
    print("API called.");
  }
}