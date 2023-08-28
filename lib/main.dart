import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
  }

  void analyzeSpendings() {
    _categories.clear();

    for (var message in _messages) {
      var amount = extractAmountFromMessage(message.body!.toLowerCase());
      print(message.body!.toLowerCase());
      if (amount != null) {
        var category = getCategoryFromMessage(message.body!.toLowerCase());

        var existingCategory = _categories.firstWhere(
          (cat) => cat.name == category.name.toLowerCase(),
          orElse: () =>
              Category(name: category.name, amount: 0, icon: category.icon),
        );
        existingCategory.amount += amount;
        _categories.removeWhere((cat) => cat.name == category.name);
        _categories.add(existingCategory);
      }
    }

    setState(() {});
  }

  double? extractAmountFromMessage(String? message) {
    var regex = RegExp(r'(\d+\.\d{2})');
    var match = regex.firstMatch(message ?? '');
    return match != null ? double.tryParse(match.group(0) ?? '0') : null;
  }

  Category getCategoryFromMessage(String? message) {
    if (message != null) {
      message = message
          .toLowerCase(); // Convert message to lowercase for case-insensitive matching

      if (message.contains('slice')) {
        return Category(name: 'Slice', amount: 0, icon: Icons.local_pizza);
      } else if (message.contains('kfc')) {
        return Category(name: 'KFC', amount: 0, icon: Icons.fastfood);
      } else if (message.contains('food')) {
        return Category(name: 'Food', amount: 0, icon: Icons.restaurant);
      } else if (message.contains('salary')) {
        return Category(name: 'Salary', amount: 0, icon: Icons.attach_money);
      } else if (message.contains('credited')) {
        return Category(name: 'Credited', amount: 0, icon: Icons.credit_card);
      } else if (message.contains('myntra')) {
        return Category(name: 'Myntra', amount: 0, icon: Icons.shopping_bag);
      } else if (message.contains('flipkart')) {
        return Category(name: 'Flipkart', amount: 0, icon: Icons.shopping_cart);
      } else if (message.contains('swiggy') || message.contains('zomato')) {
        return Category(
            name: 'Food Delivery', amount: 0, icon: Icons.delivery_dining);
      } else if (message.contains('emi') || message.contains('loan')) {
        return Category(
            name: 'EMI/Loan', amount: 0, icon: Icons.monetization_on);
      } else if (message.contains('debited')) {
        return Category(
            name: 'Debited', amount: 0, icon: Icons.monetization_on);
      } else if (message.contains('received')) {
        return Category(
            name: 'Received', amount: 0, icon: Icons.monetization_on);
      } else if (message.contains('union')) {
        return Category(name: 'Union', amount: 0, icon: Icons.monetization_on);
      }
      // Add more conditions for bank-related keywords
      else if (message.contains('xcf') || message.contains('upi')) {
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        print('harsh The game');
        print(message);
        return Category(
            name: 'State Bank of India',
            amount: 0,
            icon: Icons.monetization_on);
      } else if (message.contains('icici')) {
        return Category(
            name: 'ICICI Bank', amount: 0, icon: Icons.monetization_on);
      }
    }

    return Category(name: 'Other', amount: 0, icon: Icons.category);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SMS Inbox App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Seel SMS Inbox Example'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: _categories.isNotEmpty
              ? _MessagesListView(
                  categories: _categories,
                )
              : Center(
                  child: Text(
                    'No spendings to show. Tap the refresh button...',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var permission = await Permission.sms.status;
            if (permission.isGranted) {
              final messages = await _query.querySms(
                kinds: [
                  SmsQueryKind.inbox,
                  SmsQueryKind.sent,
                ],
              );

              setState(() {
                _messages = messages;
                analyzeSpendings();
              });
            } else {
              await Permission.sms.request();
            }
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class Category {
  final String name;
  double amount;
  final IconData? icon;

  Category({required this.name, required this.amount, this.icon});
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int i) {
        var category = categories[i];

        return ListTile(
          title: Text('${category.name}'),
          subtitle: Text('Amount: ₹${category.amount.toStringAsFixed(2)}'),
          leading: category.icon != null ? Icon(category.icon) : null,
        );
      },
    );
  }
}
