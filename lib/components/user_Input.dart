import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {
  final Function func;

  UserInput({this.func});

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final title = TextEditingController();
  final amount = TextEditingController();

  DateTime dateHolder = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          tField("Expense Name", TextInputType.text, title),
          SizedBox(
            height: 14,
          ),
          tField("Amount", TextInputType.number, amount),
          SizedBox(
            height: 18,
          ),
          datePicker(context),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              widget.func(title.text, amount.text, dateHolder);
            },
            child: Text(
              "Add Transaction",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget datePicker(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${DateFormat.yMEd().format(dateHolder)}"),
        ElevatedButton(
          onPressed: () {
            _selectDate(ctx);
          },
          child: Text('Select Date'),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateHolder,
      firstDate: DateTime(2000),
      lastDate: DateTime(2022),
    );

    if (picked != null && picked != dateHolder)
      setState(() {
        dateHolder = picked;
      });
  }

  Widget tField(
      String title, TextInputType textInput, TextEditingController control) {
    InputDecoration inputDeco = InputDecoration(
      hintText: title,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
    );

    return TextField(
      keyboardType: textInput,
      decoration: inputDeco,
      // onChanged: func,
      controller: control,
    );
  }
}
