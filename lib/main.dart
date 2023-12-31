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
import 'package:seel_sms_reader/credit_card.dart';
import 'package:seel_sms_reader/emi_msg.dart';
import 'package:seel_sms_reader/main%20copy.dart';
import 'package:get/get.dart';
import 'package:seel_sms_reader/others.dart';
import 'package:seel_sms_reader/salary_screen.dart';

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
    return GetMaterialApp(
      title: 'Flutter SMS Inbox App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SEEL SMS'),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: ((context) {
                  //   return EmiMsg(messages: _messages);
                  // })));
                  Get.to(EmiMsg(messages: _messages));
                },
                icon: Icon(Icons.mobile_friendly_rounded))
          ],
        ),
        // body: Container(
        //     padding: const EdgeInsets.all(10.0),
        //     child: _messages.isNotEmpty
        //         ? _MessagesListView(
        //             messages: _messages,
        //           )
        //         : Center(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 ElevatedButton(
        //                     onPressed: () async {
        //                       print("Requesting SMS permission...");
        //                       var permission = await Permission.sms.request();
        //                       print("Permission status: $permission");

        //                       // var permission = await Permission.sms.status;
        //                       if (permission.isGranted) {
        //                         final messages = await _query.querySms(
        //                           kinds: [
        //                             SmsQueryKind.inbox,
        //                             SmsQueryKind.sent,
        //                           ],
        //                           // address: '+254712345789',
        //                           // count: 10,
        //                         );
        //                         debugPrint(
        //                             'sms inbox messages: ${messages.length}');

        //                         setState(() => _messages = messages);
        //                       } else {
        //                         await Permission.sms.request();
        //                       }
        //                       // Navigator.push(context,
        //                       //     MaterialPageRoute(builder: ((context) {
        //                       //   return EmiMsg(messages: _messages);
        //                       // })));
        //                     },
        //                     child: Text('Click Here To view Your EMI'))
        //               ],
        //             ),
        //           )),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(_MessagesListView(
                    messages: _messages,
                  ));
                },
                child: Text('View Your Balance')),
            ElevatedButton(
                onPressed: () {
                  Get.to(EmiMsg(
                    messages: _messages,
                  ));
                },
                child: Text('View Your Emi')),
            ElevatedButton(
                onPressed: () {
                  Get.to(CreditCard(
                    messages: _messages,
                  ));
                },
                child: Text('Credit Card')),
            ElevatedButton(
                onPressed: () {
                  Get.to(SalaryScreen(
                    messages: _messages,
                  ));
                },
                child: Text('Salary Card')),
            ElevatedButton(
                onPressed: () {
                  Get.to(OtherTransactions(
                    messages: _messages,
                  ));
                },
                child: Text('Others')),
          ],
        ),
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
double? extractAmountFromMessageCanaraUnionIdfc(String message) {
  final keywords = [
    'Avl Bal is INR ',
    'Total Avail.bal',
    'Your new balance',
    'Avail.bal INR',
    'Avl Bal',
    'INR',
    'Total Avail.bal INR',
  ];

  for (var keyword in keywords) {
    final startIndex = message.indexOf(keyword);
    // final endIndex = message.indexOf('on 24-Jul');
    if (startIndex != -1) {
      // final remainingText = message.substring(startIndex + keyword.length);
      print(message);
      final remainingText = message.substring(startIndex + keyword.length);
      final cleanedText = remainingText.replaceAll(',', ''); // Remove commas
      final parts = cleanedText.split(RegExp(r'[^0-9]'));

      // Filter out empty parts and pick the numeric part nearest to the keyword
      final numericParts = parts.where((part) => part.isNotEmpty).toList();
      if (numericParts.isNotEmpty) {
        // Join numeric parts and attempt to parse the formatted amount
        final formattedAmount = numericParts.join('.');
        return double.tryParse(formattedAmount);
      }
    }
  }

  return null;
}

//ICICI BANK
double? extractAmountFromMessageIcici(String message) {
  final keyword = 'Avl Bal is INR ';
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

// For DCB bank
double? extractAmountFromMessageDcb(String message) {
  final keyword = 'Avail Bal is INR ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(' ');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

// for kotak
// double? extractAmountFromMessageKotak(String message) {
//   final keyword = 'Bal:';
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

double? extractAmountFromMessageKotak(String message) {
  if (message.contains('Bal:')) {
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
  } else if (message.contains('Avl Bal Rs.')) {
    final keyword = 'Avl Bal Rs.';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf(' ');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  } else if (message.contains('Received')) {
    final keyword = 'Bal.Rs.';
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
  } else if (message.contains('IMPS')) {
    final keyword = 'Avl.Bal.Rs.';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf('');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  } else if (message.contains('NEFT')) {
    final keyword = 'AVAIL. BAL.:Rs ';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf('K');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  }

  return null;
}

// double? extractAmountFromMessageKotak(String message) {
//   if (message.contains('Avl Bal Rs.')) {
//     final keyword = 'Avl Bal Rs.';
//     final startIndex = message.indexOf(keyword);

//     if (startIndex != -1) {
//       final remainingText = message.substring(startIndex + keyword.length);
//       final endIndex = remainingText.indexOf(' ');

//       if (endIndex != -1) {
//         final balanceText = remainingText.substring(0, endIndex);
//         final cleanedText = balanceText.replaceAll(',', '');
//         return double.tryParse(cleanedText);
//       }
//     }
//   }

//   return null;
// }

//for bcb bank
double? extractAmountFromMessageBcb(String message) {
  final keyword = 'AVLBL BAL Rs.';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(',');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

// for saraswat bank
double? extractAmountFromMessageSaraswat(String message) {
  final keyword = 'Current Bal is INR';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf('CR');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

// for svc bank
double? extractAmountFromMessageSvc(String message) {
  final keyword = 'Clr Bal.Rs';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf('Cr.');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

// For hdfc bank
double? extractAmountFromMessageHdfc(String message) {
  if (message.contains('Avl bal: INR')) {
    final keyword = 'Avl bal: INR';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf('.');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  } else if (message.contains('Avl bal:')) {
    final keyword = 'Avl bal:';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf('Not');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  }

  return null;
}

// Maharastra bank
double? extractAmountFromMessageMaha(String message) {
  final keyword = 'A/c Bal is INR ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(' ');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

//axis bank
double? extractAmountFromMessageAxis(String message) {
  final keyword = 'Bal INR ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf('SMS');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

// DNS BAnk
double? extractAmountFromMessageDns(String message) {
  final keyword = 'Bal is INR ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(' .');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

// calculating salary
double? extractSalaryFromKotak(String message) {
  if (message.contains('IMPS')) {
    final keyword = 'Received Rs. ';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf('on');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  }
  if (message.contains('NEFT')) {
    final keyword = 'Rs ';
    final startIndex = message.indexOf(keyword);

    if (startIndex != -1) {
      final remainingText = message.substring(startIndex + keyword.length);
      final endIndex = remainingText.indexOf('c');

      if (endIndex != -1) {
        final balanceText = remainingText.substring(0, endIndex);
        final cleanedText = balanceText.replaceAll(',', '');
        return double.tryParse(cleanedText);
      }
    }
  }

  return null;
}

double? extractSalaryFromHdfc(String message) {
  final keyword = 'INR ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf('is');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

double? extractSalaryFromUnion(String message) {
  final keyword = 'Credited for Rs:';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(' ');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
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
    double? recentAmountUnion;
    double? recentAmountCanara;
    double? recentAmountSaraswat;
    double? recentAmountBcb;
    double? recentAmountKotak;
    double? recentAmountIcici;
    double? recentAmountDcb;
    double? recentAmountIdfc;
    double? recentAmountSvc;
    double? recentAmountHdfc;
    double? recentAmountMaharastra;
    double? recentAmountAxis;
    double? recentAmountDns;

    List<String> onlyBankMessage = [];
    List<dynamic> salaryAmount = [];

// this loop will add only bank message and filter other message
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('bank')) {
        onlyBankMessage.add(message.body!.toLowerCase());
        print('adding bank sms');
      }
    }
// for separating bank
    List<String> unionBankMessage = [];
    List<String> canaraBankMessage = [];
    for (var message in onlyBankMessage) {
      if (message.contains('union')) {
        unionBankMessage.add(message);
        print('adding msg to union bank message');
      } else if (message.contains('canara')) {
        canaraBankMessage.add(message);
        print('adding msg to canara bank message');
      }
    }
// for separarting balance message only from message of same bank
    List<String> unionBankBalanceMessage = [];
    List<String> canaraBankBalanceMessage = [];
    // for (var message in unionBankMessage) {
    //   if (message.contains('union')) {
    //     unionBankBalanceMessage.add(message);
    //     recentAmountUnion = extractAmountFromMessageCanaraUnionIdfc(message);
    //     print(recentAmountUnion);
    //     print(message);
    //     break;
    //   }
    // }
    // for (var message in canaraBankMessage) {
    //   if (message.contains('canara')) {
    //     canaraBankBalanceMessage.add(message);
    //     recentAmountCanara =
    //         extractAmountFromMessageCanaraUnionIdfc(message.toString());
    //     print(recentAmountCanara);
    //     print(message);
    //     break;
    //   }
    // }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('union')) {
        if (message.body!.toLowerCase().contains('avl bal rs')) {
          recentAmountUnion =
              extractAmountFromMessageCanaraUnionIdfc(message.body.toString());
          print(message.body.toString());
          break; // Stop iterating once the first "union" message is found
        }
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('saraswat') &&
          message.body!.toLowerCase().contains('current bal is inr')) {
        recentAmountSaraswat =
            extractAmountFromMessageSaraswat(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('canara') &&
          message.body!.toLowerCase().contains('avail.bal inr')) {
        recentAmountCanara =
            extractAmountFromMessageCanaraUnionIdfc(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('bcb') &&
          message.body!.toLowerCase().contains('avlbl bal rs')) {
        recentAmountBcb = extractAmountFromMessageBcb(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('kotak bank') &&
          message.body!.toLowerCase().contains('bal')) {
        recentAmountKotak =
            extractAmountFromMessageKotak(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }

    for (var message in messages) {
      if (message.body!.toLowerCase().contains('icici') &&
          message.body!.toLowerCase().contains('avl bal is inr')) {
        recentAmountIcici =
            extractAmountFromMessageIcici(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('dcb') &&
          message.body!.toLowerCase().contains('avail bal is inr')) {
        recentAmountDcb = extractAmountFromMessageDcb(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('idfc') &&
          message.body!.toLowerCase().contains('your new balance is inr')) {
        recentAmountIdfc =
            extractAmountFromMessageCanaraUnionIdfc(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('svc') &&
          message.body!.toLowerCase().contains('clr bal.rs')) {
        recentAmountSvc = extractAmountFromMessageSvc(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('hdfc') &&
          message.body!.toLowerCase().contains('avl bal: inr')) {
        recentAmountHdfc =
            extractAmountFromMessageHdfc(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      } else if (message.body!.toLowerCase().contains('hdfc') &&
          message.body!.toLowerCase().contains('avl bal:')) {
        recentAmountHdfc =
            extractAmountFromMessageHdfc(message.body.toString());
        print(message.body.toString());
        break;
      }
    }

    for (var message in messages) {
      if (message.body!.toLowerCase().contains('mahabank') &&
          message.body!.toLowerCase().contains('a/c bal is ')) {
        recentAmountMaharastra =
            extractAmountFromMessageMaha(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('axis') &&
          message.body!.toLowerCase().contains('bal inr ')) {
        recentAmountAxis =
            extractAmountFromMessageAxis(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('dns') &&
          message.body!.toLowerCase().contains('bal')) {
        recentAmountDns = extractAmountFromMessageDns(message.body.toString());
        print(message.body.toString());
        break; // Stop iterating once the first "union" message is found
      }
    }

    // To count salary
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('salary') ||
          message.body!.toLowerCase().contains('imps') ||
          message.body!.toLowerCase().contains('neft')) {
        if (message.body!.toLowerCase().contains('hdfcp')) {
          salaryAmount.add(extractSalaryFromHdfc(message.body.toString()));
        }
        if (message.body!.toLowerCase().contains('kotak')) {
          salaryAmount.add(extractSalaryFromKotak(message.body.toString()));
          print(message.body.toString());
        }
        if (message.body!.toLowerCase().contains('union')) {
          salaryAmount.add(extractSalaryFromUnion(message.body.toString()));
          print(message.body.toString());
        }
      }
    }
    print(salaryAmount);
    double maxSalary = 0.0;
    for (int i = 0; i < salaryAmount.length; i++) {
      var salary = salaryAmount[i];
      if (salary == null) {
        continue;
      } else if (maxSalary < salary) {
        maxSalary = salary;
      }
    }

    print(maxSalary);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Sms Balance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: messages.length,
            //   itemBuilder: (BuildContext context, int i) {
            //     var message = messages[i];
            //     // if (message.body!.toLowerCase().contains('debit') ||
            //     //     message.body!.toLowerCase().contains('credit'))
            //     if (message.body!.toLowerCase().contains('saraswat') && !shouldStop)
            //     // if (message.body!.toLowerCase().contains('your salary has been'))

            //     {
            //       shouldStop = true;
            //       // messages.clear();
            //       // amountRecent = extractAmountFromMessage(message.body)!;

            //       return ListTile(
            //         title: Text('${message.sender} [${message.date}]'),
            //         subtitle: Text('${message.body}'),
            //       );
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
            // Text(
            //   'Your Updated Balance: ${recentAmountCanara ?? "N/A"} ${recentAmountUnion} ${recentAmountSaraswat}',
            //   style: TextStyle(fontSize: 18),
            // ),

            Visibility(
              visible: recentAmountUnion != null,
              child: ListTile(
                title: Text('Union Bank Balance'),
                subtitle: Text(
                    'Amount: ₹${recentAmountUnion?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),

            Visibility(
              visible: recentAmountCanara != null,
              child: ListTile(
                title: Text('Canara Bank Balance'),
                subtitle:
                    Text('Amount: ₹${recentAmountCanara?.toStringAsFixed(2)}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountSaraswat != null,
              child: ListTile(
                title: Text('Saraswat Bank Balance'),
                subtitle: Text(
                    'Amount: ₹${recentAmountSaraswat?.toStringAsFixed(2)}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountBcb != null,
              child: ListTile(
                title: Text('Bharat Bank Balance'),
                subtitle:
                    Text('Amount: ₹${recentAmountBcb?.toStringAsFixed(2)}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountKotak != null,
              child: ListTile(
                title: Text('Kotak Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountKotak}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountIcici != null,
              child: ListTile(
                title: Text('Icici Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountIcici}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountDcb != null,
              child: ListTile(
                title: Text('Dcb Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountDcb}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountIdfc != null,
              child: ListTile(
                title: Text('Idfc Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountIdfc}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountSvc != null,
              child: ListTile(
                title: Text('Svc Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountSvc}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountHdfc != null,
              child: ListTile(
                title: Text('Hdfc Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountHdfc}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountMaharastra != null,
              child: ListTile(
                title: Text('Maharastra Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountMaharastra}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountAxis != null,
              child: ListTile(
                title: Text('Axis Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountAxis}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: recentAmountDns != null,
              child: ListTile(
                title: Text('Dns Bank Balance'),
                subtitle: Text('Amount: ₹${recentAmountDns}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
