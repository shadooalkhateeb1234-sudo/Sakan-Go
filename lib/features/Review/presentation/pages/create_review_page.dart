import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/rating/rating_bloc.dart';
import '../manager/review/review_bloc.dart';

class CreateReviewPage extends StatefulWidget {
  final int booking_id;
  final int apartmentId;
  const CreateReviewPage({super.key, required this.booking_id, required this.apartmentId});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  int stars = 5;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Apartment')),
      body: BlocConsumer<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is ReviewSuccess) {
            context.read<RatingBloc>().add(
               RefreshApartmentRatingEvent(widget.apartmentId),
                  );
              Navigator.pop(context);
          }
          if (state is ReviewError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loading = state is ReviewLoading;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                  onChanged: (v) => setState(() => stars = v!),
                ),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Comment (optional)',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () {
                    context.read<ReviewBloc>().add(
                      CreateReviewEvent(
                        booking_id: widget.booking_id,
                        stars: stars,
                        comment: controller.text.isEmpty
                            ? null
                            : controller.text,
                      ),
                    );
                  },
                  child: loading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Submit Review'),

                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
