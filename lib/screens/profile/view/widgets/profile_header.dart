import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';
import 'package:seiyun_reports_app/screens/profile/viewmodel/profile_viewmodel.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileViewModel viewModel;

  const ProfileHeader({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final user = viewModel.currentUser;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppTheme.headerGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 20, right: 30),
              child: Text(
                "الملف الشخصي",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.creamColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildAvatar(context),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? "أحمد محمد العلي",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const Text(
                        "مستخدم منذ يناير 2025",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                        Icons.email_outlined,
                        user?.email ?? "ahmad.ali@email.com",
                      ),
                      _buildInfoRow(Icons.phone_outlined, "+967 766 123 457"),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        "شارع الجزائر - جولة الغوير شمالاً",
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.edit_note, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('المعرض'),
                onTap: () {
                  viewModel.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('الكاميرا'),
                onTap: () {
                  viewModel.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
          backgroundImage:
              viewModel.profileImage != null
                  ? FileImage(viewModel.profileImage!)
                  : null,
          child:
              viewModel.profileImage == null
                  ? const Icon(
                    Icons.person,
                    size: 40,
                    color: AppTheme.primaryColor,
                  )
                  : null,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: GestureDetector(
            onTap: () => _showPicker(context),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
