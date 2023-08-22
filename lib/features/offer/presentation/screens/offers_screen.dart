import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
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
      create: (context) => di.sl<OfferBloc>()
        ..add(
          ShowOffersEvent(),
        ),
      child: BlocConsumer<OfferBloc, OfferState>(
        listener: (context, state) {
          if (state is FailureOfferState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message.tr,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadedOffersState) {
            if (state.offer!.isEmpty) {
              return const HandleStatesWidget(
                errorType: StateType.noAnyProduct,
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<OfferBloc>(context).add(ShowOffersEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.offer != null ? state.offer!.length : 0,
                itemBuilder: (context, index) => OfferCard(
                  offer: state.offer![index],
                ),
              ),
            );
          }
          if (state is OfflineFailureOfferState) {
            return HandleStatesWidget(
              errorType: StateType.offline,
              onPressedTryAgain: () {
                BlocProvider.of<OfferBloc>(context).add(ShowOffersEvent());
              },
            );
          }
          if (state is UnexpectedFailureOfferState) {
            return HandleStatesWidget(
              errorType: StateType.unexpectedProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OfferBloc>(context).add(ShowOffersEvent());
              },
            );
          }
          if (state is InternalServerFailureOfferState) {
            return HandleStatesWidget(
              errorType: StateType.internalServerProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OfferBloc>(context).add(ShowOffersEvent());
              },
            );
          }
          return const LoaderIndicator();
        },
      ),
    );
  }
}
