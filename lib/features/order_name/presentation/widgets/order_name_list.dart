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
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_bloc.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_event.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_state.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/widgets/order_name_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OrderNameList extends StatelessWidget {
  final OrderStatus orderStatusFilter;

  const OrderNameList({Key? key, required this.orderStatusFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<OrderNameBloc>()
        ..add(
          DisplayOrdersNameEvent(orderStatus: orderStatusFilter),
        ),
      child: BlocConsumer<OrderNameBloc, OrderNameState>(
        listener: (context, state) {
          if (state is FailureOrderNameState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message.tr,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is OfflineFailureOrderNameState) {
            return HandleStatesWidget(
              stateType: StateType.offline,
              onPressedTryAgain: () {
                BlocProvider.of<OrderNameBloc>(context).add(
                  DisplayOrdersNameEvent(orderStatus: orderStatusFilter),
                );
              },
            );
          }
          if (state is UnexpectedFailureOrderNameState) {
            return HandleStatesWidget(
              stateType: StateType.unexpectedProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OrderNameBloc>(context).add(
                  DisplayOrdersNameEvent(orderStatus: orderStatusFilter),
                );
              },
            );
          }
          if (state is InternalServerFailureOrderNameState) {
            return HandleStatesWidget(
              stateType: StateType.internalServerProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OrderNameBloc>(context).add(
                  DisplayOrdersNameEvent(orderStatus: orderStatusFilter),
                );
              },
            );
          }
          if (state is LoadedOrdersNameState) {
            if (state.ordersName!.isEmpty) {
              return const HandleStatesWidget(
                stateType: StateType.noAnyOrder,
              );
            }
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              onRefresh: () async {
                BlocProvider.of<OrderNameBloc>(context).add(
                  DisplayOrdersNameEvent(orderStatus: orderStatusFilter),
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.ordersName!.length,
                itemBuilder: (context, index) => OrderNameCard(
                  orderName: state.ordersName![index],
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
