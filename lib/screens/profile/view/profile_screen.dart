import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/profile/viewmodel/profile_viewmodel.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';
import 'package:seiyun_reports_app/screens/profile/view/widgets/profile_header.dart';
import 'package:seiyun_reports_app/screens/profile/view/widgets/rewards_card.dart';
import 'package:seiyun_reports_app/screens/profile/view/widgets/settings_item.dart';
import 'package:seiyun_reports_app/screens/profile/view/widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(viewModel: viewModel),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const RewardsCard(),
                    const SizedBox(height: 25),
                    const Text(
                      "الإعدادات",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SettingsItem(
                      icon: Icons.location_on,
                      title: "موقعي",
                      subtitle: "تعديل الموقع الحالي",
                      onTap: () {},
                    ),
                    SettingsItem(
                      icon: Icons.notifications,
                      title: "الإشعارات",
                      subtitle: "تلقي إشعارات حول البلاغات",
                      trailing: Switch(
                        value: true,
                        onChanged: (v) {},
                        activeColor: AppTheme.accentGreen,
                      ),
                      onTap: () {},
                    ),
                    SettingsItem(
                      icon: Icons.settings,
                      title: "الاعدادات العامة",
                      subtitle: "اللغة، الوضع الليلي، وأكثر",
                      onTap: () {},
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "الحساب",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LogoutButton(viewModel: viewModel),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "نسخة التطبيق 1.0.0",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
