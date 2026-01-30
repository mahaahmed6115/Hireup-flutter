import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Homepage.dart';

class TrackingScreen extends StatelessWidget {
  final Map<String, dynamic> job;

  const TrackingScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF5E8D5E);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: darkBlue, size: 24.w),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          },
        ),
        title: Text(
          'Applied Job Details',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),

            // الكارد اللي فوق
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: primaryGreen.withOpacity(0.3),
                  width: 1.5,
                ),
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
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Icon(
                      Icons.facebook,
                      size: 45.w,
                      color: const Color(0xFF1877F2),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job['role'] ?? 'Software Intern',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: darkBlue,
                          ),
                        ),
                        Text(
                          job['company'] ?? 'Facebook',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        job['salary'] ?? '\$88,000/y',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryGreen,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        job['location'] ?? 'Los Angeles, US',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            Text(
              'Track Application',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: darkBlue,
              ),
            ),
            SizedBox(height: 20.h),

            // خطوات التتبع
            _buildTimelineStep('Offer letter', 'Not yet', false, false, true),
            _buildTimelineStep('Team matching', '29/06/22   02:00 pm', true, false, false),
            _buildTimelineStep('Final HR interview', '21/06/22   04:00 pm', true, true, false),
            _buildTimelineStep('Technical interview', '12/06/22   10:00 am', true, true, false),
            _buildTimelineStep('Screening interview', '05/06/22   11:00 am', true, true, false),
            _buildTimelineStep('Reviewed by Spotify team', '25/05/22   09:00 am', true, true, false),
            _buildTimelineStep('Application submitted', '17/05/22   11:00 am', true, true, false, isLast: true),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(
      String title,
      String subtitle,
      bool isActive,
      bool showCheck,
      bool isFuture, {
        bool isLast = false,
      }) {
    const Color greenTheme = Color(0xFF5E8D5E);
    Color greyTheme = Colors.grey;

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              isFuture
                  ? Icon(Icons.emoji_events_outlined, color: greyTheme, size: 24.w)
                  : Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: showCheck ? greenTheme : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: greenTheme, width: 2),
                ),
                child: showCheck
                    ? Icon(Icons.check, color: Colors.white, size: 12.w)
                    : Center(
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: greenTheme,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isFuture ? greyTheme : greenTheme,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 15.w),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: const Color(0xFF1A1D3D)),
                ),
                SizedBox(height: 5.h),
                Text(
                  subtitle,
                  style: TextStyle(
                      color: isFuture ? Colors.grey.shade400 : Colors.grey,
                      fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
