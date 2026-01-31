import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hireup/profile_menu/applications.dart';
import 'package:hireup/profile_menu/firstaiscreen.dart';
import 'package:hireup/profile_menu/personal.dart' show PersonalInfoScreen;
import 'package:hireup/profile_menu/proposl.dart' show ProposalsScreen;
import 'package:hireup/profile_menu/resume.dart';
import 'package:hireup/profile_menu/setting.dart';

class Profilemenu extends StatelessWidget {
  const Profilemenu({super.key});

  @override
  Widget build(BuildContext context) {
    const Color themeGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 20.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Haley Jessica',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1D3D),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'UX Designer',
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                        SizedBox(width: 5.w),
                        Icon(Icons.verified, color: themeGreen, size: 16.sp),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'View Profile',
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    _buildMenuItem(
                      context,
                      Icons.person_outline,
                      'Personal Info',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalInfoScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.psychology_outlined,
                      'AI Interview Trainer',
                      isAI: true,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.assignment_outlined,
                      'Applications',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ApplicationsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.description_outlined,
                      'Proposals',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProposalsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.contact_page_outlined,
                      'Resumes',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResumeUploadScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.settings_outlined,
                      'Settings',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      Icons.logout,
                      'Logout',
                      isLogout: true,
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      width: double.infinity,
                      height: 55.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [themeGreen, darkGreen],
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: themeGreen.withOpacity(0.3),
                            blurRadius: 10.r,
                            offset: Offset(0, 5.h),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.stars, color: Colors.white, size: 20.sp),
                        label: Text(
                          'Go Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -50.h,
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.r,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Ellipse.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15.h,
              right: 15.w,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.grey, size: 20.sp),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String title, {
        bool isLogout = false,
        bool isAI = false,
        VoidCallback? onTap,
      }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isLogout
              ? Colors.red.withOpacity(0.1)
              : (isAI ? const Color(0xff35CA60).withOpacity(0.1) : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          size: 20.sp,
          color: isLogout
              ? Colors.red
              : (isAI ? const Color(0xff35CA60) : Colors.grey.shade700),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isAI ? FontWeight.bold : FontWeight.w500,
          color: isLogout ? Colors.red : const Color(0xFF1A1D3D),
        ),
      ),
      trailing: isLogout
          ? null
          : Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
      onTap: onTap ??
              () {
            if (isAI) {
              // ممكن تحطي Navigator لشاشة الـ AI هنا
            }
          },
    );
  }
}
