import 'package:flutter/material.dart';
import 'CafeMenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CafeMenu> menu = [
    CafeMenu(
        'Iced Pastel Matcha', 145, 'images/(iced)_pastel_matcha.jpg'),
    CafeMenu(
        'Iced Pastel Houjicha', 145, 'images/iced_pastel_houjicha.jpg'),
    CafeMenu(
        'Hot Pastel Houjicha', 130, 'images/(hot)_pastel_houjicha.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('เลือกเมนูเครื่องดื่ม')),
          body: ListView.builder(
              itemCount: menu.length,
              itemBuilder: (BuildContext context, int index) {
                CafeMenu drink = menu[index];
                return ListTile(
                  leading: Image.asset(drink.img),
                  title: Text(
                    drink.name,
                    style: TextStyle(fontSize: 30),
                  ),
                  subtitle: Text(
                    'ราคา' + drink.price.toString() + 'บาท',
                    style: TextStyle(fontSize: 24),
                  ));
              },
          )),
        theme: ThemeData(primarySwatch: Colors.green));
    }
  }
  

  List<Widget> getData(int count) {
    List<Widget> data = [];
    for (var i = 0; i < count; i++) {
      var menu = ListTile(
          title: Text('เมนูที่ ${i + 1}', style: TextStyle(fontSize: 25)),
          subtitle: Text('หัวข้อย่อยที่ ${i + 1}'));
      data.add(menu);
    }
    return data;
  }

