import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart'; // المكتبة المسؤولة عن فتح ملفات الفون

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

  // متغيرات لحفظ بيانات ملفك الحقيقي
  String? _fileName;
  String? _fileSize;

  final Color themeGreen = const Color(0xff35CA60);
  final Color darkGreen = const Color(0xFF0B6A4D);
  final Color darkBlue = const Color(0xFF1A1D3D);

  // دالة اختيار ملف من الفون وبدء التحميل
  Future<void> _pickAndUploadFile() async {
    // 1. فتح ملفات الفون لاختيار PDF أو Doc
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      // 2. سحب بيانات الملف الحقيقي
      PlatformFile file = result.files.first;

      setState(() {
        _fileName = file.name;
        // تحويل الحجم من bytes لـ KB بشكل حقيقي
        _fileSize = "${(file.size / 1024).toStringAsFixed(1)} KB";
        _currentStatus = UploadStatus.uploading;
        _progress = 0.0;
      });

      // 3. بدء أنميشن التحميل التدريجي
      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {
          if (_progress < 1.0) {
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
          icon: Icon(Icons.arrow_back_ios_new, color: darkBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Resume & Portfolio',
          style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resume or CV',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1D3D),
              ),
            ),
            const SizedBox(height: 15),
            DottedBorder(
              color: themeGreen.withOpacity(0.5),
              strokeWidth: 2,
              dashPattern: const [8, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: _buildUploadContent(),
              ),
            ),
            const SizedBox(height: 35),
            _buildPortfolioGrid(),
            const SizedBox(height: 50),
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
          const Text(
            'Upload your CV or Resume and use it\nwhen you apply for jobs',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 25),
          _buildActionButton('Upload', _pickAndUploadFile),
        ],
      );
    } else if (_currentStatus == UploadStatus.uploading) {
      return Column(
        children: [
          Text(
            'Uploading: $_fileName',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(themeGreen),
                ),
              ),
              Text(
                '${(_progress * 100).toInt()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      );
    } else {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
              onPressed: () =>
                  setState(() => _currentStatus = UploadStatus.initial),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fileName ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _fileSize ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, color: themeGreen),
              ],
            ),
          ),
          const SizedBox(height: 25),
          _buildActionButton('Add More', _pickAndUploadFile),
        ],
      );
    }
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _currentStatus == UploadStatus.uploaded ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _currentStatus == UploadStatus.uploaded
              ? darkGreen
              : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 180,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
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
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(child: Text(title, style: const TextStyle(fontSize: 14))),
    );
  }
}
