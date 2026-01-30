import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/jop_details/apply_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isSaved = false;

  void _handleSave() {
    setState(() {
      isSaved = !isSaved;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSaved ? 'Added to Saved' : 'Removed from Saved'),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1D3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const Color primaryGreen = Color(0xFF5E8D5E);
    const Color textBodyColor = Color(0xFF4A4A4A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.45, // ارتفاع ديناميكي
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: screenWidth * 0.06,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          IconButton(
                            icon: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
                              color: isSaved ? Colors.yellow : Colors.white,
                              size: screenWidth * 0.07,
                            ),
                            onPressed: _handleSave,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.job['logo'] ?? Icons.facebook,
                        size: screenWidth * 0.12,
                        color: const Color(0xFF1877F2),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      widget.job['role'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.job['company'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTopTag('Design', screenWidth),
                        _buildTopTag('Full-Time', screenWidth),
                        _buildTopTag('Senior', screenWidth),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.035),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildHeaderInfo(widget.job['salary'], 'Salary', screenWidth),
                        _buildHeaderInfo(widget.job['location'], 'Location', screenWidth),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    labelColor: const Color(0xFF1A1D3D),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryGreen,
                    indicatorWeight: 4,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                    tabs: const [
                      Tab(text: 'Description'),
                      Tab(text: 'Requirement'),
                      Tab(text: 'About'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildDescriptionTab(textBodyColor, screenWidth),
                        _buildRequirementTab(textBodyColor, screenWidth),
                        _buildAboutTab(textBodyColor, screenWidth),
                        _buildReviewsTab(textBodyColor, screenWidth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.06, screenHeight * 0.01,
                screenWidth * 0.06, screenHeight * 0.03),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplyJobScreen(job: widget.job),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Apply Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تعديل الـ widgets لتكون responsive
  Widget _buildDescriptionTab(Color textColor, double screenWidth) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Summary',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                  color: const Color(0xFF1A1D3D))),
          SizedBox(height: screenWidth * 0.02),
          Text(
            'We are the teams who create all of Facebook\'s products used by billions of people around the world. Want to build new features?',
            style: TextStyle(color: textColor, height: 1.5, fontSize: screenWidth * 0.037),
          ),
          SizedBox(height: screenWidth * 0.04),
          Text('Responsibilities:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.042,
                  color: const Color(0xFF1A1D3D))),
          SizedBox(height: screenWidth * 0.02),
          _buildBulletPoint('Full stack web/mobile application development.', textColor, screenWidth),
          _buildBulletPoint('Create consumer products and features using Hack.', textColor, screenWidth),
          _buildBulletPoint('Implement interfaces using XHTML, CSS, and JS.', textColor, screenWidth),
        ],
      ),
    );
  }

  Widget _buildRequirementTab(Color textColor, double screenWidth) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Qualifications',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                  color: const Color(0xFF1A1D3D))),
          SizedBox(height: screenWidth * 0.03),
          _buildBulletPoint('Bachelor\'s degree in Computer Science or equivalent.', textColor, screenWidth),
          _buildBulletPoint('3+ years of experience with Software Engineer roles.', textColor, screenWidth),
          _buildBulletPoint('Strong understanding of Software Design Patterns.', textColor, screenWidth),
          _buildBulletPoint('Proficiency in Dart, Flutter, or related frameworks.', textColor, screenWidth),
          _buildBulletPoint('Experience with Git and CI/CD pipelines.', textColor, screenWidth),
        ],
      ),
    );
  }

  Widget _buildAboutTab(Color textColor, double screenWidth) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About ${widget.job['company']}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                  color: const Color(0xFF1A1D3D))),
          SizedBox(height: screenWidth * 0.02),
          Text(
            'Our company is a global leader in tech innovation, providing a creative environment where everyone can grow.',
            style: TextStyle(color: textColor, height: 1.6, fontSize: screenWidth * 0.037),
          ),
          SizedBox(height: screenWidth * 0.03),
          Text('Work Culture',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.042,
                  color: const Color(0xFF1A1D3D))),
          Text(
            '• Flexible Working Hours\n• Remote-First Culture\n• Weekly Learning Sessions',
            style: TextStyle(color: textColor, height: 1.8, fontSize: screenWidth * 0.034),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(Color textColor, double screenWidth) {
    return ListView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      children: [
        _buildReviewItem('Ahmed Ali', 'Software Architect', 'Great company culture! 5/5', '5.0', textColor, screenWidth),
        _buildReviewItem('Sarah J.', 'Product Designer', 'Very professional process.', '4.8', textColor, screenWidth),
      ],
    );
  }

  Widget _buildReviewItem(String name, String pos, String comment, String rate, Color textColor, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.035),
      padding: EdgeInsets.all(screenWidth * 0.035),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1D3D),
                  fontSize: screenWidth * 0.04,
                )),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: screenWidth * 0.04),
                Text(' $rate', style: TextStyle(fontSize: screenWidth * 0.037)),
              ],
            ),
          ]),
          Text(pos, style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.033)),
          SizedBox(height: screenWidth * 0.02),
          Text(comment, style: TextStyle(fontSize: screenWidth * 0.037, color: textColor)),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color textColor, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: const Color(0xFF5E8D5E), size: screenWidth * 0.045),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: screenWidth * 0.037,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTag(String label, double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.033,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(String value, String label, double screenWidth) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: screenWidth * 0.033),
        ),
      ],
    );
  }
}
