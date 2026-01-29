import 'package:flutter/material.dart';
import 'package:hireup/profile_menu/resume.dart';
// تأكدي إن المسار صح حسب مكان ملفك

class Profilemenu extends StatelessWidget {
  const Profilemenu({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان اللي ماشيين بيها في البروجكت
    const Color themeGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // --- محتوى المنيو ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Haley Jessica',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1D3D),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'UX Designer',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.verified, color: themeGreen, size: 16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'View Profile',
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // القائمة المعدلة بالكامل
                    _buildMenuItem(
                      context,
                      Icons.person_outline,
                      'Personal Info',
                    ),

                    // --- إضافة أيقونة تدريب الـ AI الجديدة هنا (بناءً على فكرة مشروعك) ---
                    _buildMenuItem(
                      context,
                      Icons.psychology_outlined,
                      'AI Interview Trainer',
                      isAI: true,
                    ),

                    _buildMenuItem(
                      context,
                      Icons.assignment_outlined,
                      'Applications',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.description_outlined,
                      'Proposals',
                    ),

                    // تعديل زر Resumes لينتقل لصفحة الرفع الجديدة
                    _buildMenuItem(
                      context,
                      Icons.contact_page_outlined,
                      'Resumes',
                      onTap: () {
                        Navigator.pop(context); // إغلاق المنيو
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
                    ),
                    _buildMenuItem(
                      context,
                      Icons.logout,
                      'Logout',
                      isLogout: true,
                    ),

                    const SizedBox(height: 30),

                    // زرار Go Premium باللون الأخضر
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [themeGreen, darkGreen],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: themeGreen.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.stars, color: Colors.white),
                        label: const Text(
                          'Go Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Ellipse.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // زرار القفل
            Positioned(
              top: 15,
              right: 15,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت القائمة المعدل ليدعم التنقل والتمييز
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isLogout
              ? Colors.red.withOpacity(0.1)
              : (isAI
                    ? const Color(0xff35CA60).withOpacity(0.1)
                    : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isLogout
              ? Colors.red
              : (isAI ? const Color(0xff35CA60) : Colors.grey.shade700),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isAI ? FontWeight.bold : FontWeight.w500,
          color: isLogout ? Colors.red : const Color(0xFF1A1D3D),
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap:
          onTap ??
          () {
            if (isAI) {
              // هنا ممكن تحطي Navigator يفتح شاشة تدريب الـ AI
            }
          },
    );
  }
}
