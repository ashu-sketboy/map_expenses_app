import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modules/transaction.dart';

class Lists extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  Lists({@required this.transaction, @required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 50,
          child: Center(
            child: Text(
              '₹${transaction.amount}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          '${DateFormat.yMMMMEEEEd().format(transaction.date)}',
          style: TextStyle(fontSize: 15),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            deleteTransaction(transaction.id);
          },
        ),
      ),
    );
  }
}
