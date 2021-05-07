import 'package:flutter/material.dart';

import 'components/lists.dart';
import 'components/user_Input.dart';
import 'components/bars.dart';

import 'modules/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.redAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showChart = false;

  // Bottom Sheet
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Card(
            elevation: 12,
            child: UserInput(
              func: _addNewTransaction,
            ),
          );
        });
  }

  // var that hold transactions
  List<Transaction> _transaction = [
    Transaction(id: "1", title: "Shoes", amount: 100, date: DateTime.now()),
    Transaction(
        id: "2",
        title: "T-shirt",
        amount: 300,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: "3", title: "shirt", amount: 500, date: DateTime.now()),
    Transaction(
        id: "4",
        title: "Jeans",
        amount: 800,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: "5",
        title: "Watch",
        amount: 2300,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: "6",
        title: "T-shirt",
        amount: 300,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: "7",
        title: "T-shirt",
        amount: 300,
        date: DateTime.now().subtract(Duration(days: 5))),
  ];

  List<Transaction> get _recentTransactions {
    return _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // function to add Transactions
  void _addNewTransaction(String title, String amount, DateTime dt) {
    if (title.isEmpty || int.parse(amount) < 0) {
      return;
    }
    Transaction t = Transaction(
        id: '${dt}', title: title, amount: int.parse(amount), date: dt);

    setState(() {
      _transaction.add(t);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  Widget showImage(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: constraints.maxHeight * 0.7,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: constraints.maxHeight * .1),
            Container(
              height: constraints.maxHeight * .2,
              child: Text(
                "!! No Transaction...",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Personal Expense',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            })
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    })
              ],
            ),
          if (!_isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .3,
              child: Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Bars(
                    recentTransaction: _recentTransactions,
                  ),
                ),
                elevation: 10,
              ),
            ),
          if (!_isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: _transaction.isEmpty
                  ? showImage(context)
                  : ListView.builder(
                      itemCount: _transaction.length,
                      itemBuilder: (context, int i) {
                        return Card(
                          elevation: 8,
                          child: Lists(
                            transaction: _transaction[i],
                            deleteTransaction: _deleteTransaction,
                          ),
                        );
                      },
                    ),
            ),
          if (_isLandscape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        .8,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Bars(
                          recentTransaction: _recentTransactions,
                        ),
                      ),
                      elevation: 10,
                    ),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.8,
                    child: _transaction.isEmpty
                        ? showImage(context)
                        : ListView.builder(
                            itemCount: _transaction.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                elevation: 8,
                                child: Lists(
                                  transaction: _transaction[i],
                                  deleteTransaction: _deleteTransaction,
                                ),
                              );
                            },
                          ),
                  ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
