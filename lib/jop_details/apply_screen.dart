import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/jop_details/success_screen.dart';

class ApplyJobScreen extends StatefulWidget {
  final Map<String, dynamic> job;

  const ApplyJobScreen({super.key, required this.job});

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  bool isProfileSelected = false;
  bool isResumeSelected = false;
  String? _uploadedFileName;

  bool get isReadyToApply => isProfileSelected && isResumeSelected;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _uploadedFileName = result.files.single.name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected: $_uploadedFileName'),
          backgroundColor: const Color(0xFF5E8D5E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF5E8D5E);
    const Color darkBlue = Color(0xFF1A1D3D);
    const Color textDark = Color(0xFF333333);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: darkBlue, size: 22.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Apply',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              _buildJobSummary(darkBlue),

              SizedBox(height: 25.h),

              _sectionTitle('Select a profile', darkBlue),
              SizedBox(height: 12.h),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildProfileCard(darkBlue),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              _sectionTitle('Select a resume', darkBlue),
              SizedBox(height: 12.h),

              _buildResumeCard(darkBlue),

              SizedBox(height: 25.h),

              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: const [
                    TextSpan(text: 'Cover Letter '),
                    TextSpan(
                      text: '(Optional)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              _buildCoverLetterInput(textDark),

              SizedBox(height: 30.h),

              SizedBox(
                width: double.infinity,
                height: 58.h,
                child: ElevatedButton(
                  onPressed: isReadyToApply
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SuccessScreen(
                          companyName: 'Facebook',
                          jobRole: widget.job['role'],
                        ),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isReadyToApply
                        ? primaryGreen
                        : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: isReadyToApply ? 3 : 0,
                  ),
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color:
                      isReadyToApply ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17.sp,
        color: color,
      ),
    );
  }

  Widget _buildJobSummary(Color darkBlue) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(
              Icons.facebook,
              size: 40,
              color: Color(0xFF1877F2),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job['role'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: darkBlue,
                  ),
                ),
                const Text(
                  'Facebook',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.job['salary'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: const Color(0xFF5E8D5E),
                ),
              ),
              Text(
                widget.job['location'],
                style: TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Color darkBlue) {
    return GestureDetector(
      onTap: () => setState(() => isProfileSelected = !isProfileSelected),
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isProfileSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundImage:
                  const AssetImage('assets/images/Ellipse.png'),
                ),
                if (isProfileSelected)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: Colors.blue,
                      child:
                      const Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'Haley Jessica',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: darkBlue,
              ),
            ),
            Text(
              'UX Designer',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeCard(Color darkBlue) {
    return GestureDetector(
      onTap: () => setState(() => isResumeSelected = !isResumeSelected),
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isResumeSelected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isResumeSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: isResumeSelected ? Colors.blue : Colors.grey,
            ),
            SizedBox(width: 12.w),
            Text(
              'Resume.pdf',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverLetterInput(Color textDark) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 110.h,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              maxLines: null,
              style: TextStyle(fontSize: 15.sp, color: textDark),
              decoration: const InputDecoration(
                hintText: 'Tell us why you are a good fit...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: _pickPDF,
          child: Container(
            width: 75.w,
            height: 110.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload_outlined,
                    color: Colors.blue, size: 30.sp),
                SizedBox(height: 5.h),
                Text(
                  'Upload\nPDF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
