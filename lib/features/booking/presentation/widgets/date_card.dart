import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class  DateCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final VoidCallback onTap;


     DateCard({
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final formatter = DateFormat.yMd(locale);
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(formatter.format(date)),


        trailing: const Icon(Icons.calendar_today),
        onTap: onTap,
      ),
    );
  }
}
//.............
