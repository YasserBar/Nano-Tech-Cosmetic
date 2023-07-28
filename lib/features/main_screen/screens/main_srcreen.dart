import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_assets.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/features/main_screen/screens/home_screen.dart';
import 'package:nano_tech_cosmetic/features/offers/screens/offers_screen.dart';
import 'package:nano_tech_cosmetic/features/orders/screens/my_cart_screen.dart';
import 'package:nano_tech_cosmetic/features/orders/screens/my_order_screen.dart';

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
                  scaffoldKey.currentState!.openDrawer();
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
                onPressed: () {},
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
      drawer: Drawer(
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
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          "KB",
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Kumar Baker",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Flexible(
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
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "20-8-1995",
                                  style: TextStyle(
                                    color: AppColors.gray,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                    color: AppColors.gray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.address),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Syria, Damascus, Kusor",
                            style: TextStyle(
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
                          const Text(
                            "Kumnahd@gmail.com",
                            style: TextStyle(
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
                          const Text(
                            "0994718258",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     SvgPicture.asset(
                      //       AppAssets.instagram,
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     const Text(
                      //       "KumarBaker@insta",
                      //       style: TextStyle(
                      //         color: AppColors.gray,
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.telegram),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "KumarBaker@tele",
                            style: TextStyle(
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
                          const Text(
                            "KumarBaker@face",
                            style: TextStyle(
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
                          const Text(
                            "KumarBaker@twit",
                            style: TextStyle(
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
                ListTile(
                  leading: SvgPicture.asset(AppAssets.translate),
                  title: const Text("Change Lang"),
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
                Expanded(
                  child: SvgPicture.asset(AppAssets.logoDrawer),
                )
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
            indexNavBar = value;
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
