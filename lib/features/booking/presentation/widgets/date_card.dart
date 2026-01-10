import 'package:flutter/material.dart';

class  DateCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final VoidCallback onTap;

  const  DateCard({
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
        '${date.day}/${date.month}/${date.year}',
      ),

        trailing: const Icon(Icons.calendar_today),
        onTap: onTap,
      ),
    );
  }
}
//.............
