import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/message_screens/archive.dart';
import 'package:hireup/message_screens/interview.dart';
import 'package:hireup/message_screens/unread.dart';

import '../Homepage.dart';

// القوائم العامة لضمان الربط الفعلي
List<Map<String, dynamic>> companyMessages = [
  {
    'name': 'Google',
    'sub': 'Are you available for an intervi...',
    'time': '11:45 am',
    'unread': 4,
    'isCompany': true,
    'img': 'assets/images/search.png',
  },
  {
    'name': 'HP',
    'sub': 'We are looking forward to takin...',
    'time': '10:20 am',
    'unread': 1,
    'isCompany': true,
    'img': 'assets/images/hpp.png',
  },
];

List<Map<String, dynamic>> individualMessages = [
  {
    'name': 'Erik John',
    'sub': 'We are looking for a web develo...',
    'time': '11:45 am',
    'unread': 7,
    'isCompany': false,
    'img': 'assets/images/preson1.png',
  },
  {
    'name': 'Jessica Jenith',
    'sub': 'Are you available for an interview...',
    'time': '09:12 am',
    'unread': 0,
    'isCompany': false,
    'img': 'assets/images/person2.png',
  },
];

List<Map<String, dynamic>> archiveList = []; // قائمة الأرشيف العامة

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
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
          'Messages',
          style: TextStyle(
            color: const Color(0xFF1A1D3D),
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildQuickFilters(context),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _buildHeaderSection('Companies'),
                ...companyMessages
                    .map((msg) => _buildDismissibleTile(msg, companyMessages))
                    .toList(),
                SizedBox(height: 20.h),
                _buildHeaderSection('Individual Messages'),
                ...individualMessages
                    .map((msg) => _buildDismissibleTile(msg, individualMessages))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleTile(Map<String, dynamic> msg, List list) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          archiveList.add(msg);
          list.remove(msg);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${msg['name']} moved to Archive"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF1A1D3D),
          ),
        );
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF5E8D5E),
          borderRadius: BorderRadius.circular(16.r),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.archive_outlined, color: Colors.white, size: 28.sp),
            SizedBox(height: 4.h),
            Text(
              "Swipe to Archive",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: _buildMessageTile(msg),
    );
  }

  Widget _buildQuickFilters(BuildContext context) {
    return Container(
      height: 50.h,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
        children: [
          _filterChip(context, 'All', true),
          _filterChip(context, 'Unread', false),
          _filterChip(context, 'Interviews', false),
          _filterChip(context, 'Archive', false),
        ],
      ),
    );
  }

  Widget _filterChip(BuildContext context, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (label == 'Archive') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const ArchiveScreen()),
          ).then((_) => setState(() {}));
        } else if (label == 'Unread') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const UnreadMessagesScreen()),
          );
        } else if (label == 'Interviews') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const InterviewScreen()),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5E8D5E) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageTile(Map<String, dynamic> msg) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 55.w,
            height: 55.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              image: DecorationImage(
                image: AssetImage(msg['img']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      msg['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: const Color(0xFF1A1D3D),
                      ),
                    ),
                    Text(
                      msg['time'],
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  msg['sub'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ),
          if (msg['unread'] != null && msg['unread'] > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF5E8D5E),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${msg['unread']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F8),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search conversations...',
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1D3D),
        ),
      ),
    );
  }
}
