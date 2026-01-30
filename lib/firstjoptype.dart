import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/joptype.dart';

class FirstJobType extends StatefulWidget {
  const FirstJobType({super.key});

  @override
  State<FirstJobType> createState() => _FirstJobTypeState();
}

class _FirstJobTypeState extends State<FirstJobType> {
  final List<String> _selectedJobs = [];

  final List<Map<String, dynamic>> _jobs = [
    {'name': 'Designer', 'icon': Icons.brush_outlined},
    {'name': 'Developer', 'icon': Icons.code},
    {'name': 'Administrative', 'icon': Icons.settings_outlined},
    {'name': 'Marketing', 'icon': Icons.campaign_outlined},
    {'name': 'Management', 'icon': Icons.business_center_outlined},
    {'name': 'Others', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    bool isButtonActive = _selectedJobs.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.close, color: Colors.black, size: 20.sp),
        title: Text(
          'HireUp',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18.sp),
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
              'What type of job you’re\nlooking for?',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1D3D),
              ),
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.builder(
                itemCount: _jobs.length,
                itemBuilder: (context, index) {
                  String jobName = _jobs[index]['name'];
                  bool isSelected = _selectedJobs.contains(jobName);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedJobs.remove(jobName);
                        } else {
                          _selectedJobs.add(jobName);
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
                          color: isSelected ? Colors.green : Colors.grey.shade100,
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            spreadRadius: 1.r,
                            blurRadius: 5.r,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(_jobs[index]['icon'], color: Colors.grey, size: 24.sp),
                          SizedBox(width: 15.w),
                          Text(
                            jobName,
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
                              color: isSelected ? Colors.green : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? Colors.green : Colors.grey.shade300,
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
                      MaterialPageRoute(builder: (context) => const Joptype()),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonActive
                        ? const Color(0xFF5E8D5E)
                        : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
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
    );
  }
}
