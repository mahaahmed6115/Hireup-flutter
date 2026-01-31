import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // لازم تهيئي ScreenUtil في الـ main قبل MaterialApp
    // ScreenUtil.init(context, designSize: Size(440, 965));

    const Color primaryGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);
    const Color scaffoldBg = Color(0xFFF8FAFC);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.h,
            pinned: true,
            elevation: 0,
            stretch: true,
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
                    SizedBox(height: 50.h),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2.w,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45.r,
                        backgroundImage: AssetImage(
                          'assets/images/Ellipse.png',
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Haley Jessica",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "haley.jessica@example.com",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("General Information"),
                  SizedBox(height: 12.h),

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

                  SizedBox(height: 25.h),
                  _buildSectionTitle("Contact Details"),
                  SizedBox(height: 12.h),

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

                  SizedBox(height: 40.h),

                  GestureDetector(
                    onTap: () {
                      // هنا تفتحي صفحة التعديل
                    },
                    child: Container(
                      width: double.infinity,
                      height: 58.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [darkGreen, primaryGreen],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryGreen.withOpacity(0.3),
                            blurRadius: 15.r,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Edit Personal Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xFF1A1D3D),
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Color(0xff35CA60).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: Color(0xff35CA60), size: 22.sp),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: Color(0xFF1A1D3D),
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 12.sp,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      color: Colors.grey.shade50,
      indent: 70.w,
      endIndent: 20.w,
    );
  }
}
