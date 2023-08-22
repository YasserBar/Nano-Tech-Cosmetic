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
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_bloc.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_event.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_state.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/widgets/order_manufacturing_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OrderManufacturingList extends StatelessWidget {
  final OrderStatus orderStatusFilter;

  const OrderManufacturingList({Key? key, required this.orderStatusFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<OrderManufacturingBloc>()
        ..add(
          DisplayOrdersManufacturingEvent(
              orderStatus: orderStatusFilter),
        ),
      child: BlocConsumer<OrderManufacturingBloc,
          OrderManufacturingState>(
        listener: (context, state) {
          if (state is FailureOrderManufacturingState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message.tr,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is OfflineFailureOrderManufacturingState) {
            return HandleStatesWidget(
              errorType: StateType.offline,
              onPressedTryAgain: () {
                BlocProvider.of<OrderManufacturingBloc>(context)
                    .add(
                  DisplayOrdersManufacturingEvent(
                      orderStatus: orderStatusFilter),
                );
              },
            );
          }
          if (state is UnexpectedFailureOrderManufacturingState) {
            return HandleStatesWidget(
              errorType: StateType.unexpectedProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OrderManufacturingBloc>(context)
                    .add(
                  DisplayOrdersManufacturingEvent(
                    orderStatus: orderStatusFilter,
                  ),
                );
              },
            );
          }
          if (state
          is InternalServerFailureOrderManufacturingState) {
            return HandleStatesWidget(
              errorType: StateType.internalServerProblem,
              onPressedTryAgain: () {
                BlocProvider.of<OrderManufacturingBloc>(context)
                    .add(
                  DisplayOrdersManufacturingEvent(
                      orderStatus: orderStatusFilter),
                );
              },
            );
          }
          if (state is LoadedOrdersManufacturingState) {
            if (state.ordersManufacturing!.isEmpty) {
              return const HandleStatesWidget(
                errorType: StateType.noAnyOrder,
              );
            }
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              onRefresh: () async {
                BlocProvider.of<OrderManufacturingBloc>(context)
                    .add(
                  DisplayOrdersManufacturingEvent(
                      orderStatus: orderStatusFilter),
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.ordersManufacturing!.length,
                itemBuilder: (context, index) =>
                    OrderManufacturingCard(
                      orderManufacturing:
                      state.ordersManufacturing![index],
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
