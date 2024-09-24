import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab8/provider/transcation_provider.dart';
import 'package:lab8/screen/formScreen.dart';
import 'package:provider/provider.dart';

import 'model/transcation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return TransactionProvider();
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'แอปรายจ่าย'),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormScreen();
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Consumer(builder: (context, TransactionProvider provider, child) {
        return ListView.builder(
            itemCount: provider.transactions.length,
            itemBuilder: (context, int index) {
              Transactions data = provider.transactions[index];
              return Card(
                elevation: 5,
                //margin: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text(data.amount.toString()),
                    ),
                  ),
                  title: Text(data.title),
                  subtitle:
                      Text(DateFormat("dd/MM/yyyy HH:mm:ss").format(data.date)),
                ),
              );
            });
      }),
    );
  }
}
