import 'package:flutter/material.dart';
import 'package:hireup/Homepage.dart';

class JobPreferences extends StatefulWidget {
  const JobPreferences({super.key});

  @override
  State<JobPreferences> createState() => _JobPreferencesState();
}

class _JobPreferencesState extends State<JobPreferences> {
  // الكل بيبدأ رمادي (فاضي) زي ما اتفقنا
  final List<String> _selectedRoles = [];
  String? _selectedLocation;
  String? _selectedJobType;
  String? _selectedOffice;

  // شرط تفعيل الزرار: اختيار واحد على الأقل من كل قسم
  bool _canSave() {
    return _selectedRoles.isNotEmpty &&
        _selectedLocation != null &&
        _selectedJobType != null &&
        _selectedOffice != null;
  }

  @override
  Widget build(BuildContext context) {
    bool isReady = _canSave();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Job Preferences',
          style: TextStyle(
            color: Color(0xFF1A1D3D),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // زيادة الـ Padding لتناسب الشاشات الكبيرة
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- قسم الأدوار الوظيفية ---
            _buildHeader('Select Job Roles'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12, // مسافة أفقية
              runSpacing: 12, // مسافة رأسية
              children: [
                _buildMultiChip('Product Designer'),
                _buildMultiChip('Motion Designer'),
                _buildMultiChip('UX Designer'),
                _buildMultiChip('Graphics Designer'),
                _buildMultiChip('Full-Stack Developer'),
                _buildMultiChip('Developer'),
              ],
            ),
            const SizedBox(height: 35),

            // --- قسم الموقع ---
            _buildHeader('Select Location'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildSingleChip(
                  'Worldwide',
                  _selectedLocation,
                  (v) => setState(() => _selectedLocation = v),
                ),
                _buildSingleChip(
                  'USA',
                  _selectedLocation,
                  (v) => setState(() => _selectedLocation = v),
                ),
                _buildSingleChip(
                  'California',
                  _selectedLocation,
                  (v) => setState(() => _selectedLocation = v),
                ),
              ],
            ),
            const SizedBox(height: 35),

            // --- قسم نوع الوظيفة (تعديل مكان Contract) ---
            _buildHeader('Job Type'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12, // لضمان التنسيق لو الشاشة صغرت
              children: [
                _buildSingleChip(
                  'Full-Time',
                  _selectedJobType,
                  (v) => setState(() => _selectedJobType = v),
                ),
                _buildSingleChip(
                  'Part-Time',
                  _selectedJobType,
                  (v) => setState(() => _selectedJobType = v),
                ),
                _buildSingleChip(
                  'Contract',
                  _selectedJobType,
                  (v) => setState(() => _selectedJobType = v),
                ), // بقت جمبهم
              ],
            ),
            const SizedBox(height: 35),

            // --- قسم المكتب ---
            _buildHeader('Office'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildSingleChip(
                  'On-Site',
                  _selectedOffice,
                  (v) => setState(() => _selectedOffice = v),
                ),
                _buildSingleChip(
                  'Remote',
                  _selectedOffice,
                  (v) => setState(() => _selectedOffice = v),
                ),
                _buildSingleChip(
                  'Hybrid',
                  _selectedOffice,
                  (v) => setState(() => _selectedOffice = v),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // --- زرار السيف ---
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: isReady
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isReady
                      ? const Color(0xFF5E8D5E)
                      : Colors.grey[300],
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: isReady ? Colors.white : Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ويدجت الـ Chip للمتعدد
  Widget _buildMultiChip(String label) {
    bool isSelected = _selectedRoles.contains(label);
    return ChoiceChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(label),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selected ? _selectedRoles.add(label) : _selectedRoles.remove(label);
        });
      },
      selectedColor: const Color(0xFF5E8D5E),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[600],
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? const Color(0xFF5E8D5E) : Colors.grey.shade300,
        ),
      ),
      showCheckmark: false,
    );
  }

  // ويدجت الـ Chip للواحد
  Widget _buildSingleChip(
    String label,
    String? currentVal,
    Function(String) onSelected,
  ) {
    bool isSelected = currentVal == label;
    return ChoiceChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(label),
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) onSelected(label);
      },
      selectedColor: const Color(0xFF5E8D5E),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[600],
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? const Color(0xFF5E8D5E) : Colors.grey.shade300,
        ),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildHeader(String title) {
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
        const Text(
          'See all',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
