import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/review/review_bloc.dart';



class CreateReviewDialog extends StatefulWidget {
 final int booking_id;
  final String status;

  const CreateReviewDialog({super.key, required this.booking_id, required this.status});

  @override
  State<CreateReviewDialog> createState() =>
  _CreateReviewDialogState();
  }
class _CreateReviewDialogState extends State<CreateReviewDialog> {

  @override
  Widget build(BuildContext context) {
    int stars = 5;
    final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Rate_Apartment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: stars,
                items: List.generate(
                  5,
                      (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('${i + 1} Stars'),
                  ),
                ),
                onChanged: (v) => stars = v!,
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Comment(optional)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ReviewBloc>().add(
                  CreateReviewEvent(
                    booking_id: widget.booking_id,
                    stars: stars,
                    comment: controller.text.isEmpty
                        ? null
                        : controller.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );


  }

   }
