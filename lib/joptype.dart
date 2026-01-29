import 'package:flutter/material.dart';
import 'package:hireup/jop_preference.dart';

class Joptype extends StatefulWidget {
  const Joptype({super.key});

  @override
  State<Joptype> createState() => _JoptypeState();
}

class _JoptypeState extends State<Joptype> {
  // قائمة لتخزين أنواع التوظيف المختارة
  final List<String> _selectedTypes = [];

  // البيانات الخاصة بالشاشة الجديدة (Employment Types)
  final List<Map<String, dynamic>> _jobTypes = [
    {'name': 'Full-Time', 'icon': Icons.access_time},
    {'name': 'Part-Time', 'icon': Icons.more_time},
    {'name': 'Contract', 'icon': Icons.description_outlined},
    {'name': 'Internship', 'icon': Icons.card_membership_outlined},
    {'name': 'Freelance', 'icon': Icons.person_search_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    // الزرار هينور لما نختار اختيار واحد على الأقل
    bool isButtonActive = _selectedTypes.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'HireUp',
          style: TextStyle(
            color: Color(0xFF5E8D5E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // تغيير صياغة السؤال عشان الاختلاف عن الشاشة السابقة
            const Text(
              'Select your preferred\nemployment type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1D3D),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _jobTypes.length,
                itemBuilder: (context, index) {
                  String typeName = _jobTypes[index]['name'];
                  bool isSelected = _selectedTypes.contains(typeName);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTypes.remove(typeName);
                        } else {
                          _selectedTypes.add(typeName);
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
                              ? const Color(0xFF5E8D5E)
                              : Colors.grey.shade100,
                          width: 1.5,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.green.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _jobTypes[index]['icon'],
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 15),
                          Text(
                            typeName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          // شكل الـ Checkmark الدائري
                          Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? const Color(0xFF5E8D5E)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF5E8D5E)
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
            // الزرار (Next) مع تغيير الحالة بناءً على الاختيار
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
                              builder: (context) => const JobPreferences(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonActive
                        ? const Color(0xFF5E8D5E)
                        : Colors.grey[300],
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
