import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/Notifcations.dart';
import 'package:hireup/jop_details/jopdetails.dart';
import 'package:hireup/message_screens/messagescreen.dart';
import 'package:hireup/profile_menu/ProfileMenu.dart';
import 'package:hireup/saved.dart';
import 'ai/ElevenLabsWebView.dart'; // ✅ الشات بوت

List<Map<String, dynamic>> savedJobs = [];

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  void _toggleSaveJob(Map<String, dynamic> jobData) {
    setState(() {
      int index = savedJobs.indexWhere(
            (job) =>
        job['company'] == jobData['company'] &&
            job['role'] == jobData['role'],
      );

      if (index != -1) {
        savedJobs.removeAt(index);
        _showStatusMessage('Removed from Saved');
      } else {
        savedJobs.add(jobData);
        _showStatusMessage('Added to Saved');
      }
    });
  }

  void _showStatusMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1D3D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      _buildHomeScreenContent(),
      const MessagesScreen(),
      const SavedJobsScreen(),
      const NotificationsScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: _screens[_currentIndex],

      floatingActionButton: Container(
        width: 62.w,
        height: 62.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF5E8D5E),
              Color(0xFF3F6B3F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.smart_toy_rounded,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ElevenLabsWebView(),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF5E8D5E),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreenContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildHeader(),
            SizedBox(height: 25.h),
            _buildSearchRow(),
            SizedBox(height: 30.h),
            _buildSectionHeader('Featured Jobs'),
            SizedBox(height: 15.h),
            _buildFeaturedList(),
            SizedBox(height: 30.h),
            _buildSectionHeader('Popular Jobs'),
            SizedBox(height: 15.h),
            _buildPopularJobTile(
              'Jr Executive',
              'Burger King',
              '\$96,000/y',
              'Los Angeles, US',
            ),
            _buildPopularJobTile(
              'Product Manager',
              'Beats',
              '\$84,000/y',
              'Florida, US',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to HireUP!',
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            Text(
              'Discover Jobs',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1D3D),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () =>
              showDialog(context: context, builder: (c) => const Profilemenu()),
          child: CircleAvatar(
            radius: 25.r,
            backgroundImage: const AssetImage('assets/images/Ellipse.png'),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search a job or position',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Icon(Icons.tune, color: Color(0xFF5E8D5E)),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Text('See all', style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 180.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFeaturedCard(
            company: 'Facebook',
            role: 'Software Engineer',
            salary: '\$180,00/year',
            location: 'California, USA',
            color: const Color(0xFF6B946B),
            logo: Icons.facebook,
          ),
          _buildFeaturedCard(
            company: 'Google',
            role: 'Full-Stack Dev',
            salary: '\$160,00/year',
            location: 'Mountain View, CA',
            color: const Color(0xFF8DB08D),
            logo: Icons.api,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard({
    required String company,
    required String role,
    required String salary,
    required String location,
    required Color color,
    required IconData logo,
  }) {
    bool isSaved = savedJobs.any(
          (j) => j['company'] == company && j['role'] == role,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(
              job: {
                'company': company,
                'role': role,
                'salary': salary,
                'location': location,
                'color': color,
                'logo': logo,
              },
            ),
          ),
        );
      },
      child: Container(
        width: 280.w,
        margin: EdgeInsets.only(right: 15.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(logo, color: Colors.blue, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.sp),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    _toggleSaveJob({
                      'company': company,
                      'role': role,
                      'salary': salary,
                      'location': location,
                      'color': color,
                      'logo': logo,
                    });
                  },
                  child: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
                    color: isSaved ? Colors.yellow : Colors.white,
                    size: 26.sp,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                _buildTag('IT'),
                _buildTag('Full-Time'),
                _buildTag('Junior'),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  salary,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      ),
    );
  }

  Widget _buildPopularJobTile(String title, String company, String salary, String loc) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(
              job: {
                'role': title,
                'company': company,
                'salary': salary,
                'location': loc,
                'color': const Color(0xFF5E8D5E),
                'logo': Icons.business,
              },
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.business, color: Colors.orange),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    company,
                    style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  salary,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                Text(
                  loc,
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
