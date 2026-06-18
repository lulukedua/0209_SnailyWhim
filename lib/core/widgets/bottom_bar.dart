import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:snailywhim/core/services/notification_services.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/widgets/app_snackbar.dart';
import 'package:snailywhim/core/widgets/badge_dot.dart';
import 'package:snailywhim/core/widgets/notification_badge.dart';
import 'package:snailywhim/data/models/user_model.dart';
import 'package:snailywhim/data/repositories/auth_repository.dart';
import 'package:snailywhim/screen/dashboard_page.dart';
import 'package:snailywhim/screen/home_page.dart';
import 'package:snailywhim/screen/notification_page.dart';
import 'package:snailywhim/screen/order/order_page.dart';
import 'package:snailywhim/screen/product/product_page.dart';
import 'package:snailywhim/screen/profile/profile_page.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int currentIndex;
  bool showBottomBar = true;
  bool isLoading = true;
  UserModel? user;
  List<Widget> pages = [];

  void toggleBottomBar(bool visible) {
    if (showBottomBar == visible) return;
    setState(() {
      showBottomBar = visible;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      final currentUser = await AuthRepository().getCurrentUser();

      if (currentUser == null) {
        throw Exception("User tidak ditemukan");
      }

      user = currentUser;

      pages = user!.isAdmin
          ? [
              DashboardPage(
                user: user!,
                onSeeAllOrders: () {
                  setState(() {
                    currentIndex = 2; // Pindah ke index 2 (Pesanan)
                  });
                },
              ),
              ProductPage(
                user: user!,
                onScrollDirectionChanged: toggleBottomBar,
              ),
              OrderPage(userId: user!.id, isAdmin: true),
              const ProfilePage(),
            ]
          : [
              const HomePage(),
              const NotificationPage(),
              OrderPage(userId: user!.id, isAdmin: false),
              const ProfilePage(),
            ];

      setState(() {
        isLoading = false;
      });
      // Di loadUser(), setelah user berhasil di-load, tambahkan:
      if (!user!.isAdmin) {
        final badge = context.read<NotificationBadgeProvider>();
        NotificationService().stopListening();
        NotificationService().startListening(
          userId: user!.id,
          badgeProvider: badge,
        );
      }
    } catch (e) {
      debugPrint("LOAD USER ERROR: $e");
      if (mounted) {
        AppSnackbar.show(
          context,
          title: 'Gagal',
          message: e.toString().replaceAll('Exception: ', ''),
          type: SnackType.error,
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (user == null) {
      return const Scaffold(body: Center(child: Text("User tidak ditemukan")));
    }
    return BottomBar(
      layout: BottomBarLayout(
        width: MediaQuery.of(context).size.width - 32,
        borderRadius: BorderRadius.circular(99),
      ),
      motion: const BottomBarMotion.cupertino(),
      body: pages[currentIndex],
      child: AnimatedContainer(
        height: showBottomBar ? 75 : 0,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.bgBtmColor,
          borderRadius: BorderRadius.circular(99),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: 75,
            child: BottomBarItems(
              children: [
                BottomBarItem(
                  icon: Icon(
                    user!.isAdmin
                        ? LucideIcons.layoutDashboard
                        : LucideIcons.house,
                  ),
                  label: Text(user!.isAdmin ? "Dashboard" : "Home"),
                  selected: currentIndex == 0,
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                BottomBarItem(
                  icon: Consumer<NotificationBadgeProvider>(
                    builder: (_, badge, __) => BadgeDot(
                      show: badge.hasUnread,
                      child: Icon(
                        user!.isAdmin ? LucideIcons.package : LucideIcons.bell,
                      ),
                    ),
                  ),
                  label: Text(user!.isAdmin ? "Produk" : "Notification"),
                  selected: currentIndex == 1,
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                BottomBarItem(
                  icon: Icon(
                    user!.isAdmin
                        ? LucideIcons.clipboardList
                        : LucideIcons.receiptText,
                  ),
                  label: const Text("Pesanan"),
                  selected: currentIndex == 2,
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
                BottomBarItem(
                  icon: const Icon(LucideIcons.userRound),
                  label: const Text("Profile"),
                  selected: currentIndex == 3,
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
