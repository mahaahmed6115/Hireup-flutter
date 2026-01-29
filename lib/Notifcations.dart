import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1A1D3D),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF1A1D3D),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('New activity'),
            const SizedBox(height: 15),
            _buildActivityTile(
              title: 'Fiverr',
              sub:
                  'want to take a final interview of you where head of HR will see you!',
              time: '12 min ago',
              img: 'assets/images/fiver.png', // مكان صورة Fiverr
              isNew: true,
            ),
            _buildActivityTile(
              title: 'Macdonald',
              sub:
                  'want to contact with you in 24 hours with proper preparation',
              time: '47 min ago',
              img: 'assets/images/mac.png', // مكان صورة Macdonald
              isNew: true,
            ),
            const SizedBox(height: 25),
            _buildSectionHeader('Applications', hasSeeAll: true),
            const SizedBox(height: 15),
            _buildApplicationTile(
              company: 'BMW',
              status: 'Your application is submitted successfully',
              time: '1 hrs ago',
              img: 'assets/images/bmw.png', // مكان صورة BMW
            ),
            _buildApplicationTile(
              company: 'Booking.com',
              status:
                  'reviewing your application, cover letter and portfolio. All the best!',
              time: '3 hrs ago',
              img: 'assets/images/booking.png', // مكان صورة Booking
            ),
            const SizedBox(height: 25),
            _buildSectionHeader('Interview', hasSeeAll: true),
            const SizedBox(height: 15),
            _buildInterviewTile(
              company: 'Beats',
              sub:
                  'Congratulations! Beats liked your resume and want to take an interview of you.',
              time: '4 hrs ago',
              img: 'assets/images/image 8.png', // مكان صورة Beats
            ),
            _buildInterviewTile(
              company: 'Behance',
              sub:
                  'Congratulations! You passed the first round on Behance. Be prepare for next!',
              time: '6 hrs ago',
              img: 'assets/images/behance.png', // مكان صورة Behance
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool hasSeeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1D3D),
          ),
        ),
        if (hasSeeAll)
          const Text(
            'See all',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
      ],
    );
  }

  Widget _buildActivityTile({
    required String title,
    required String sub,
    required String time,
    required String img,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 25, backgroundImage: AssetImage(img)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: '$title ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: sub),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (isNew) ...[
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationTile({
    required String company,
    required String status,
    required String time,
    required String img,
  }) {
    return _buildActivityTile(
      title: company,
      sub: status,
      time: time,
      img: img,
    );
  }

  Widget _buildInterviewTile({
    required String company,
    required String sub,
    required String time,
    required String img,
  }) {
    return _buildActivityTile(title: company, sub: sub, time: time, img: img);
  }
}
