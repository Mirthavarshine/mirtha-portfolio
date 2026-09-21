import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _experiences = [
    {
      'title': 'Software Engineer',
      'company': 'Tart Labs',
      'duration': 'September 2025 – Present · Coimbatore, Tamil Nadu',
      'description':
          'Apply prompt engineering and AI-assisted development practices to support software engineering workflows, including structured response generation, debugging, and application development.',
      'responsibilities': [
        'Apply prompt engineering fundamentals to create clear instructions and generate relevant, structured AI responses for development-related tasks.',
        'Refine prompts to improve response accuracy, clarity, and adherence to specific technical requirements.',
        'Experiment with prompting approaches to support code explanation, error analysis, code refinement, and technical problem-solving.',
        'Evaluate AI-generated outputs for relevance, correctness, and alignment with expected requirements.',
        'Design task-specific prompts with clear context and expected outputs to support software testing, debugging, and application development workflows.',
        'Apply structured prompting techniques to analyze technical requirements and generate step-by-step solutions.',
        'Work with Flutter, Dart, REST APIs, and application data flows during development and maintenance.',
        'Construct zero-shot and few-shot prompt templates to automate synthetic data generation and optimize LLM-driven test case creation.',
      ],
      'icon': Icons.psychology,
      'color': Color(0xFF0B3D91),
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
                      // Section Title
                      Text(
                        'Work Experience',
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
                      
                      // Timeline
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 768) {
                            // Desktop - Side by side timeline
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Timeline line
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: _experiences.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        Map<String, dynamic> experience = entry.value;
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(milliseconds: 600),
                                          child: SlideAnimation(
                                            verticalOffset: 50.0,
                                            child: FadeInAnimation(
                                              child: _buildTimelineItem(experience, index),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Mobile - Vertical timeline
                            return Column(
                              children: _experiences.asMap().entries.map((entry) {
                                int index = entry.key;
                                Map<String, dynamic> experience = entry.value;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: _buildTimelineItem(experience, index),
                                    ),
                                  ),
                                );
                              }).toList(),
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

  Widget _buildTimelineItem(Map<String, dynamic> experience, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot and line
          Container(
            width: 60,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: experience['color'],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: experience['color'].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    experience['icon'],
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                if (index < _experiences.length - 1)
                  Container(
                    width: 2,
                    height: 80,
                    color: const Color(0xFFF5C518),
                    margin: const EdgeInsets.only(top: 8),
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Experience content
          Expanded(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      experience['color'].withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: experience['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            experience['icon'],
                            color: experience['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                experience['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0B3D91),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                experience['company'],
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: experience['color'],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                experience['duration'],
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFF5C518),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      experience['description'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2B2B2B),
                        height: 1.6,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      'Key Responsibilities:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B3D91),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    ...(experience['responsibilities'] as List<String>).map((responsibility) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6, right: 12),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: experience['color'],
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                responsibility,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF2B2B2B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 