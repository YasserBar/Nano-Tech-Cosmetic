import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/localization/local_controller.dart';
import 'package:nano_tech_cosmetic/core/screens/home_screen.dart';
import 'package:nano_tech_cosmetic/core/widgets/dialog_guest.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/screens/offers_screen.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/screens/my_cart_screen.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/screens/my_order_screen.dart';
import 'package:nano_tech_cosmetic/main.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int indexNavBar = Get.arguments ?? 0;
  bool isLogoutTap = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LocaleController localeController = Get.find();
  OrderStatus orderStatusFilter = OrderStatus.all;
  List<Widget> tabs = [];

  @override
  void initState() {
    _initializeTokenAndCustomer();
    tabs = [
      const HomeScreen(),
      const MyCartScreen(),
      MyOrderScreen(orderStatusFilter: orderStatusFilter),
      const OffersScreen()
    ];
    super.initState();
  }

  Future<void> _initializeTokenAndCustomer() async {
    try {
      globalUser = await di.sl<AuthLocalDataSource>().getCachedUser();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.09),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10)
              .copyWith(bottom: 0),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, 2),
              spreadRadius: 10,
              blurRadius: 10,
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  globalUser != null
                      ? scaffoldKey.currentState!.openDrawer()
                      : signInDialog(context,
                          title: AppTranslationKeys.profile.tr);
                },
                child: SvgPicture.asset(
                  AppTranslationKeys.menu.tr,
                  height: 35,
                  width: 35,
                ),
              ),
              SvgPicture.asset(
                AppAssets.logoAppBar,
              ),
              if (indexNavBar != 2)
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppPagesRoutes.searchScreen);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.white,
                    size: 35,
                  ),
                ),
              if (indexNavBar == 2)
                PopupMenuButton<OrderStatus>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tooltip: "Operation",
                  onSelected: (value) async {
                    setState(() {
                      orderStatusFilter = value;
                      tabs = [
                        const HomeScreen(),
                        const MyCartScreen(),
                        MyOrderScreen(orderStatusFilter: orderStatusFilter),
                        const OffersScreen()
                      ];
                    });
                  },
                  initialValue: orderStatusFilter,
                  icon: SvgPicture.asset(orderStatusFilter.getLightIcon()),
                  itemBuilder: (context) => [
                    PopupMenuItem<OrderStatus>(
                        value: OrderStatus.all,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(OrderStatus.all.getIcon()),
                          ],
                        )),
                    PopupMenuItem<OrderStatus>(
                        value: OrderStatus.waiting,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(OrderStatus.waiting.getIcon()),
                          ],
                        )),
                    PopupMenuItem<OrderStatus>(
                        value: OrderStatus.processing,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(OrderStatus.processing.getIcon()),
                          ],
                        )),
                    PopupMenuItem<OrderStatus>(
                        value: OrderStatus.rejected,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(OrderStatus.rejected.getIcon()),
                          ],
                        )),
                    PopupMenuItem<OrderStatus>(
                        value: OrderStatus.done,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(OrderStatus.done.getIcon()),
                          ],
                        )),
                  ],
                )
            ],
          ),
        ),
      ),
      drawer: globalUser == null
          ? null
          : Drawer(
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.white,
                        offset: Offset(-10, -20),
                        spreadRadius: 10,
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: AppColors.white,
                        offset: Offset(-10, 20),
                        spreadRadius: 10,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                "${globalUser!.firstName[0].toUpperCase()}${globalUser!.lastName[0].toUpperCase()}",
                                style: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${globalUser!.firstName} ${globalUser!.lastName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${AppTranslationKeys.birthDate.tr}:",
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${AppTranslationKeys.gender.tr}:",
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        globalUser!.birthday,
                                        style: const TextStyle(
                                          color: AppColors.gray,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        globalUser!.gender == 'female'
                                            ? AppTranslationKeys.female.tr
                                            : AppTranslationKeys.male.tr,
                                        style: const TextStyle(
                                          color: AppColors.gray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.address),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    globalUser!.address,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: AppColors.gray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.gmail),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    globalUser!.email,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: AppColors.gray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.phone),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    globalUser!.phone,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      color: AppColors.gray,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.instagram),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    globalUser!.instagram ??
                                        AppTranslationKeys.noAccount.tr,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: AppColors.gray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.telegram),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  child: Text(
                                    globalUser!.telegram ??
                                        AppTranslationKeys.noAccount.tr,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: AppColors.gray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.facebook),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    globalUser!.facebook ??
                                        AppTranslationKeys.noAccount.tr,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: AppColors.gray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.twitter),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    globalUser!.twitter ??
                                        AppTranslationKeys.noAccount.tr,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: AppColors.gray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            localeController.changeLang();
                          });
                        },
                        leading: SvgPicture.asset(AppAssets.translate),
                        title: Text(AppTranslationKeys.changeLang.tr),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(AppPagesRoutes.verifyCodeScreen,
                              arguments: globalUser!.email);
                        },
                        leading: SvgPicture.asset(AppAssets.resetPassword),
                        title: Text(AppTranslationKeys.resetPassword.tr),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.about),
                        title: Text(AppTranslationKeys.about.tr),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.support),
                        title: Text(AppTranslationKeys.support.tr),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.logout),
                        title: Text(AppTranslationKeys.logout.tr),
                        onTap: () {
                          WidgetsUtils.showCustomDialog(
                            context,
                            title: AppTranslationKeys.logoutFromApp.tr,
                            hasBtns: false,
                            children: [
                              BlocProvider(
                                create: (context) => di.sl<AuthBloc>(),
                                child: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is FailureAuthState ||
                                        state is OfflineFailureAuthState ||
                                        state
                                            is InternalServerFailureAuthState ||
                                        state is UnexpectedFailureAuthState) {
                                      WidgetsUtils.showSnackBar(
                                        title: AppTranslationKeys.failure.tr,
                                        message: state.message,
                                        snackBarType: SnackBarType.error,
                                      );
                                    } else if (state is SuccessLogoutState) {
                                      Get.offAllNamed(
                                          AppPagesRoutes.signInScreen);
                                      WidgetsUtils.showSnackBar(
                                        title: AppTranslationKeys.success.tr,
                                        message: state.message,
                                        snackBarType: SnackBarType.info,
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoadingAuthState) {
                                      return const LoaderIndicator(
                                        size: 50,
                                        lineWidth: 5,
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(30)
                                          .copyWith(bottom: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: MaterialButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .add(
                                                  const LogoutEvent(),
                                                );
                                              },
                                              color: AppColors.primary,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: AppColors.gray),
                                              ),
                                              child: Text(
                                                AppTranslationKeys.confirm.tr,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: MaterialButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              color: AppColors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: AppColors.gray),
                                              ),
                                              child: Text(
                                                AppTranslationKeys.cancel.tr,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: AppColors.gray),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: tabs[indexNavBar],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        backgroundColor: AppColors.white,
        iconSize: 35,
        fixedColor: AppColors.primary,
        unselectedItemColor: AppColors.gray,
        currentIndex: indexNavBar,
        onTap: (value) {
          setState(() {
            if (value == 2 && globalUser == null) {
              signInDialog(context, title: AppTranslationKeys.myOrders.tr);
            } else {
              if (Get.previousRoute == AppPagesRoutes.productDetailsScreen) {
                // Get.removeRoute(AppPagesRoutes.productDetailsScreen);//TODO
              } else if (Get.previousRoute ==
                  AppPagesRoutes.offerDetailsScreen) {
                // Get.removeRoute(AppPagesRoutes.offerDetailsScreen);//TODO
              }
              indexNavBar = value;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.home_outlined,
              ),
              label: AppTranslationKeys.home.tr),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
              label: AppTranslationKeys.myCart.tr),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.assignment_outlined,
              ),
              label: AppTranslationKeys.myOrders.tr),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.sale,
                color: indexNavBar == 3 ? AppColors.primary : AppColors.gray,
              ),
              label: AppTranslationKeys.offers.tr),
        ],
      ),
    );
  }
}
