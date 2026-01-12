import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../manager/rating/rating_bloc.dart';
import 'animated_stars_widget.dart';

///  في Apartment Details Page:
//ApartmentRatingWidget(apartmentId: apartment.id),

  class ApartmentRatingWidget extends StatefulWidget {
  final int apartmentId;

  const ApartmentRatingWidget({super.key, required this.apartmentId});

  @override
  State<ApartmentRatingWidget> createState() =>
  _ApartmentRatingWidgetState();
  }

  class _ApartmentRatingWidgetState extends State<ApartmentRatingWidget> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
  super.didChangeDependencies();

  if (!_loaded) {
  context
      .read<RatingBloc>()
      .add(LoadApartmentRatingEvent(widget.apartmentId));
  _loaded = true;
  }
  }
  @override
  void didUpdateWidget(covariant ApartmentRatingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.apartmentId != widget.apartmentId) {
      _loaded = false;
    }
  }



  @override
     Widget build(BuildContext context) {
      return BlocBuilder<RatingBloc, RatingState>(
       builder: (_, state) {
      if (state is RatingLoading) return   _Skeleton();
      if (state is RatingEmpty) return   Text( 'no_ratings_yet'.tr(context));
      if (state is RatingLoaded) {
        return AnimatedStars(average: state.average);
          }
      if (state is RatingError) return   Text('rating_unavailable'.tr(context));
          return   SizedBox.shrink();
             },
          );
       }
   }


class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (_) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
