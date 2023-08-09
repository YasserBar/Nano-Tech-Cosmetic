import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/bloc/offer_bloc.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/bloc/offer_event.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/bloc/offer_state.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/widgets/offer_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<OfferBloc>()..add(
        ShowOffersEvent(),
      ),
      child: BlocConsumer<OfferBloc, OfferState>(
        listener: (context, state) {
          if (state is FailureOfferState ||
              state is OfflineFailureOfferState ||
              state is InternalServerFailureOfferState ||
              state is UnexpectedFailureOfferState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadedOffersState) {
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.offer!.length,
                itemBuilder: (context, index) => OfferCard(
                  offer: state.offer![index],
                ),
              ),
            );
          }
          return const LoaderIndicator();
        },
      ),
    );
  }
}
