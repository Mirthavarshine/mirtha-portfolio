import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({super.key});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
                        'Education',
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
                      
                      // Education Card
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.white, Color(0xFFF8F9FA)],
                            ),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 768) {
                                // Desktop Layout
                                return Row(
                                  children: [
                                    // Icon
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0B3D91).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.school,
                                        size: 48,
                                        color: Color(0xFF0B3D91),
                                      ),
                                    ),
                                    
                                    const SizedBox(width: 30),
                                    
                                    // Education Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'B.E. Computer Science and Engineering',
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF0B3D91),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Jansons Institute of Technology, Coimbatore, Tamil Nadu',
                                            style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFF5C518),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF0B3D91),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  'CGPA: 7.87/10',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF5C518).withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  'June 2022 – March 2026',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xFF0B3D91),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'Pursuing Computer Science and Engineering with a focus on Prompt Engineering, Generative AI, software development, and quality assurance.',
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF2B2B2B),
                                              height: 1.6,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                // Mobile Layout
                                return Column(
                                  children: [
                                    // Icon
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0B3D91).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.school,
                                        size: 36,
                                        color: Color(0xFF0B3D91),
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 20),
                                    
                                    // Education Details
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'B.E. Computer Science and Engineering',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0B3D91),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Jansons Institute of Technology, Coimbatore, Tamil Nadu',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFF5C518),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        Wrap(
                                          spacing: 12,
                                          runSpacing: 8,
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0B3D91),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'CGPA: 7.87/10',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF5C518).withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'June 2022 – March 2026',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF0B3D91),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'Pursuing Computer Science and Engineering with a focus on Prompt Engineering, Generative AI, software development, and quality assurance.',
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF2B2B2B),
                                            height: 1.6,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
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
} 