import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/Homepage.dart';

class JobPreferences extends StatefulWidget {
  const JobPreferences({super.key});

  @override
  State<JobPreferences> createState() => _JobPreferencesState();
}

class _JobPreferencesState extends State<JobPreferences> {
  final List<String> _selectedRoles = [];
  String? _selectedLocation;
  String? _selectedJobType;
  String? _selectedOffice;

  bool _canSave() {
    return _selectedRoles.isNotEmpty &&
        _selectedLocation != null &&
        _selectedJobType != null &&
        _selectedOffice != null;
  }

  @override
  Widget build(BuildContext context) {
    bool isReady = _canSave();

    // ScreenUtil initialization
    return ScreenUtilInit(
      designSize: const Size(375, 812), // ابعاد التصميم الأساسي (iPhone X مثلا)
      minTextAdapt: true,
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 22.w),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Job Preferences',
            style: TextStyle(
              color: const Color(0xFF1A1D3D),
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Select Job Roles', 18.sp),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildMultiChip('Product Designer', 15.sp),
                  _buildMultiChip('Motion Designer', 15.sp),
                  _buildMultiChip('UX Designer', 15.sp),
                  _buildMultiChip('Graphics Designer', 15.sp),
                  _buildMultiChip('Full-Stack Developer', 15.sp),
                  _buildMultiChip('Developer', 15.sp),
                ],
              ),
              SizedBox(height: 35.h),

              _buildHeader('Select Location', 18.sp),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSingleChip('Worldwide', _selectedLocation, (v) => setState(() => _selectedLocation = v), 15.sp),
                  _buildSingleChip('USA', _selectedLocation, (v) => setState(() => _selectedLocation = v), 15.sp),
                  _buildSingleChip('California', _selectedLocation, (v) => setState(() => _selectedLocation = v), 15.sp),
                ],
              ),
              SizedBox(height: 35.h),

              _buildHeader('Job Type', 18.sp),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSingleChip('Full-Time', _selectedJobType, (v) => setState(() => _selectedJobType = v), 15.sp),
                  _buildSingleChip('Part-Time', _selectedJobType, (v) => setState(() => _selectedJobType = v), 15.sp),
                  _buildSingleChip('Contract', _selectedJobType, (v) => setState(() => _selectedJobType = v), 15.sp),
                ],
              ),
              SizedBox(height: 35.h),

              _buildHeader('Office', 18.sp),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSingleChip('On-Site', _selectedOffice, (v) => setState(() => _selectedOffice = v), 15.sp),
                  _buildSingleChip('Remote', _selectedOffice, (v) => setState(() => _selectedOffice = v), 15.sp),
                  _buildSingleChip('Hybrid', _selectedOffice, (v) => setState(() => _selectedOffice = v), 15.sp),
                ],
              ),
              SizedBox(height: 50.h),

              SizedBox(
                width: double.infinity,
                height: 58.h,
                child: ElevatedButton(
                  onPressed: isReady
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isReady ? const Color(0xFF5E8D5E) : Colors.grey[300],
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: isReady ? Colors.white : Colors.grey[600],
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMultiChip(String label, double fontSize) {
    bool isSelected = _selectedRoles.contains(label);
    return ChoiceChip(
      label: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(label)),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selected ? _selectedRoles.add(label) : _selectedRoles.remove(label);
        });
      },
      selectedColor: const Color(0xFF5E8D5E),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey[600], fontSize: fontSize, fontWeight: FontWeight.w500),
      shape: StadiumBorder(
        side: BorderSide(color: isSelected ? const Color(0xFF5E8D5E) : Colors.grey.shade300),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildSingleChip(String label, String? currentVal, Function(String) onSelected, double fontSize) {
    bool isSelected = currentVal == label;
    return ChoiceChip(
      label: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(label)),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) onSelected(label);
      },
      selectedColor: const Color(0xFF5E8D5E),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey[600], fontSize: fontSize, fontWeight: FontWeight.w500),
      shape: StadiumBorder(
        side: BorderSide(color: isSelected ? const Color(0xFF5E8D5E) : Colors.grey.shade300),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildHeader(String title, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xFF1A1D3D))),
        Text('See all', style: TextStyle(color: Colors.grey, fontSize: fontSize * 0.77)),
      ],
    );
  }
}
