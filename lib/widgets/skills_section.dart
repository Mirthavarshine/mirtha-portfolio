import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _skills = [
    {'name': 'Dart', 'icon': Icons.code, 'color': Color(0xFF00D4AA)},
    {'name': 'Java', 'icon': Icons.coffee, 'color': Color(0xFFED8B00)},
    {'name': 'JavaScript', 'icon': Icons.javascript, 'color': Color(0xFFF7DF1E)},
    {'name': 'HTML', 'icon': Icons.html, 'color': Color(0xFFE34F26)},
    {'name': 'CSS', 'icon': Icons.css, 'color': Color(0xFF1572B6)},
    {'name': 'Flutter', 'icon': Icons.flutter_dash, 'color': Color(0xFF02569B)},
    {'name': 'Firebase', 'icon': Icons.local_fire_department, 'color': Color(0xFFFFCA28)},
    {'name': 'React', 'icon': Icons.web, 'color': Color(0xFF61DAFB)},
    {'name': 'GitHub', 'icon': Icons.code, 'color': Color(0xFF181717)},
    {'name': 'Blender', 'icon': Icons.view_in_ar, 'color': Color(0xFFF5792A)},
    {'name': 'VS Code', 'icon': Icons.code, 'color': Color(0xFF007ACC)},
    {'name': 'Slack', 'icon': Icons.chat, 'color': Color(0xFF4A154B)},
    {'name': 'Zoho', 'icon': Icons.business, 'color': Color(0xFFE4257D)},
    {'name': 'QA Testing', 'icon': Icons.bug_report, 'color': Color(0xFF4CAF50)},
    {'name': 'Manual Testing', 'icon': Icons.handyman, 'color': Color(0xFF2196F3)},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - _fadeAnimation.value)),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Column(
                    children: [
                      // Section Title
                      Text(
                        'Skills & Technologies',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B3D91),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 80,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5C518),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 60),
                      
                      // Skills Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 768) {
                            // Desktop - Horizontal scrolling
                            return Container(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _skills.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 600),
                                    child: SlideAnimation(
                                      horizontalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 12),
                                          child: _buildSkillCard(_skills[index]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            // Mobile - Grid layout
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: _skills.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  columnCount: 3,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: _buildSkillCard(_skills[index]),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B3D91).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: skill['color'].withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Show skill details or tooltip
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${skill['name']} - Clicked!'),
                backgroundColor: skill['color'],
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: skill['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    skill['icon'],
                    color: skill['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  skill['name'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2B2B2B),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 