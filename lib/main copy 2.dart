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
            child:
                // _messages.isNotEmpty
                //     ? _MessagesListView(
                //         messages: _messages,
                //       )
                //     // : Center(
                //     //     child: Text(
                //     //       'No messages to show.\n Tap refresh button...',
                //     //       style: Theme.of(context).textTheme.headlineSmall,
                //     //       textAlign: TextAlign.center,
                //     //     ),
                //     //   ),
                //     :
                Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      for (var element in _messages) {
                        if (containsTransaction(element.body ?? '')) {
                          log('>> ${element.body}');
                          // log('>=> ${extractAmountFromMessage(element.body)}');
                          List<String> splits = (element.body ?? '').split(' ');
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
            var permission = await Permission.sms.status;
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

double? extractAmountFromMessage(String? message) {
  var regex = RegExp(r'(\d+\.\d{2})');
  var match = regex.firstMatch(message ?? '');
  return match != null ? double.tryParse(match.group(0) ?? '0') : null;
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];

        return ListTile(
          title: Text('${message.sender} [${message.date}]'),
          subtitle: Text('${message.body}'),
        );
      },
    );
  }
}



