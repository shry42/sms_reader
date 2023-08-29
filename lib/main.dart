// import 'package:flutter/material.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:seel_sms_reader/sms_check2.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// enum TransactionType {
//   credit,
//   debit,
// }

// class _MyAppState extends State<MyApp> {
//   final SmsQuery _query = SmsQuery();
//   List<SmsMessage> _messages = [];
//   List<Category> _categories = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void analyzeSpendings() {
//     _categories.clear();

//     for (var message in _messages) {
//       var amount = extractAmountFromMessage(message.body!.toLowerCase());
//       print(message.body!.toLowerCase());
//       if (amount != null) {
//         var category = getCategoryFromMessage(message.body!.toLowerCase());

//         var existingCategory = _categories.firstWhere(
//           (cat) => cat.name == category.name.toLowerCase(),
//           orElse: () =>
//               Category(name: category.name, amount: 0, icon: category.icon),
//         );
//         existingCategory.amount += amount;
//         _categories.removeWhere((cat) => cat.name == category.name);
//         _categories.add(existingCategory);
//       }
//     }

//     setState(() {});
//   }

//   double? extractAmountFromMessage(String? message) {
//     var regex = RegExp(r'(\d+\.\d{2})');
//     var match = regex.firstMatch(message ?? '');
//     return match != null ? double.tryParse(match.group(0) ?? '0') : null;
//   }

//   Category getCategoryFromMessage(String? message) {
//     if (message != null) {
//       message = message
//           .toLowerCase(); // Convert message to lowercase for case-insensitive matching

//       if (message.contains('slice')) {
//         return Category(name: 'Slice', amount: 0, icon: Icons.local_pizza);
//       } else if (message.contains('kfc')) {
//         return Category(name: 'KFC', amount: 0, icon: Icons.fastfood);
//       } else if (message.contains('food')) {
//         return Category(name: 'Food', amount: 0, icon: Icons.restaurant);
//       } else if (message.contains('salary')) {
//         return Category(name: 'Salary', amount: 0, icon: Icons.attach_money);
//       } else if (message.contains('credited')) {
//         return Category(name: 'Credited', amount: 0, icon: Icons.credit_card);
//       } else if (message.contains('myntra')) {
//         return Category(name: 'Myntra', amount: 0, icon: Icons.shopping_bag);
//       } else if (message.contains('flipkart')) {
//         return Category(name: 'Flipkart', amount: 0, icon: Icons.shopping_cart);
//       } else if (message.contains('swiggy') || message.contains('zomato')) {
//         return Category(
//             name: 'Food Delivery', amount: 0, icon: Icons.delivery_dining);
//       } else if (message.contains('emi') || message.contains('loan')) {
//         return Category(
//             name: 'EMI/Loan', amount: 0, icon: Icons.monetization_on);
//       } else if (message.contains('debited')) {
//         return Category(
//             name: 'Debited', amount: 0, icon: Icons.monetization_on);
//       } else if (message.contains('received')) {
//         return Category(
//             name: 'Received', amount: 0, icon: Icons.monetization_on);
//       } else if (message.contains('union')) {
//         return Category(name: 'Union', amount: 0, icon: Icons.monetization_on);
//       }
//       // Add more conditions for bank-related keywords
//       else if (message.contains('360625570975')) {
//         return Category(name: 'Unions', amount: 0, icon: Icons.monetization_on);
//       } else if (message.contains('xcf') || message.contains('upi')) {
//         return Category(
//             name: 'State Bank of India',
//             amount: 0,
//             icon: Icons.monetization_on);
//       } else if (message.contains('icici')) {
//         return Category(
//             name: 'ICICI Bank', amount: 0, icon: Icons.monetization_on);
//       }
//     }

//     return Category(name: 'Other', amount: 0, icon: Icons.category);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter SMS Inbox App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Seel SMS Inbox Example'),
//         ),
//         body: Container(
//           padding: const EdgeInsets.all(10.0),
//           child: _categories.isNotEmpty
//               ? _MessagesListView(
//                   categories: _categories,
//                 )
//               : Center(
//                   child: Text(
//                     'No spendings to show. Tap the refresh button...',
//                     style: Theme.of(context).textTheme.headline6,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             var permission = await Permission.sms.status;
//             if (permission.isGranted) {
//               final messages = await _query.querySms(
//                 kinds: [
//                   SmsQueryKind.inbox,
//                   SmsQueryKind.sent,
//                 ],
//               );

//               setState(() {
//                 _messages = messages;
//                 analyzeSpendings();
//               });
//             } else {
//               await Permission.sms.request();
//             }
//           },
//           child: const Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }

// class Category {
//   final String name;
//   double amount;
//   final IconData? icon;

//   Category({required this.name, required this.amount, this.icon});
// }

// class _MessagesListView extends StatelessWidget {
//   const _MessagesListView({
//     Key? key,
//     required this.categories,
//   }) : super(key: key);

//   final List<Category> categories;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: categories.length,
//       itemBuilder: (BuildContext context, int i) {
//         var category = categories[i];

//         return ListTile(
//           title: Text('${category.name}'),
//           subtitle: Text('Amount: ₹${category.amount.toStringAsFixed(2)}'),
//           leading: category.icon != null ? Icon(category.icon) : null,
//         );
//       },
//     );
//   }
// }

import 'dart:developer';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SMS Inbox App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SMS Inbox Example'),
        ),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            child: _messages.isNotEmpty
                ? _MessagesListView(
                    messages: _messages,
                  )
                // : Center(
                //     child: Text(
                //       'No messages to show.\n Tap refresh button...',
                //       style: Theme.of(context).textTheme.headlineSmall,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            for (var element in _messages) {
                              if (containsTransaction(element.body ?? '')) {
                                log('>> ${element.body}');
                                // log('>=> ${extractAmountFromMessage(element.body)}');
                                List<String> splits =
                                    (element.body ?? '').split(' ');
                                String amount = '';
                                int index = 0;
                                for (int i = 0; i < splits.length; i++) {
                                  if (splits[i].toLowerCase().contains('rs') ||
                                      splits[i].toLowerCase().contains('rs.')) {
                                    amount = splits[i];
                                    index = i;
                                    break;
                                  }
                                }
                                if (containsNumber(amount) == false) {
                                  amount = splits[index + 1];
                                }
                                log('>=> $amount');
                              }

                              // log('>> ${element.body}');
                            }
                          },
                          child: const Text('Here'),
                        ),
                      ],
                    ),
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print("Requesting SMS permission...");
            var permission = await Permission.sms.request();
            print("Permission status: $permission");

            // var permission = await Permission.sms.status;
            if (permission.isGranted) {
              final messages = await _query.querySms(
                kinds: [
                  SmsQueryKind.inbox,
                  SmsQueryKind.sent,
                ],
                // address: '+254712345789',
                // count: 10,
              );
              debugPrint('sms inbox messages: ${messages.length}');

              setState(() => _messages = messages);
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

bool containsTransaction(String msg) {
  if (msg.toLowerCase().contains('rs')) {
    return true;
  }
  if (msg.toLowerCase().contains('debited')) {
    return true;
  }
  if (msg.toLowerCase().contains('debit')) {
    return true;
  }
  if (msg.toLowerCase().contains('credited')) {
    return true;
  }
  if (msg.toLowerCase().contains('credit')) {
    return true;
  }
  if (msg.toLowerCase().contains('inr')) {
    return true;
  }
  return false;
}

bool containsNumber(String str) {
  List<String> sps = str.split('');
  bool hasNum = false;
  for (String t in sps) {
    if (RegExp(r'^[0-9]+$').hasMatch(t)) {
      hasNum = true;
      break;
    }
  }
  return hasNum;
}
// Not working
// double? extractAmountFromMessage(String? message) {
//   var regex = RegExp(r'(\d+\.\d{2})');
//   var match = regex.firstMatch(message ?? '');
//   return match != null ? double.tryParse(match.group(0) ?? '0') : null;
// }

// Not working
// double? extractAmountFromMessage(String? message) {
//   // var regex = RegExp(r'Avl\s*Bal\s*Rs:\s*(\d+\.\d{2})', caseSensitive: false);
//   var regex = RegExp(r'Avail\.bal\s*INR\s*(\d+\.\d{2})', caseSensitive: false);
//   var match = regex.firstMatch(message ?? '');
//   return match != null ? double.tryParse(match.group(1) ?? '0') : null;
// }

// Not working
// double? extractAmountFromMessage(String message) {
//   final keywords = ['Total Avail.bal', 'Avail.bal INR'];
//   for (var keyword in keywords) {
//     final startIndex = message.indexOf(keyword);
//     if (startIndex != -1) {
//       final remainingText = message.substring(startIndex + keyword.length);
//       final parts = remainingText.split(RegExp(r'[^0-9.]'));

//       for (var part in parts) {
//         if (part.isNotEmpty) {
//           return double.tryParse(part);
//         }
//       }
//     }
//   }
//   return null;
// }
// Not wokring
// double? extractAmountFromMessage(String message) {
//   final keywords = ['Total Avail.bal', 'Avail.bal INR','Avl Bal','INR'];
//   for (var keyword in keywords) {
//     final startIndex = message.indexOf(keyword);
//     if (startIndex != -1) {
//       final remainingText = message.substring(startIndex + keyword.length);
//       final cleanedText = remainingText.replaceAll(',', ''); // Remove commas
//       final parts = cleanedText.split(RegExp(r'[^0-9.]'));

//       for (var part in parts) {
//         if (part.isNotEmpty) {
//           return double.tryParse(part);
//         }
//       }
//     }
//   }
//   return null;
// }


// For canana,union,idfc bank
// double? extractAmountFromMessage(String message) {
//   final keywords = [
//     'Avl Bal is INR ',
//     'Total Avail.bal',
//     'Your new balance',
//     'Avail.bal INR',
//     'Avl Bal',
//     'INR',
//     'Total Avail.bal INR',
//   ];

//   for (var keyword in keywords) {
//     final startIndex = message.indexOf(keyword);
//     // final endIndex = message.indexOf('on 24-Jul');
//     if (startIndex != -1) {
//       // final remainingText = message.substring(startIndex + keyword.length);
//       print(message);
//       final remainingText = message.substring(startIndex + keyword.length);
//       final cleanedText = remainingText.replaceAll(',', ''); // Remove commas
//       final parts = cleanedText.split(RegExp(r'[^0-9]'));

//       // Filter out empty parts and pick the numeric part nearest to the keyword
//       final numericParts = parts.where((part) => part.isNotEmpty).toList();
//       if (numericParts.isNotEmpty) {
//         // Join numeric parts and attempt to parse the formatted amount
//         final formattedAmount = numericParts.join('.');
//         return double.tryParse(formattedAmount);
//       }
//     }
//   }

//   return null;
// }

//ICICI BANK
// double? extractAmountFromMessage(String message) {
//   final keyword = 'Avl Bal is INR ';
//   final startIndex = message.indexOf(keyword);

//   if (startIndex != -1) {
//     final remainingText = message.substring(startIndex + keyword.length);
//     final endIndex = remainingText.indexOf('.');

//     if (endIndex != -1) {
//       final balanceText = remainingText.substring(0, endIndex + 3);
//       final cleanedText = balanceText.replaceAll(',', '');
//       return double.tryParse(cleanedText);
//     }
//   }

//   return null;
// }
// For DCB bank
// double? extractAmountFromMessage(String message) {
//   final keyword = 'Avail Bal is INR ';
//   final startIndex = message.indexOf(keyword);

//   if (startIndex != -1) {
//     final remainingText = message.substring(startIndex + keyword.length);
//     final endIndex = remainingText.indexOf(' ');

//     if (endIndex != -1) {
//       final balanceText = remainingText.substring(0, endIndex);
//       final cleanedText = balanceText.replaceAll(',', '');
//       return double.tryParse(cleanedText);
//     }
//   }

//   return null;
// }

// for kotak
double? extractAmountFromMessage(String message) {
  final keyword = 'Bal:';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf('.');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex + 3);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    double? recentAmount;

    for (var message in messages) {
      if (message.body!.toLowerCase().contains('kotak bank')) {
        recentAmount = extractAmountFromMessage(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: messages.length,
    //   itemBuilder: (BuildContext context, int i) {
    //     var message = messages[i];

    //     return ListTile(
    //       title: Text('${message.sender} [${message.date}]'),
    //       subtitle: Text('${message.body}'),
    //     );
    //   },
    // );
    bool shouldStop = false;
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int i) {
            var message = messages[i];
            // if (message.body!.toLowerCase().contains('debit') ||
            //     message.body!.toLowerCase().contains('credit'))
            if (message.body!.toLowerCase().contains('kotak bank') &&
                !shouldStop)
            // if (message.body!.toLowerCase().contains('your salary has been'))

            {
              shouldStop = true;
              // messages.clear();
              // amountRecent = extractAmountFromMessage(message.body)!;

              return ListTile(
                title: Text('${message.sender} [${message.date}]'),
                subtitle: Text('${message.body}'),
              );
            } else {
              return Container();
            }
          },
        ),
        Text(
          'Your Updated Balance: ${recentAmount ?? "N/A"}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
