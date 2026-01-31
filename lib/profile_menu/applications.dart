import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);
    const Color scaffoldBg = Color(0xFFF8FAFC);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: CustomScrollView(
        slivers: [
          // هيدر شيك بنفس روح الـ Personal Info
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            elevation: 0,
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
              title: const Text(
                "My Applications",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [darkGreen, primaryGreen],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),

          // قائمة التقديمات
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader("Recent Activities"),
                const SizedBox(height: 15),
                _buildApplicationCard(
                  companyName: "Google",
                  jobTitle: "Senior UX Designer",
                  status: "Pending",
                  date: "24 Jan 2026",
                  logo: Icons.api, // ممكن تبدليها بـ Image.asset
                  statusColor: Colors.orange,
                ),
                _buildApplicationCard(
                  companyName: "Spotify",
                  jobTitle: "Product Designer",
                  status: "Accepted",
                  date: "12 Jan 2026",
                  logo: Icons.audiotrack,
                  statusColor: primaryGreen,
                ),
                _buildApplicationCard(
                  companyName: "Amazon",
                  jobTitle: "UI Developer",
                  status: "Rejected",
                  date: "05 Jan 2026",
                  logo: Icons.cloud_queue,
                  statusColor: Colors.redAccent,
                ),
                const SizedBox(height: 20),
                // زرار Gradient في أخر الصفحة لو عايزة يشوف وظيف أكتر
                _buildGradientButton("Find More Jobs", darkGreen, primaryGreen),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF1A1D3D),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildApplicationCard({
    required String companyName,
    required String jobTitle,
    required String status,
    required String date,
    required IconData logo,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // لوگو الشركة (بشكل دائري شيك)
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(logo, color: statusColor, size: 28),
          ),
          const SizedBox(width: 15),
          // تفاصيل الوظيفة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: const TextStyle(
                    color: Color(0xFF1A1D3D),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  companyName,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
          // الحالة والتاريخ
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(String text, Color dark, Color light) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [dark, light]),
        boxShadow: [
          BoxShadow(
            color: light.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
