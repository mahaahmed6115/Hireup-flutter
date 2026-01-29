import 'package:flutter/material.dart';
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
    const Color primaryGreen = Color(0xFF5E8D5E);
    const Color textBodyColor = Color(0xFF4A4A4A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              // زودنا الارتفاع هنا من 380 لـ 410 عشان المسافات
              Container(
                height: 410,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          IconButton(
                            icon: Icon(
                              isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_add_outlined,
                              color: isSaved ? Colors.yellow : Colors.white,
                              size: 28,
                            ),
                            onPressed: _handleSave,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.job['logo'] ?? Icons.facebook,
                        size: 50,
                        color: const Color(0xFF1877F2),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.job['role'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.job['company'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTopTag('Design'),
                        _buildTopTag('Full-Time'),
                        _buildTopTag('Senior'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildHeaderInfo(widget.job['salary'], 'Salary'),
                        _buildHeaderInfo(widget.job['location'], 'Location'),
                      ],
                    ),
                    // مسافة إضافية بسيطة للتأكيد إن مفيش حاجة لازقة
                    const SizedBox(height: 10),
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
                  const TabBar(
                    labelColor: Color(0xFF1A1D3D),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryGreen,
                    indicatorWeight: 4,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(text: 'Description'),
                      Tab(text: 'Requirement'),
                      Tab(text: 'About'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildDescriptionTab(textBodyColor),
                        _buildRequirementTab(textBodyColor),
                        _buildAboutTab(textBodyColor),
                        _buildReviewsTab(textBodyColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
            child: SizedBox(
              width: double.infinity,
              height: 60,
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
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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

  Widget _buildDescriptionTab(Color textColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Job Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1A1D3D),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'We are the teams who create all of Facebook\'s products used by billions of people around the world. Want to build new features?',
            style: TextStyle(color: textColor, height: 1.5, fontSize: 15),
          ),
          const SizedBox(height: 20),
          const Text(
            'Responsibilities:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF1A1D3D),
            ),
          ),
          const SizedBox(height: 10),
          _buildBulletPoint(
            'Full stack web/mobile application development.',
            textColor,
          ),
          _buildBulletPoint(
            'Create consumer products and features using Hack.',
            textColor,
          ),
          _buildBulletPoint(
            'Implement interfaces using XHTML, CSS, and JS.',
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementTab(Color textColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Qualifications',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1A1D3D),
            ),
          ),
          const SizedBox(height: 15),
          _buildBulletPoint(
            'Bachelor\'s degree in Computer Science or equivalent.',
            textColor,
          ),
          _buildBulletPoint(
            '3+ years of experience with Software Engineer roles.',
            textColor,
          ),
          _buildBulletPoint(
            'Strong understanding of Software Design Patterns.',
            textColor,
          ),
          _buildBulletPoint(
            'Proficiency in Dart, Flutter, or related frameworks.',
            textColor,
          ),
          _buildBulletPoint(
            'Experience with Git and CI/CD pipelines.',
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(Color textColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.job['company']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1A1D3D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Our company is a global leader in tech innovation, providing a creative environment where everyone can grow.',
            style: TextStyle(color: textColor, height: 1.6, fontSize: 15),
          ),
          const SizedBox(height: 15),
          const Text(
            'Work Culture',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF1A1D3D),
            ),
          ),
          Text(
            '• Flexible Working Hours\n• Remote-First Culture\n• Weekly Learning Sessions',
            style: TextStyle(color: textColor, height: 1.8, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(Color textColor) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildReviewItem(
          'Ahmed Ali',
          'Software Architect',
          'Great company culture! 5/5',
          '5.0',
          textColor,
        ),
        _buildReviewItem(
          'Sarah J.',
          'Product Designer',
          'Very professional process.',
          '4.8',
          textColor,
        ),
      ],
    );
  }

  Widget _buildReviewItem(
    String name,
    String pos,
    String comment,
    String rate,
    Color textColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1D3D),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  Text(' $rate'),
                ],
              ),
            ],
          ),
          Text(pos, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Text(comment, style: TextStyle(fontSize: 14, color: textColor)),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF5E8D5E), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTag(String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
      ],
    );
  }
}
