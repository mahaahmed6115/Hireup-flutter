import 'package:flutter/material.dart';
import 'package:hireup/Notifcations.dart';

import 'package:hireup/jop_details/jopdetails.dart';
import 'package:hireup/message_screens/messagescreen.dart';
import 'package:hireup/profile_menu/ProfileMenu.dart';
import 'package:hireup/saved.dart';

// القائمة العامة لضمان التزامن بين الصفحات
List<Map<String, dynamic>> savedJobs = [];

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  // دالة لتغيير حالة الحفظ فوراً مع إظهار رسالة
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 25),
            _buildSearchRow(),
            const SizedBox(height: 30),
            _buildSectionHeader('Featured Jobs'),
            const SizedBox(height: 15),
            _buildFeaturedList(),
            const SizedBox(height: 30),
            _buildSectionHeader('Popular Jobs'),
            const SizedBox(height: 15),
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
          children: const [
            Text(
              'Welcome to HireUP!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              'Discover Jobs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1D3D),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () =>
              showDialog(context: context, builder: (c) => const Profilemenu()),
          child: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/Ellipse.png'),
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
        const SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text('See all', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 180,
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
        width: 280,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(logo, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
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
                    size: 26,
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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  salary,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
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
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  Widget _buildPopularJobTile(
    String title,
    String company,
    String salary,
    String loc,
  ) {
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
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.business, color: Colors.orange),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    company,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  salary,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  loc,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
