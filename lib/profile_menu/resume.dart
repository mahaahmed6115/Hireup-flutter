import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum UploadStatus { initial, uploading, uploaded }

class ResumeUploadScreen extends StatefulWidget {
  const ResumeUploadScreen({super.key});

  @override
  State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {
  UploadStatus _currentStatus = UploadStatus.initial;
  double _progress = 0.0;
  Timer? _timer;

  String? _fileName;
  String? _fileSize;

  final Color themeGreen = const Color(0xff35CA60);
  final Color darkGreen = const Color(0xFF0B6A4D);
  final Color darkBlue = const Color(0xFF1A1D3D);

  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _fileName = file.name;
        _fileSize = "${(file.size / 1024).toStringAsFixed(1)} KB";
        _currentStatus = UploadStatus.uploading;
        _progress = 0.0;
      });

      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {
          if (_progress < 1) {
            _progress += 0.02;
          } else {
            _timer?.cancel();
            _currentStatus = UploadStatus.uploaded;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: darkBlue, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Resume & Portfolio',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resume or CV',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),

            SizedBox(height: 15.h),

            DottedBorder(
              color: themeGreen.withOpacity(0.5),
              strokeWidth: 2,
              dashPattern: const [8, 4],
              borderType: BorderType.RRect,
              radius: Radius.circular(20.r),
              child: Container(
                width: double.infinity,
                padding:
                EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                child: _buildUploadContent(),
              ),
            ),

            SizedBox(height: 35.h),

            _buildPortfolioGrid(),

            SizedBox(height: 50.h),

            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadContent() {
    if (_currentStatus == UploadStatus.initial) {
      return Column(
        children: [
          Text(
            'Upload your CV or Resume and use it\nwhen you apply for jobs',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
          SizedBox(height: 25.h),
          _buildActionButton('Upload', _pickAndUploadFile),
        ],
      );
    } else if (_currentStatus == UploadStatus.uploading) {
      return Column(
        children: [
          Text(
            'Uploading: $_fileName',
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
          SizedBox(height: 30.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 8.w,
                  backgroundColor: Colors.grey.shade100,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(themeGreen),
                ),
              ),
              Text(
                '${(_progress * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.cancel_outlined,
                  color: Colors.grey, size: 22.sp),
              onPressed: () =>
                  setState(() => _currentStatus = UploadStatus.initial),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              children: [
                Icon(Icons.picture_as_pdf,
                    color: Colors.red, size: 40.sp),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fileName ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _fileSize ?? '',
                        style:
                        TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle,
                    color: themeGreen, size: 22.sp),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          _buildActionButton('Add More', _pickAndUploadFile),
        ],
      );
    }
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: ElevatedButton(
        onPressed: _currentStatus == UploadStatus.uploaded ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _currentStatus == UploadStatus.uploaded
              ? darkGreen
              : Colors.grey.shade300,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 180.w,
      height: 55.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
      mainAxisSpacing: 15.h,
      crossAxisSpacing: 15.w,
      childAspectRatio: 3,
      children: [
        _buildPortfolioBtn('Portfolio Link'),
        _buildPortfolioBtn('Add Slide'),
        _buildPortfolioBtn('Portfolio (Optional)'),
        _buildPortfolioBtn('Add Photos'),
      ],
    );
  }

  Widget _buildPortfolioBtn(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(title, style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }
}
