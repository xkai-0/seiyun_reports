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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ProfileHeader(viewModel: viewModel),
            const SizedBox(height: 120), // لتعويض تداخل الـ Positioned في الـ Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RewardsCard(),
                  const SizedBox(height: 30),
                  const _SectionTitle(title: "الإعدادات العامة"),
                  const SizedBox(height: 15),
                  SettingsItem(
                    icon: Icons.notifications_active_outlined,
                    title: "تنبيهات التطبيق",
                    subtitle: "تلقي تحديثات حول البلاغات الجديدة",
                    trailing: Switch.adaptive(
                      value: viewModel.notificationsEnabled,
                      onChanged: (v) => viewModel.toggleNotifications(v),
                      activeColor: AppTheme.primaryColor,
                    ),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.language_outlined,
                    title: "لغة التطبيق",
                    subtitle: "العربية (اليمن)",
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.dark_mode_outlined,
                    title: "الوضع الليلي",
                    subtitle: "تفعيل السمات الداكنة",
                    trailing: Switch.adaptive(
                      value: viewModel.isDarkMode,
                      onChanged: (v) => viewModel.toggleTheme(v),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 25),
                  const _SectionTitle(title: "الدعم والمساعدة"),
                  const SizedBox(height: 15),
                  SettingsItem(
                    icon: Icons.help_outline,
                    title: "مركز المساعدة",
                    subtitle: "الأسئلة الشائعة وطرق الاستخدام",
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.info_outline,
                    title: "حول التطبيق",
                    subtitle: "معلومات الإصدار وسياسة الخصوصية",
                    onTap: () {},
                  ),
                  const SizedBox(height: 30),
                  LogoutButton(viewModel: viewModel),
                  const SizedBox(height: 40),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "صُنع بكل حب في حضرموت ❤️",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "نسخة التطبيق 1.2.0",
                          style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D3436),
      ),
    );
  }
}
