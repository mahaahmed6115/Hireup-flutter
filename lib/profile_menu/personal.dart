import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان الموحدة للبروجكت
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);
    const Color scaffoldBg = Color(0xFFF8FAFC);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: CustomScrollView(
        slivers: [
          // --- الهيدر الاحترافي مع تدرج الألوان وصورة البروفايل ---
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            elevation: 0,
            stretch: true,
            backgroundColor: darkGreen,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [darkGreen, primaryGreen],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    // صورة البروفايل بـ Border أبيض خفيف
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(
                          'assets/images/Ellipse.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Haley Jessica",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "haley.jessica@example.com",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- محتوى الصفحة ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("General Information"),
                  const SizedBox(height: 12),

                  // كارت معلومات المستخدم
                  _buildInfoCard([
                    _buildInfoTile(
                      Icons.person_outline,
                      "Full Name",
                      "Haley Jessica",
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      Icons.work_outline,
                      "Job Title",
                      "UX Designer",
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      Icons.cake_outlined,
                      "Birthday",
                      "15 June 1998",
                    ),
                    _buildDivider(),
                    _buildInfoTile(Icons.transgender, "Gender", "Female"),
                  ]),

                  const SizedBox(height: 25),
                  _buildSectionTitle("Contact Details"),
                  const SizedBox(height: 12),

                  // كارت بيانات الاتصال
                  _buildInfoCard([
                    _buildInfoTile(
                      Icons.phone_android,
                      "Phone",
                      "+20 123 456 7890",
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      Icons.location_on_outlined,
                      "Location",
                      "Cairo, Egypt",
                    ),
                  ]),

                  const SizedBox(height: 40),

                  // --- زرار التعديل الـ Gradient (نفس ستايل الهيدر) ---
                  GestureDetector(
                    onTap: () {
                      // هنا تفتحي صفحة التعديل
                    },
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [darkGreen, primaryGreen],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryGreen.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Edit Personal Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لعنوان القسم
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF1A1D3D),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ويدجت لتصميم الكارت الأبيض
  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // ويدجت لعرض كل معلومة (Tile)
  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff35CA60).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xff35CA60), size: 22),
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: Color(0xFF1A1D3D),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: Colors.grey,
      ),
    );
  }

  // فواصل خفيفة جداً بين المعلومات
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade50,
      indent: 70, // عشان يبدأ من بعد الأيقونة
      endIndent: 20,
    );
  }
}
