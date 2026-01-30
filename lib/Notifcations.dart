import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Homepage.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 965),
      minTextAdapt: true,
      builder: (context, child) => Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: const Color(0xFF1A1D3D),
              size: 20.w,
            ),
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
            'Notifications',
            style: TextStyle(
              color: const Color(0xFF1A1D3D),
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('New activity'),
              SizedBox(height: 15.h),
              _buildActivityTile(
                title: 'Fiverr',
                sub:
                'want to take a final interview of you where head of HR will see you!',
                time: '12 min ago',
                img: 'assets/images/fiver.png',
                isNew: true,
              ),
              _buildActivityTile(
                title: 'Macdonald',
                sub:
                'want to contact with you in 24 hours with proper preparation',
                time: '47 min ago',
                img: 'assets/images/mac.png',
                isNew: true,
              ),
              SizedBox(height: 25.h),
              _buildSectionHeader('Applications', hasSeeAll: true),
              SizedBox(height: 15.h),
              _buildApplicationTile(
                company: 'BMW',
                status: 'Your application is submitted successfully',
                time: '1 hrs ago',
                img: 'assets/images/bmw.png',
              ),
              _buildApplicationTile(
                company: 'Booking.com',
                status:
                'reviewing your application, cover letter and portfolio. All the best!',
                time: '3 hrs ago',
                img: 'assets/images/booking.png',
              ),
              SizedBox(height: 25.h),
              _buildSectionHeader('Interview', hasSeeAll: true),
              SizedBox(height: 15.h),
              _buildInterviewTile(
                company: 'Beats',
                sub:
                'Congratulations! Beats liked your resume and want to take an interview of you.',
                time: '4 hrs ago',
                img: 'assets/images/image 8.png',
              ),
              _buildInterviewTile(
                company: 'Behance',
                sub:
                'Congratulations! You passed the first round on Behance. Be prepare for next!',
                time: '6 hrs ago',
                img: 'assets/images/behance.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool hasSeeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1D3D),
          ),
        ),
        if (hasSeeAll)
          Text(
            'See all',
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
      ],
    );
  }

  Widget _buildActivityTile({
    required String title,
    required String sub,
    required String time,
    required String img,
    bool isNew = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 25.r, backgroundImage: AssetImage(img)),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    children: [
                      TextSpan(
                        text: '$title ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: sub),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                    if (isNew) ...[
                      SizedBox(width: 8.w),
                      CircleAvatar(
                        radius: 4.r,
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationTile({
    required String company,
    required String status,
    required String time,
    required String img,
  }) {
    return _buildActivityTile(
      title: company,
      sub: status,
      time: time,
      img: img,
    );
  }

  Widget _buildInterviewTile({
    required String company,
    required String sub,
    required String time,
    required String img,
  }) {
    return _buildActivityTile(title: company, sub: sub, time: time, img: img);
  }
}
