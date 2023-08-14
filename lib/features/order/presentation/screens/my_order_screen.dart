import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_dimensions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_bloc.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_event.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_state.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_card.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart'
as o;
import 'package:nano_tech_cosmetic/main.dart';

class MyOrderScreen extends StatefulWidget {
  OrderStatus orderStatusFilter;

  MyOrderScreen({Key? key, required this.orderStatusFilter}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return globalUser != null && globalUser!.role != Role.customer
        ? Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.1),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.gray,
            dividerColor: AppColors.black,
            controller: tabController,
            onTap: (value) {
              if (kDebugMode) {
                print(widget.orderStatusFilter);
              }
            },
            isScrollable: false,
            unselectedLabelStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.gray,
            ),
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.primary,
            ),
            tabs: [
              Tab(
                text: AppTranslationKeys.cartOrders.tr,
              ),
              Tab(
                text: AppTranslationKeys.specialOrders.tr,
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        BlocProvider(
          create: (context) => di.sl<OrderBloc>()
            ..add(
              DisplayOrderEvent(orderStatus: OrderStatus.all),
            ),
          child: BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is FailureOrderState ||
                  state is OfflineFailureOrderState ||
                  state is InternalServerFailureOrderState ||
                  state is UnexpectedFailureOrderState) {
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.failure.tr,
                  message: state.message,
                  snackBarType: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadedOrdersState) {
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.white,
                  onRefresh: () async {},
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.appbarBodyPadding,
                      horizontal: AppDimensions.sidesBodyPadding,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                    state.orders != null ? state.orders!.length : 0,
                    itemBuilder: (context, index) => OrderCard(
                      price: state.orders![index].price.toString(),
                      response: state.orders![index].response ??
                          "================",
                      date: state.orders![index].createdAt,
                      status: state.orders![index].status,
                      onTap: () {
                        Get.toNamed(AppPagesRoutes.orderDetailsScreen,
                            arguments: {
                              AppKeys.ORDER: state.orders![index],
                              AppKeys.ORDER_TYPE: OrderType.normal,
                            });
                      },
                    ),
                  ),
                );
              }
              return const LoaderIndicator();
            },
          ),
        ),
        if (globalUser!.role == Role.company)
          RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.white,
            onRefresh: () async {},
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.appbarBodyPadding,
                horizontal: AppDimensions.sidesBodyPadding,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => OrderCard(
                price: "3500",
                response:
                "Your order will prepare you\n can show status of...  ",
                date: "21-03-2023",
                status: OrderStatus.rejected,
                onTap: () {
                  Get.toNamed(AppPagesRoutes.orderDetailsScreen,
                      arguments: {
                        AppKeys.ORDER: const o.Order(
                            id: 1,
                            endProcessing: '',
                            createdAt: '21-03-2023',
                            langCode: '',
                            price: 3500,
                            response: '*********',
                            status: OrderStatus.rejected,
                            updatedAt: '21-03-2023',
                            userId: 1,
                            startProcessing: ''),
                        AppKeys.ORDER_TYPE: OrderType.manufacturing,
                      });
                },
              ),
            ),
          ),
        if (globalUser!.role == Role.salon)
          RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.white,
            onRefresh: () async {},
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.appbarBodyPadding,
                horizontal: AppDimensions.sidesBodyPadding,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => OrderCard(
                price: "3500",
                response:
                "Your order will prepare you\n can show status of...  ",
                date: "21-03-2023",
                status: OrderStatus.rejected,
                onTap: () {
                  Get.toNamed(AppPagesRoutes.orderDetailsScreen,
                      arguments: {
                        AppKeys.ORDER: const o.Order(
                            id: 1,
                            endProcessing: '',
                            createdAt: '21-03-2023',
                            langCode: '',
                            price: 3500,
                            response: '*********',
                            status: OrderStatus.rejected,
                            updatedAt: '21-03-2023',
                            userId: 1,
                            startProcessing: ''),
                        AppKeys.ORDER_TYPE: OrderType.manufacturing,
                      });
                },
              ),
            ),
          ),
      ]),
    )
        : BlocProvider(
      create: (context) => di.sl<OrderBloc>()
        ..add(
          DisplayOrderEvent(orderStatus: OrderStatus.all),
        ),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is FailureOrderState ||
              state is OfflineFailureOrderState ||
              state is InternalServerFailureOrderState ||
              state is UnexpectedFailureOrderState) {
            WidgetsUtils.showSnackBar(
              title: AppTranslationKeys.failure.tr,
              message: state.message,
              snackBarType: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadedOrdersState) {
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              onRefresh: () async {},
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.appbarBodyPadding,
                  horizontal: AppDimensions.sidesBodyPadding,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount:
                state.orders != null ? state.orders!.length : 0,
                itemBuilder: (context, index) => OrderCard(
                  price: state.orders![index].price.toString(),
                  response: state.orders![index].response ??
                      "*******************",
                  date: state.orders![index].createdAt,
                  status: state.orders![index].status,
                  onTap: () {
                    Get.toNamed(AppPagesRoutes.orderDetailsScreen,
                        arguments: {
                          AppKeys.ORDER: state.orders![index],
                          AppKeys.ORDER_TYPE: OrderType.normal,
                        });
                  },
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
