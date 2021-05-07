import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final double amt;
  final String day;
  final double spendingPct;

  ChartBars({this.amt, this.day, this.spendingPct});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text('₹${amt.toInt()}')),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Stack(
              children: [
                Container(
                  width: 18,
                  height: constraints.maxHeight * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  child: Container(
                    width: 12,
                    height: spendingPct.isNaN
                        ? 0
                        : spendingPct * (constraints.maxHeight * 0.7),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
              alignment: Alignment.bottomCenter,
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.1,
              child: Text('${day[0]}'),
            ),
          ],
        );
      },
    );
  }
}
