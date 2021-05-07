import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cart_bars.dart';
import '../modules/transaction.dart';

class Bars extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Bars({this.recentTransaction});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalOfDay = 0;

      for (var i in recentTransaction) {
        if (i.date.day == weekDays.day &&
            i.date.month == weekDays.month &&
            i.date.year == weekDays.year) {
          totalOfDay += i.amount;
        }
      }

      return {
        'day': '${DateFormat.E().format(weekDays)}',
        'amount': totalOfDay
      };
    });
  }

  double get maxSpanding {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: groupedTransactionValues.map((e) {
        return ChartBars(
          amt: e['amount'],
          day: e['day'],
          spendingPct: (e['amount'] as double) / maxSpanding,
        );
      }).toList(),
    );
  }
}
