import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProposalsScreen extends StatelessWidget {
  const ProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);
    const Color scaffoldBg = Color(0xFFF8FAFC);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: CustomScrollView(
        slivers: [
          // الهيدر الفخم بالتدرج المعتاد
          SliverAppBar(
            expandedHeight: 180.h,
            pinned: true,
            elevation: 0,
            backgroundColor: darkGreen,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Sent Proposals",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [darkGreen, primaryGreen],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.description_outlined,
                    size: 80.sp,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.all(20.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Active Proposals",
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "3 Total",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                _buildProposalCard(
                  title: "Mobile App Redesign Project",
                  client: "Tech Solutions Inc.",
                  budget: "\$1,200",
                  duration: "3 Weeks",
                  description:
                  "I will provide a modern UI/UX design using Flutter with full responsive layouts...",
                  isUrgent: true,
                ),
                _buildProposalCard(
                  title: "Dashboard UI Kit",
                  client: "Creative Agency",
                  budget: "\$800",
                  duration: "10 Days",
                  description:
                  "Creating a clean and minimal dashboard for a medical management system...",
                  isUrgent: false,
                ),
                _buildProposalCard(
                  title: "E-commerce App Design",
                  client: "Retail Global",
                  budget: "\$2,500",
                  duration: "1 Month",
                  description:
                  "Complete design system from user flow to high-fidelity prototypes...",
                  isUrgent: false,
                ),

                SizedBox(height: 30.h),

                _buildGradientButton(
                  "Create New Proposal",
                  darkGreen,
                  primaryGreen,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProposalCard({
    required String title,
    required String client,
    required String budget,
    required String duration,
    required String description,
    required bool isUrgent,
  }) {
    const Color primaryGreen = Color(0xff35CA60);

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Color(0xFF1A1D3D),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isUrgent)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "Urgent",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  client,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13.sp,
                height: 1.4.h,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Divider(height: 1.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22.r),
                bottomRight: Radius.circular(22.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProposalInfo(Icons.payments_outlined, budget),
                _buildProposalInfo(Icons.timer_outlined, duration),
                Text(
                  "View Details",
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProposalInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey.shade600),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton(String text, Color dark, Color light) {
    return Container(
      width: double.infinity,
      height: 58.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        gradient: LinearGradient(colors: [dark, light]),
        boxShadow: [
          BoxShadow(
            color: light.withOpacity(0.3),
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
