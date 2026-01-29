import 'package:flutter/material.dart';
// تأكدي من استيراد الملف الذي يحتوي على القوائم العامة (Global Lists)
import 'package:hireup/message_screens/messagescreen.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false, // جعل العنوان من جهة اليسار لشكل أكثر عصرية
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1A1D3D),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Archive',
          style: TextStyle(
            color: Color(0xFF1A1D3D),
            fontWeight: FontWeight.bold,
            fontSize: 22, // تكبير العنوان قليلاً
          ),
        ),
      ),
      body: archiveList.isEmpty
          ? _buildEnhancedEmptyState()
          : ListView.builder(
              physics: const BouncingScrollPhysics(), // حركة سحب مرنة
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: archiveList.length,
              itemBuilder: (context, index) {
                final msg = archiveList[index];
                return _buildDismissibleArchiveTile(msg, index);
              },
            ),
    );
  }

  Widget _buildDismissibleArchiveTile(Map<String, dynamic> msg, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd, // السحب من الشمال لليمين للإعادة
      onDismissed: (direction) {
        setState(() {
          // اللوجيك الذكي للرجوع للمكان الصح بناءً على نوع الرسالة
          if (msg['isCompany'] == true) {
            companyMessages.add(msg);
          } else {
            individualMessages.add(msg);
          }
          archiveList.removeAt(index);
        });

        // تحسين: سناب بار طائر (Floating SnackBar)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${msg['name']} restored to ${msg['isCompany'] ? 'Companies' : 'Individuals'}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFF1A1D3D),
          ),
        );
      },
      // تحسين: شكل الخلفية أثناء السحب مع نص توضيحي
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF5E8D5E), // استخدام لون تطبيقك الأخضر للإعادة
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.unarchive_outlined, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text(
              "Restore",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: _buildArchiveTileLayout(msg),
    );
  }

  Widget _buildArchiveTileLayout(Map<String, dynamic> msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // زيادة الظل قليلاً للعمق
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // تحسين: إضافة حواف دائرية أنيقة للصورة
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: AssetImage(msg['img']),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.shade100), // إطار خفيف جداً
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1D3D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  msg['sub'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          // تحسين: أيقونة الأرشيف بلون هادئ
          Icon(
            Icons.inventory_2_outlined,
            color: Colors.grey.shade400,
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // تحسين: حاوية للأيقونة لجعلها تبدو كـ Illustration بسيط
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.archive_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your archive is empty',
            style: TextStyle(
              color: Color(0xFF1A1D3D),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Messages you archive will appear here.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
