import 'package:flutter/cupertino.dart';
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
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_bloc.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_event.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_state.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_product_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class OrderDetailsScreen extends StatelessWidget {
  final Order order = Get.arguments;

  OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppbar(title: AppTranslationKeys.orderDetails.tr),
      body: ListView(
        children: [
          Container(
            // height: AppDimensions.bodyHeightWithoutNav * 0.35,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.appbarBodyPadding + 5,
              horizontal: AppDimensions.sidesBodyPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTranslationKeys.total.tr,
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    Text(
                      "${order.price} ${AppTranslationKeys.di.tr}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 26,
                            color: AppColors.primary,
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (order.status).getVale().tr,
                      style: TextStyle(
                          color: (order.status).getColor(), fontSize: 20),
                    ),
                    Text(
                      order.createdAt.toString().substring(0, 10),
                      style: const TextStyle(
                          color: AppColors.secondary, fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppTranslationKeys.response.tr,
                  style: const TextStyle(color: AppColors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  order.response ?? AppTranslationKeys.notResponse.tr,
                  style: const TextStyle(color: AppColors.gray, fontSize: 16),
                  maxLines: 3,
                )
              ],
            ),
          ),
          const Divider(height: 30, thickness: 2, indent: 15, endIndent: 15),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.sidesBodyPadding),
            child: BlocProvider(
              create: (context) => di.sl<OrderBloc>()
                ..add(DisplayOrderDetailsEvent(orderId: order.id)),
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  print(order.id);
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
                      stateType: StateType.offline,
                      onPressedTryAgain: () {
                        BlocProvider.of<OrderBloc>(context).add(
                          DisplayOrderDetailsEvent(
                            orderId: order.id,
                          ),
                        );
                      },
                    );
                  }
                  if (state is UnexpectedFailureOrderState) {
                    return HandleStatesWidget(
                      stateType: StateType.unexpectedProblem,
                      onPressedTryAgain: () {
                        BlocProvider.of<OrderBloc>(context).add(
                          DisplayOrderDetailsEvent(
                            orderId: order.id,
                          ),
                        );
                      },
                    );
                  }
                  if (state is InternalServerFailureOrderState) {
                    return HandleStatesWidget(
                      stateType: StateType.internalServerProblem,
                      onPressedTryAgain: () {
                        BlocProvider.of<OrderBloc>(context).add(
                          DisplayOrderDetailsEvent(
                            orderId: order.id,
                          ),
                        );
                      },
                    );
                  }
                  if (state is LoadedOrdersState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(state.orderProducts!.isNotEmpty)
                          Text(
                          AppTranslationKeys.products.tr,
                          style: const TextStyle(
                              color: AppColors.primary, fontSize: 20),
                        ),
                        for (int i = 0; i < state.orderProducts!.length; i++)
                          OrderProductCard(
                            image: state.orderProducts![i].imageUrl,
                            name: Get.locale!.languageCode == 'ar'
                                ? state.orderProducts![i].name
                                : state.orderProducts![i].nameEn,
                            price: state.orderProducts![i].price,
                            count: state.orderProducts![i].amount,
                          ),
                        if(state.orderOffers!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            AppTranslationKeys.offers.tr,
                            style: const TextStyle(
                                color: AppColors.primary, fontSize: 20),
                          ),
                        ),
                        for (int j = 0; j < state.orderOffers!.length; j++)
                          OrderProductCard(
                            image: state.orderOffers![j].imageUrl!,
                            name: Get.locale!.languageCode == 'ar'
                                ? state.orderOffers![j].title
                                : state.orderOffers![j].titleEn,
                            price: int.parse(state.orderOffers![j].price),
                            count: state.orderOffers![j].ammount!,
                          ),
                      ],
                    );
                  }
                  return const LoaderIndicator();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
