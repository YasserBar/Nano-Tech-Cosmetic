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
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_bloc.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_event.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_state.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OrderList extends StatelessWidget {
  final OrderStatus orderStatusFilter;

  const OrderList({Key? key, required this.orderStatusFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<OrderBloc>()
        ..add(
          DisplayOrderEvent(orderStatus: orderStatusFilter),
        ),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is FailureOrderState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message.tr,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is OfflineFailureOrderState) {
            return HandleStatesWidget(
              errorType: StateType.offline,
              onPressedTryAgain: () {
                BlocProvider.of<OrderBloc>(context).add(DisplayOrderEvent(
                    orderStatus: orderStatusFilter));
              },
            );
          }
          if (state is UnexpectedFailureOrderState) {
            return HandleStatesWidget(
              errorType: StateType.unexpectedProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OrderBloc>(context).add(DisplayOrderEvent(
                    orderStatus: orderStatusFilter));
              },
            );
          }
          if (state is InternalServerFailureOrderState) {
            return HandleStatesWidget(
              errorType: StateType.internalServerProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OrderBloc>(context).add(DisplayOrderEvent(
                    orderStatus: orderStatusFilter));
              },
            );
          }
          if (state is LoadedOrdersState) {
            if (state.orders!.isEmpty) {
              return const HandleStatesWidget(
                errorType: StateType.noAnyOrder,
              );
            }
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              onRefresh: () async {
                BlocProvider.of<OrderBloc>(context).add(DisplayOrderEvent(
                    orderStatus: orderStatusFilter));
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount:
                state.orders != null ? state.orders!.length : 0,
                itemBuilder: (context, index) => OrderCard(
                  order: state.orders![index],
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
