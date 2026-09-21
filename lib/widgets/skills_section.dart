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

  final List<Map<String, dynamic>> _skillCategories = [
    {
      'title': 'Prompt Engineering',
      'icon': Icons.auto_awesome,
      'color': Color(0xFF0B3D91),
      'skills': [
        'Prompt Design',
        'Prompt Optimization',
        'Zero-shot Prompting',
        'Few-shot Prompting',
        'Prompt Refinement',
        'Structured Outputs (JSON)',
        'Context Management',
      ],
    },
    {
      'title': 'Generative AI',
      'icon': Icons.psychology,
      'color': Color(0xFF1565C0),
      'skills': [
        'LLM Fundamentals',
        'Generative AI Concepts',
        'AI Response Evaluation',
        'Hallucination Awareness',
        'Responsible AI',
      ],
    },
    {
      'title': 'AI Tools & Productivity',
      'icon': Icons.smart_toy,
      'color': Color(0xFFF5C518),
      'skills': [
        'ChatGPT',
        'Claude',
        'Cursor AI',
        'Gemini',
        'AI-Assisted Code Generation',
        'Prompt-Based Debugging',
      ],
    },
    {
      'title': 'Programming & APIs',
      'icon': Icons.code,
      'color': Color(0xFF4CAF50),
      'skills': [
        'Python (Basic)',
        'JavaScript',
        'Java',
        'Dart',
        'REST APIs',
        'JSON',
        'HTTP/HTTPS',
        'Postman',
        'Dio',
      ],
    },
    {
      'title': 'Development & Testing',
      'icon': Icons.bug_report,
      'color': Color(0xFF9C27B0),
      'skills': [
        'Flutter',
        'React',
        'Manual Testing',
        'Functional Testing',
        'Regression Testing',
        'API Testing',
        'Bug Reporting',
        'Root-Cause Analysis',
      ],
    },
    {
      'title': 'Tools & Methodologies',
      'icon': Icons.build_circle,
      'color': Color(0xFF00897B),
      'skills': [
        'Git',
        'GitHub',
        'VS Code',
        'Zoho Projects',
        'SDLC',
        'STLC',
        'Agile/Scrum',
        'Clean Architecture',
      ],
    },
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
                      const SizedBox(height: 50),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isDesktop = constraints.maxWidth > 768;
                          if (isDesktop) {
                            return AnimationLimiter(
                              child: Column(
                                children: [
                                  for (int row = 0;
                                      row < (_skillCategories.length / 2).ceil();
                                      row++)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: row <
                                                (_skillCategories.length / 2)
                                                        .ceil() -
                                                    1
                                            ? 24
                                            : 0,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int col = 0; col < 2; col++)
                                            if (row * 2 + col <
                                                _skillCategories.length)
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: col == 0 ? 12 : 0,
                                                    left: col == 1 ? 12 : 0,
                                                  ),
                                                  child: AnimationConfiguration
                                                      .staggeredList(
                                                    position: row * 2 + col,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    child: SlideAnimation(
                                                      verticalOffset: 40,
                                                      child: FadeInAnimation(
                                                        child: _buildCategoryCard(
                                                          _skillCategories[
                                                              row * 2 + col],
                                                          prioritize:
                                                              row * 2 + col < 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }

                          return AnimationLimiter(
                            child: Column(
                              children: _skillCategories
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return AnimationConfiguration.staggeredList(
                                  position: entry.key,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 40,
                                    child: FadeInAnimation(
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: _buildCategoryCard(
                                          entry.value,
                                          prioritize: entry.key < 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
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

  Widget _buildCategoryCard(Map<String, dynamic> category,
      {bool prioritize = false}) {
    final Color color = category['color'] as Color;
    final List<String> skills = List<String>.from(category['skills'] as List);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: prioritize ? color.withOpacity(0.35) : color.withOpacity(0.15),
          width: prioritize ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(prioritize ? 0.14 : 0.08),
            blurRadius: prioritize ? 16 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B3D91),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: color.withOpacity(0.18),
                  ),
                ),
                child: Text(
                  skill,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
