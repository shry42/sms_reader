import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

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
  final keyword = 'Credited for Rs.';
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

class SalaryScreen extends StatelessWidget {
  const SalaryScreen({super.key, required this.messages});
  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    List<dynamic> salaryAmount = [];
    double maxSalary = 0.0;

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

    for (int i = 0; i < salaryAmount.length; i++) {
      var salary = salaryAmount[i];
      if (salary == null) {
        continue;
      } else if (maxSalary < salary) {
        maxSalary = salary;
      }
    }

    print(maxSalary);
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Screen'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: maxSalary != null,
            child: ListTile(
              title: Text('Salary of the Month'),
              subtitle: Text('Amount: ₹${maxSalary}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
