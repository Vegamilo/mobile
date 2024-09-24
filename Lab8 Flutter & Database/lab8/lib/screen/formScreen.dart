import 'package:flutter/material.dart';
import 'package:lab8/provider/transcation_provider.dart';
import 'package:provider/provider.dart';

import '../model/transcation.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  FormScreen({super.key});
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 99, 132, 182),
        title: Text('เพิ่มข้อมูล'),
      ),
      body: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              decoration: new InputDecoration(labelText: "ชื่อรายการ"),
              autofocus: true,
              controller: titleController,
              validator: (String? str) {
                if (str == '') return "กรุณาป้อนชื่อรายการ";
                return null;
              },
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "จำนวนเงิน"),
              keyboardType: TextInputType.number,
              controller: amountController,
              validator: (String? str) {
                if (str!.isEmpty) return "กรุณาป้อนจำนวนเงิน";
                if (double.parse(str.toString()) <= 0)
                  return "กรุณาป้อนตัวเลขมากกว่า 0";
                return null;
              },
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var title = titleController.text;
                  var amount = amountController.text;
                  Transactions statement = Transactions(
                      title: title,
                      amount: double.parse(amount),
                      date: DateTime.now());
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);
                  Navigator.pop(context);
                }
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Text("บันทึก"),
            )
          ])),
    );
  }
}
