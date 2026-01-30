import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/homepage.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  // دالة الحذف من داخل صفحة السيفد وإظهار رسالة تأكيد
  void _removeFromSaved(int index) {
    setState(() {
      savedJobs.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from Saved'),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1D3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
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
            'Save Page',
            style: TextStyle(
              color: const Color(0xFF1A1D3D),
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
        ),
        body: savedJobs.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: savedJobs.length,
          itemBuilder: (context, index) {
            final job = savedJobs[index];
            return _buildSavedJobCard(job, index);
          },
        ),
      ),
    );
  }

  Widget _buildSavedJobCard(Map<String, dynamic> job, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
          Container(
            height: 55.h,
            width: 55.w,
            decoration: BoxDecoration(
              color: job['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(job['logo'], color: job['color'], size: 28.r),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['role'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: const Color(0xFF1A1D3D),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  job['company'],
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
                SizedBox(height: 6.h),
                Text(
                  job['location'],
                  style: TextStyle(
                    color: const Color(0xFF5E8D5E),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.bookmark, color: Colors.yellow, size: 28.r),
            onPressed: () => _removeFromSaved(index),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 80.r,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 20.h),
          Text(
            'Your list is empty',
            style: TextStyle(
              color: const Color(0xFF1A1D3D),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Saved jobs will appear here.',
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
