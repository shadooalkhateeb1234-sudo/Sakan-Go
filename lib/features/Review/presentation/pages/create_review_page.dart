import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/rating/rating_bloc.dart';
import '../manager/review/review_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';

class CreateReviewPage extends StatefulWidget {
  final int booking_id;
  final int apartmentId;

  const CreateReviewPage({
    super.key,
    required this.booking_id,
    required this.apartmentId,
  });

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  int stars = 5;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('rate_apartment'.tr(context)),
      ),
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
              SnackBar(content: Text(state.message.tr(context))),
            );
          }
        },
        builder: (context, state) {
          final loading = state is ReviewLoading;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('rating'.tr(context)),
                const SizedBox(height: 8),

                Slider(
                  value: stars.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: stars.toString(),
                  onChanged: (v) =>
                      setState(() => stars = v.toInt()),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'comment_optional'.tr(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                        : Text('submit_review'.tr(context)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
