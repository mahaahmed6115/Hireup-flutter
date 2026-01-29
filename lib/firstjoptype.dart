import 'package:flutter/material.dart';

import 'package:hireup/joptype.dart';

class firstjoptype extends StatefulWidget {
  const firstjoptype({super.key});

  @override
  State<firstjoptype> createState() => _firstjoptypeState();
}

class _firstjoptypeState extends State<firstjoptype> {
  // قائمة لتخزين الخيارات المختارة

  final List<String> _selectedJobs = [];

  // قائمة الوظائف المتاحة

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
    // التأكد إذا كان المستخدم اختار أي شيء لتفعيل الزر

    bool isButtonActive = _selectedJobs.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        leading: const Icon(Icons.close, color: Colors.black),

        title: const Text(
          'HireUp',

          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 40),

            const Text(
              'What type of job you’re\nlooking for?',

              style: TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.bold,

                color: Color(0xFF1A1D3D),
              ),
            ),

            const SizedBox(height: 30),

            // قائمة الوظائف
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
                      margin: const EdgeInsets.only(bottom: 15),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,

                        vertical: 15,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(12),

                        border: Border.all(
                          color: isSelected
                              ? Colors.green
                              : Colors.grey.shade100,

                          width: 1,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),

                            spreadRadius: 1,

                            blurRadius: 5,
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          Icon(_jobs[index]['icon'], color: Colors.grey),

                          const SizedBox(width: 15),

                          Text(
                            jobName,

                            style: const TextStyle(
                              fontSize: 16,

                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const Spacer(),

                          // شكل الدائرة (الراديو بوتون)
                          Container(
                            height: 22,

                            width: 22,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              color: isSelected
                                  ? Colors.green
                                  : Colors.transparent,

                              border: Border.all(
                                color: isSelected
                                    ? Colors.green
                                    : Colors.grey.shade300,
                              ),
                            ),

                            child: isSelected
                                ? const Icon(
                                    Icons.check,

                                    size: 16,

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

            // الزرار (Next)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),

              child: SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed: isButtonActive
                      ? () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) => const Joptype(),
                            ),
                          );
                        }
                      : null, // null بيخلي الزرار Disabled (رمادي)

                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonActive
                        ? const Color(0xFF5E8D5E)
                        : Colors.grey.shade400,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),

                    elevation: 0,
                  ),

                  child: const Text(
                    'Next',

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 18,

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
