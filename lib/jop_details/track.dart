import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  final Map<String, dynamic> job;

  const TrackingScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF5E8D5E); // اللون الأخضر الزيتي
    const Color darkBlue = Color(0xFF1A1D3D); // الكحلي الغامق

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: darkBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Applied Job Details',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // الكارد اللي فوق مع إضافة البوردر اللي طلبتيه
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
                // إضافة البوردر هنا
                border: Border.all(
                  color: primaryGreen.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Icon(
                      Icons.facebook,
                      size: 40,
                      color: Color(0xFF1877F2),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job['role'] ?? 'Software Intern',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: darkBlue,
                          ),
                        ),
                        const Text(
                          'facebook',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        job['salary'] ?? '\$88,000/y',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryGreen,
                        ),
                      ),
                      const Text(
                        'Los Angeles, US',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),
            const Text(
              'Track Application',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 25),

            _buildTimelineStep('Offer letter', 'Not yet', false, false, true),
            _buildTimelineStep(
              'Team matching',
              '29/06/22   02:00 pm',
              true,
              false,
              false,
            ),
            _buildTimelineStep(
              'Final HR interview',
              '21/06/22   04:00 pm',
              true,
              true,
              false,
            ),
            _buildTimelineStep(
              'Technical interview',
              '12/06/22   10:00 am',
              true,
              true,
              false,
            ),
            _buildTimelineStep(
              'Screening interview',
              '05/06/22   11:00 am',
              true,
              true,
              false,
            ),
            _buildTimelineStep(
              'Reviewed by Spotify team',
              '25/05/22   09:00 am',
              true,
              true,
              false,
            ),
            _buildTimelineStep(
              'Application submitted',
              '17/05/22   11:00 am',
              true,
              true,
              false,
              isLast: true,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    bool isActive,
    bool showCheck,
    bool isFuture, {
    bool isLast = false,
  }) {
    const Color greenTheme = Color(0xFF5E8D5E);
    Color greyTheme = Colors.grey.shade300;

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              isFuture
                  ? Icon(
                      Icons.emoji_events_outlined,
                      color: greyTheme,
                      size: 28,
                    )
                  : Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: showCheck ? greenTheme : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: greenTheme, width: 2),
                      ),
                      child: showCheck
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: greenTheme,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                    ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isFuture ? greyTheme : greenTheme,
                    ),
                    child: isFuture
                        ? Column(
                            children: List.generate(
                              5,
                              (index) => Expanded(
                                child: Container(
                                  width: 2,
                                  color: index % 2 == 0
                                      ? greyTheme
                                      : Colors.transparent,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1D3D),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isFuture ? Colors.grey.shade400 : Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
