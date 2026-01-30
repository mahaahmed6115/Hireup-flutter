import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/jop_preference.dart';

class Joptype extends StatefulWidget {
  const Joptype({super.key});

  @override
  State<Joptype> createState() => _JoptypeState();
}

class _JoptypeState extends State<Joptype> {
  final List<String> _selectedTypes = [];

  final List<Map<String, dynamic>> _jobTypes = [
    {'name': 'Full-Time', 'icon': Icons.access_time},
    {'name': 'Part-Time', 'icon': Icons.more_time},
    {'name': 'Contract', 'icon': Icons.description_outlined},
    {'name': 'Internship', 'icon': Icons.card_membership_outlined},
    {'name': 'Freelance', 'icon': Icons.person_search_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    bool isButtonActive = _selectedTypes.isNotEmpty;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black, size: 22.w),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'HireUp',
            style: TextStyle(
              color: const Color(0xFF5E8D5E),
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Select your preferred\nemployment type',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1D3D),
                ),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _jobTypes.length,
                  itemBuilder: (context, index) {
                    String typeName = _jobTypes[index]['name'];
                    bool isSelected = _selectedTypes.contains(typeName);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedTypes.remove(typeName);
                          } else {
                            _selectedTypes.add(typeName);
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15.h),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5E8D5E)
                                : Colors.grey.shade100,
                            width: 1.5.w,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.green.withOpacity(0.05),
                                blurRadius: 10.r,
                                spreadRadius: 2.r,
                              ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _jobTypes[index]['icon'],
                              color: Colors.grey[600],
                              size: 22.w,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              typeName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 22.h,
                              width: 22.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? const Color(0xFF5E8D5E)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF5E8D5E)
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: isSelected
                                  ? Icon(
                                Icons.check,
                                size: 16.sp,
                                color: Colors.white,
                              )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: isButtonActive
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JobPreferences(),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonActive
                          ? const Color(0xFF5E8D5E)
                          : Colors.grey[300],
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
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
    );
  }
}
