import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello',
        home: MyHomePage(),
        theme: ThemeData(primarySwatch: Colors.green));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int number = 0;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(
          child: Column(
        children: [
          Text('Joy To The World',
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 158, 63, 25))),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Make a wish')),
          ElevatedButton(
              onPressed: () {},
              child: Text('Send'),
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  backgroundColor: Color.fromARGB(255, 63, 107, 63),
                  foregroundColor: Color.fromARGB(255, 247, 240, 235))),
          Text('Count Down',
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 167, 43, 34))),
          Text(number.toString(),
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 187, 67, 59))),
          Image(
              image: NetworkImage(
                  'https://scontent-bkk1-1.xx.fbcdn.net/v/t39.30808-6/263291578_3027578770815974_8425522409393041706_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=524774&_nc_ohc=9nMSmBQrh38AX8fIiWC&_nc_ht=scontent-bkk1-1.xx&oh=00_AfAAuWVQyQci2XfYpdtEJ_GO-bnJOpoCoo8fX38JlqbEkA&oe=658D8A93'))
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              number--;
            });
          },
          child: Icon(Icons.ac_unit)),
    );
  }
}
