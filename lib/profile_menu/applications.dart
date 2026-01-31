import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            expandedHeight: 180.h,
            pinned: true,
            elevation: 0,
            backgroundColor: darkGreen,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "My Applications",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
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
                    size: 80.sp,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),

          // قائمة التقديمات
          SliverPadding(
            padding: EdgeInsets.all(20.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader("Recent Activities"),
                SizedBox(height: 15.h),
                _buildApplicationCard(
                  companyName: "Google",
                  jobTitle: "Senior UX Designer",
                  status: "Pending",
                  date: "24 Jan 2026",
                  logo: Icons.api,
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
                SizedBox(height: 20.h),
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
      style: TextStyle(
        color: Color(0xFF1A1D3D),
        fontSize: 18.sp,
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
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // لوگو الشركة
          Container(
            width: 55.w,
            height: 55.h,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Icon(logo, color: statusColor, size: 28.sp),
          ),
          SizedBox(width: 15.w),
          // تفاصيل الوظيفة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: TextStyle(
                    color: Color(0xFF1A1D3D),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  companyName,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          // الحالة والتاريخ
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                date,
                style: TextStyle(color: Colors.grey, fontSize: 11.sp),
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
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: LinearGradient(colors: [dark, light]),
        boxShadow: [
          BoxShadow(
            color: light.withOpacity(0.3),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
