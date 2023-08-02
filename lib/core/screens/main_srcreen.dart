import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/screens/home_screen.dart';
import 'package:nano_tech_cosmetic/core/widgets/dialog_guest.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/screens/offers_screen.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/screens/my_cart_screen.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/screens/my_order_screen.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/widgets/search_product_delegate.dart';
import 'package:nano_tech_cosmetic/main.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int indexNavBar = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                      : signInDialog(context);
                },
                child: SvgPicture.asset(
                  AppAssets.menu,
                  height: 35,
                  width: 35,
                ),
              ),
              SvgPicture.asset(
                AppAssets.logoAppBar,
              ),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchProductDelegate(products: []),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 35,
                ),
              ),
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
                        offset: Offset(-10, 0),
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
                                const Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Birthdate:",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Gender:",
                                        style: TextStyle(
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
                                        globalUser!.gender,
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
                                Text(
                                  globalUser!.address,
                                  style: const TextStyle(
                                      color: AppColors.gray, fontSize: 18),
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
                                Text(
                                  globalUser!.email,
                                  style: const TextStyle(
                                      color: AppColors.gray, fontSize: 18),
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
                                Text(
                                  globalUser!.phone,
                                  style: const TextStyle(
                                    color: AppColors.gray,
                                    fontSize: 18,
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
                                Text(
                                  globalUser!.instagram ?? "No Account",
                                  style: const TextStyle(
                                      color: AppColors.gray, fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.telegram),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  globalUser!.telegram ?? "No Account",
                                  style: const TextStyle(
                                      color: AppColors.gray, fontSize: 18),
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
                                Text(
                                  globalUser!.facebook ?? "No Account",
                                  style: const TextStyle(
                                      color: AppColors.gray, fontSize: 18),
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
                                Text(
                                  globalUser!.twitter ?? "No Account",
                                  style: const TextStyle(
                                      color: AppColors.gray, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocProvider(
                        create: (context) => di.sl<AuthBloc>(),
                        child: ListTile(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              ResendOTPEvent(
                                ResendOTP(email: globalUser!.email),
                              ),
                            );
                            Get.toNamed(AppPagesRoutes.verifyCodeScreen,
                                arguments: globalUser!.email);
                          },
                          leading: SvgPicture.asset(AppAssets.translate),
                          title: const Text("Change Lang"),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => di.sl<AuthBloc>(),
                        child: ListTile(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              ResendOTPEvent(
                                ResendOTP(email: globalUser!.email),
                              ),
                            );
                            Get.toNamed(AppPagesRoutes.verifyCodeScreen,
                                arguments: globalUser!.email);
                          },
                          leading: SvgPicture.asset(AppAssets.resetPassword),
                          title: const Text("Reset password"),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.resetPassword),
                        title: const Text("Reset password"),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.about),
                        title: const Text("About"),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.support),
                        title: const Text("Support"),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppAssets.logout),
                        title: const Text("Logout"),
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
            value == 2 && globalUser == null
                ? signInDialog(context)
                : indexNavBar = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: "My Cart"),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_outlined,
              ),
              label: "My Orders"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.sale,
                color: indexNavBar == 3 ? AppColors.primary : AppColors.gray,
              ),
              label: "Offers"),
        ],
      ),
    );
  }
}

List<Widget> tabs = [
  const HomeScreen(),
  const MyCartScreen(),
  const MyOrderScreen(),
  const OffersScreen()
];
