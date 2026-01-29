import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: darkBlue, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Apply',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildJobSummary(darkBlue),
              const SizedBox(height: 20),

              const Text(
                'Select a profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildProfileCard(darkBlue),

              const SizedBox(height: 20),

              const Text(
                'Select a resume',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              _buildResumeCard(darkBlue),

              const SizedBox(height: 20),

              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
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
              const SizedBox(height: 10),
              _buildCoverLetterInput(textDark),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: isReadyToApply
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessScreen(
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
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: isReadyToApply ? 3 : 0,
                  ),
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      color: isReadyToApply ? Colors.white : Colors.grey[600],
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobSummary(Color darkBlue) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.facebook,
              size: 40,
              color: Color(0xFF1877F2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job['role'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: darkBlue,
                  ),
                ),
                const Text(
                  'Facebook',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.job['salary'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5E8D5E),
                  fontSize: 15,
                ),
              ),
              Text(
                widget.job['location'],
                style: const TextStyle(color: Colors.grey, fontSize: 11),
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
        width: 160,
        padding: const EdgeInsets.all(15), // تقليل المسافات الداخلية
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isProfileSelected ? Colors.blue : Colors.grey.shade300,
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/Ellipse.png'),
                ),
                if (isProfileSelected)
                  const Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Haley Jessica',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: darkBlue,
              ),
            ),
            const Text(
              'UX Designer',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isResumeSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isResumeSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: isResumeSelected ? Colors.blue : Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Resume.pdf',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Haley Jessica CV',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 110,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              maxLines: null,
              style: TextStyle(color: textDark, fontSize: 15),
              decoration: const InputDecoration(
                hintText: 'Tell us why you are a good fit...',
                hintStyle: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _pickPDF,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 75,
            height: 110,
            decoration: BoxDecoration(
              color: _uploadedFileName != null
                  ? const Color(0xFFE8F5E9)
                  : Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _uploadedFileName != null
                    ? const Color(0xFF5E8D5E)
                    : Colors.blue.withOpacity(0.2),
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _uploadedFileName != null
                      ? Icons.check_circle
                      : Icons.cloud_upload_outlined,
                  color: _uploadedFileName != null
                      ? const Color(0xFF5E8D5E)
                      : Colors.blue,
                  size: 30,
                ),
                const SizedBox(height: 5),
                Text(
                  _uploadedFileName != null ? 'Ready' : 'Upload\nPDF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: _uploadedFileName != null
                        ? const Color(0xFF5E8D5E)
                        : Colors.blue,
                    fontWeight: FontWeight.bold,
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
