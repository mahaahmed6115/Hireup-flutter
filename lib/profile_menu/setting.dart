import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool faceId = true;
  bool twoFactorAuth = false;
  bool darkMode = false;

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
          // --- الهيدر الفخم بالأشكال الهندسية (دوائر ومربعات) ---
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
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              background: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [darkGreen, primaryGreen],
                  ),
                ),
                child: Stack(
                  children: [
                    // --- الدوائر والمربعات التجريدية ---
                    Positioned(
                      top: -15,
                      right: -20,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white.withOpacity(0.07),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 30,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 60,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withOpacity(0.05),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 100,
                      child: Transform.rotate(
                        angle: 0.8,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(Icons.tune, size: 75, color: Colors.white12),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // --- Account Section ---
                _buildSectionHeader("Account Details"),
                _buildSettingsGroup([
                  _buildSettingTile(
                    Icons.person_outline,
                    "Personal Information",
                    null,
                  ),
                  _buildDivider(),
                  _buildSettingTile(
                    Icons.mail_outline,
                    "Email Management",
                    null,
                  ),
                  _buildDivider(),
                  _buildSettingTile(
                    Icons.language_outlined,
                    "App Language",
                    "Arabic (EG)",
                  ),
                ]),

                const SizedBox(height: 25),

                // --- Privacy & Security ---
                _buildSectionHeader("Security & Privacy"),
                _buildSettingsGroup([
                  _buildSettingTile(
                    Icons.lock_reset_outlined,
                    "Change Password",
                    null,
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    Icons.security_outlined,
                    "Two-Factor Auth",
                    twoFactorAuth,
                    (val) {
                      setState(() => twoFactorAuth = val);
                    },
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    Icons.fingerprint_outlined,
                    "Biometric Login",
                    faceId,
                    (val) {
                      setState(() => faceId = val);
                    },
                  ),
                ]),

                const SizedBox(height: 25),

                // --- Notifications ---
                _buildSectionHeader("Notifications"),
                _buildSettingsGroup([
                  _buildSwitchTile(
                    Icons.notifications_none_outlined,
                    "Push Notifications",
                    pushNotifications,
                    (val) {
                      setState(() => pushNotifications = val);
                    },
                  ),
                  _buildDivider(),
                  _buildSettingTile(
                    Icons.volume_up_outlined,
                    "Sound & Vibration",
                    "Default",
                  ),
                ]),

                const SizedBox(height: 25),

                // --- Support & Legal ---
                _buildSectionHeader("Support & Help"),
                _buildSettingsGroup([
                  _buildSettingTile(Icons.help_outline, "Help Center", null),
                  _buildDivider(),
                  _buildSettingTile(
                    Icons.chat_bubble_outline,
                    "Contact Us",
                    null,
                  ),
                  _buildDivider(),
                  _buildSettingTile(
                    Icons.info_outline,
                    "Terms & Conditions",
                    null,
                  ),
                ]),

                const SizedBox(height: 40),

                // --- زرار حذف الحساب الفخم (بدل اللوج أوت) ---
                _buildDeleteAccountButton(),

                const SizedBox(height: 15),
                Center(
                  child: Text(
                    "Version 1.0.4",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A1D3D),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String? trailingText) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff35CA60).withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xff35CA60), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A1D3D),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff35CA60).withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xff35CA60), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A1D3D),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        activeColor: const Color(0xff35CA60),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: Colors.red.withOpacity(0.3), width: 1.5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.delete_forever_outlined,
                color: Colors.redAccent,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                "Delete Account",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade50,
      indent: 65,
      endIndent: 20,
    );
  }
}
