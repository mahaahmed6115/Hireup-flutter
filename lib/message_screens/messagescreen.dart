import 'package:flutter/material.dart';
import 'package:hireup/message_screens/archive.dart'; // تأكدي من المسار
import 'package:hireup/message_screens/interview.dart'; // تأكدي من المسار
import 'package:hireup/message_screens/unread.dart'; // تأكدي من المسار

// القوائم العامة لضمان الربط الفعلي
List<Map<String, dynamic>> companyMessages = [
  {
    'name': 'Google',
    'sub': 'Are you available for an intervi...',
    'time': '11:45 am',
    'unread': 4,
    'isCompany': true,
    'img': 'assets/images/search.png',
  },
  {
    'name': 'HP',
    'sub': 'We are looking forward to takin...',
    'time': '10:20 am',
    'unread': 1,
    'isCompany': true,
    'img': 'assets/images/hpp.png',
  },
];

List<Map<String, dynamic>> individualMessages = [
  {
    'name': 'Erik John',
    'sub': 'We are looking for a web develo...',
    'time': '11:45 am',
    'unread': 7,
    'isCompany': false,
    'img': 'assets/images/preson1.png',
  },
  {
    'name': 'Jessica Jenith',
    'sub': 'Are you available for an interview...',
    'time': '09:12 am',
    'unread': 0,
    'isCompany': false,
    'img': 'assets/images/person2.png',
  },
];

List<Map<String, dynamic>> archiveList = []; // قائمة الأرشيف العامة

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Color(0xFF1A1D3D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildQuickFilters(context),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(), // تحسين: حركة سحب مرنة
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildHeaderSection('Companies'),
                ...companyMessages
                    .map((msg) => _buildDismissibleTile(msg, companyMessages))
                    .toList(),
                const SizedBox(height: 20),
                _buildHeaderSection('Individual Messages'),
                ...individualMessages
                    .map(
                      (msg) => _buildDismissibleTile(msg, individualMessages),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // الدالة المعدلة عشان تظهر كلمة "Swipe to Archive"
  Widget _buildDismissibleTile(Map<String, dynamic> msg, List list) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          archiveList.add(msg);
          list.remove(msg);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${msg['name']} moved to Archive"),
            behavior:
                SnackBarBehavior.floating, // تحسين: تظهر طائرة فوق الـ NavBar
            backgroundColor: const Color(0xFF1A1D3D),
          ),
        );
      },
      // هنا التحسين اللي طلبتيه: إظهار الأيقونة والكلمة تحتها
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF5E8D5E),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.archive_outlined, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text(
              "Swipe to Archive",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: _buildMessageTile(msg),
    );
  }

  Widget _buildQuickFilters(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, bottom: 10),
        children: [
          _filterChip(context, 'All', true),
          _filterChip(context, 'Unread', false),
          _filterChip(context, 'Interviews', false),
          _filterChip(context, 'Archive', false),
        ],
      ),
    );
  }

  Widget _filterChip(BuildContext context, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (label == 'Archive') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const ArchiveScreen()),
          ).then((_) => setState(() {}));
        } else if (label == 'Unread') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const UnreadMessagesScreen()),
          );
        } else if (label == 'Interviews') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const InterviewScreen()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5E8D5E) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageTile(Map<String, dynamic> msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: AssetImage(msg['img']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      msg['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A1D3D),
                      ),
                    ),
                    Text(
                      msg['time'],
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  msg['sub'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          if (msg['unread'] != null && msg['unread'] > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF5E8D5E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${msg['unread']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search conversations...',
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A1D3D),
        ),
      ),
    );
  }
}
