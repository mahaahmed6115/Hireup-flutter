import 'package:flutter/material.dart';

import 'package:hireup/profile_menu/fourthai.dart';

class InterviewSetupScreen extends StatefulWidget {
  const InterviewSetupScreen({super.key});

  @override
  State<InterviewSetupScreen> createState() => _InterviewSetupScreenState();
}

class _InterviewSetupScreenState extends State<InterviewSetupScreen>
    with SingleTickerProviderStateMixin {
  String selectedType = "HR"; // نوع الانترفيو الافتراضي
  String selectedLevel = "Junior"; // المستوى الافتراضي
  String selectedTopic = "General"; // الموضوع الافتراضي

  final List<Map<String, dynamic>> types = [
    {
      "name": "HR",
      "icon": Icons.person,
      "desc": "Focus on soft skills & communication.",
      "tip": "Prepare examples from past experiences",
      "duration": "5–10 min",
    },
    {
      "name": "Technical",
      "icon": Icons.code,
      "desc": "Focus on coding & problem-solving.",
      "tip": "Review common algorithms & data structures",
      "duration": "15–25 min",
    },
    {
      "name": "Behavioral",
      "icon": Icons.mic,
      "desc": "Focus on teamwork & past experiences.",
      "tip": "Practice STAR method for answers",
      "duration": "10–15 min",
    },
  ];

  final List<String> levels = ["Junior", "Mid", "Senior"];
  final List<String> topics = [
    "General",
    "Coding",
    "Algorithms",
    "Teamwork",
    "Databases",
  ];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> get currentType =>
      types.firstWhere((t) => t["name"] == selectedType);

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Setup Your Interview",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ===== SECTION: Select Interview Type =====
            const Text(
              "Select Interview Type",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Options with icons, description, tip, and duration
            Column(
              children: types.map((type) {
                bool isSelected = selectedType == type["name"];
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedType = type["name"]);
                    _controller.forward(from: 0);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xff35CA60), Color(0xffA3F5AA)],
                            )
                          : null,
                      color: isSelected ? null : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? primaryGreen
                            : Colors.white.withOpacity(0.2),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: primaryGreen.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          type["icon"],
                          color: isSelected ? darkBlue : Colors.white70,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type["name"],
                                style: TextStyle(
                                  color: isSelected ? darkBlue : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 4),
                                Text(
                                  type["desc"],
                                  style: TextStyle(
                                    color: darkBlue.withOpacity(0.9),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Tip: ${type["tip"]}",
                                  style: TextStyle(
                                    color: darkBlue.withOpacity(0.7),
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Duration: ${type["duration"]}",
                                  style: TextStyle(
                                    color: darkBlue.withOpacity(0.7),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // ===== SECTION: Select Experience Level =====
            const Text(
              "Select Experience Level",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: levels.map((level) {
                bool isSelected = selectedLevel == level;
                return GestureDetector(
                  onTap: () => setState(() => selectedLevel = level),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryGreen
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? primaryGreen
                            : Colors.white.withOpacity(0.2),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: primaryGreen.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      level,
                      style: TextStyle(
                        color: isSelected ? darkBlue : Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // ===== SECTION: Select Topic / Category =====
            const Text(
              "Select Topic",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: topics.map((topic) {
                bool isSelected = selectedTopic == topic;
                return GestureDetector(
                  onTap: () => setState(() => selectedTopic = topic),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryGreen
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? primaryGreen
                            : Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      topic,
                      style: TextStyle(
                        color: isSelected ? darkBlue : Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // ===== START INTERVIEW BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: primaryGreen.withOpacity(0.5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AIInterviewScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Start Interview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
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
