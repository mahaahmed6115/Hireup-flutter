import 'package:flutter/material.dart';

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
            expandedHeight: 180,
            pinned: true,
            elevation: 0,
            backgroundColor: darkGreen,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Sent Proposals",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
                    size: 80,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Active Proposals",
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "3 Total",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // عرض للبروبوزال الأول (فخم وتفصيلي)
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

                const SizedBox(height: 30),

                // الزرار الـ Gradient الفخم
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
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الجزء العلوي (العنوان والحالة)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF1A1D3D),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isUrgent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Urgent",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  client,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ],
            ),
          ),

          // نبذة عن المحتوى
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 15),
          const Divider(height: 1),

          // الجزء السفلي (السعر والوقت)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProposalInfo(Icons.payments_outlined, budget),
                _buildProposalInfo(Icons.timer_outlined, duration),
                const Text(
                  "View Details",
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
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

  Widget _buildProposalInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton(String text, Color dark, Color light) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(colors: [dark, light]),
        boxShadow: [
          BoxShadow(
            color: light.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
