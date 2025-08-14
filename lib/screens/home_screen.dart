import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/certificates_section.dart';
import '../widgets/education_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _certificatesKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Navigation Bar
            PortfolioNavigationBar(
              onNavItemTap: (section) {
                switch (section) {
                  case 'home':
                    scrollToSection(_homeKey);
                    break;
                  case 'about':
                    scrollToSection(_aboutKey);
                    break;
                  case 'skills':
                    scrollToSection(_skillsKey);
                    break;
                  case 'projects':
                    scrollToSection(_projectsKey);
                    break;
                  case 'experience':
                    scrollToSection(_experienceKey);
                    break;
                  case 'education':
                    scrollToSection(_educationKey);
                    break;
                  case 'achievements':
                    scrollToSection(_achievementsKey);
                    break;
                  case 'certificates':
                    scrollToSection(_certificatesKey);
                    break;
                  case 'contact':
                    scrollToSection(_contactKey);
                    break;
                }
              },
            ),
            
            // Hero Section
            Container(
              key: _homeKey,
              child: HeroSection(projectsKey: _projectsKey),
            ),
            
            // About Section
            Container(
              key: _aboutKey,
              child: const AboutSection(),
            ),
            
            // Skills Section
            Container(
              key: _skillsKey,
              child: const SkillsSection(),
            ),
            
            // Projects Section
            Container(
              key: _projectsKey,
              child: const ProjectsSection(),
            ),
            
            // Experience Section
            Container(
              key: _experienceKey,
              child: const ExperienceSection(),
            ),
            
            // Certificates Section
            Container(
              key: _certificatesKey,
              child: const CertificatesSection(),
            ),
            
            // Education Section
            Container(
              key: _educationKey,
              child: const EducationSection(),
            ),
            
            // Achievements Section
            Container(
              key: _achievementsKey,
              child: const AchievementsSection(),
            ),
            
            // Contact Section
            Container(
              key: _contactKey,
              child: const ContactSection(),
            ),
          ],
        ),
      ),
    );
  }
} 