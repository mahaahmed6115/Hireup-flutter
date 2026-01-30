import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xFF1A1D3D),
            size: 20.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Job Interviews',
          style: TextStyle(
            color: const Color(0xFF1A1D3D),
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildInterviewCard(
            context,
            'Google',
            'Senior Flutter Developer',
            'Today, 02:00 PM',
            'Online - Google Meet',
            'assets/images/search.png',
            Colors.blue,
          ),
          _buildInterviewCard(
            context,
            'HP',
            'Mobile App Engineer',
            'Tomorrow, 10:00 AM',
            'At Company Office',
            'assets/images/hpp.png',
            Colors.indigo,
          ),
        ],
      ),
    );
  }

  Widget _buildInterviewCard(
      BuildContext context,
      String company,
      String role,
      String time,
      String location,
      String img,
      Color accentColor,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(16.w),
            leading: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              company,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            ),
            subtitle: Text(
              role,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            trailing: Icon(Icons.videocam_outlined, color: Colors.grey, size: 22.sp),
          ),
          Divider(height: 1.h, thickness: 1.h),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF5E8D5E).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Join Now',
                    style: TextStyle(
                      color: const Color(0xFF5E8D5E),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
