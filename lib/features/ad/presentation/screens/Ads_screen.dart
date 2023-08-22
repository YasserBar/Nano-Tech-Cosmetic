import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/core/widgets/secondary_appbar.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_bloc.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_event.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_state.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/widgets/ad_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppbar(title: AppTranslationKeys.ads.tr),
      body: BlocProvider(
        create: (context) => di.sl<AdBloc>()..add(const DisplayAdsEvent()),
        child: BlocConsumer<AdBloc, AdState>(
          listener: (context, state) {
            if (state is FailureAdState) {
              WidgetsUtils.showSnackBar(
                title: AppTranslationKeys.failure.tr,
                message: state.message.tr,
                snackBarType: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadedAdsState) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
                },
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.appbarBodyPadding,
                    horizontal: AppDimensions.sidesBodyPadding,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.ads?.length,
                  itemBuilder: (context, index) => AdCard(
                    ad: state.ads![index],
                  ),
                ),
              );
            }
            if (state is OfflineFailureAdState) {
              return HandleStatesWidget(
                errorType: StateType.offline,
                onPressedTryAgain: () {
                  BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
                },
              );
            }
            if (state is UnexpectedFailureAdState) {
              return HandleStatesWidget(
                errorType: StateType.unexpectedProblem,
                onPressedTryAgain: () {
                  BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
                },
              );
            }
            if (state is InternalServerFailureAdState) {
              return HandleStatesWidget(
                errorType: StateType.internalServerProblem,
                onPressedTryAgain: () {
                  BlocProvider.of<AdBloc>(context).add(const DisplayAdsEvent());
                },
              );
            }
            return const LoaderIndicator();
          },
        ),
      ),
    );
  }
}
