import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _imageHoverController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _imageHoverAnimation;
  bool _isImageHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _imageHoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _imageHoverAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageHoverController, curve: Curves.easeInOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _imageHoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFFF8F9FA),
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 768) {
                        // Desktop Layout
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Profile Image
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Center(
                                      child: MouseRegion(
                                        onEnter: (_) {
                                          setState(() {
                                            _isImageHovered = true;
                                          });
                                          _imageHoverController.forward();
                                        },
                                        onExit: (_) {
                                          setState(() {
                                            _isImageHovered = false;
                                          });
                                          _imageHoverController.reverse();
                                        },
                                        child: AnimatedBuilder(
                                          animation: _imageHoverAnimation,
                                          builder: (context, child) {
                                            return Transform.scale(
                                              scale: 1.0 + (_imageHoverAnimation.value * 0.05),
                                              child: Transform.rotate(
                                                angle: _imageHoverAnimation.value * 0.02,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(0xFF0B3D91).withOpacity(0.2 + (_imageHoverAnimation.value * 0.1)),
                                                        blurRadius: 20 + (_imageHoverAnimation.value * 10),
                                                        offset: Offset(0, 10 + (_imageHoverAnimation.value * 5)),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: const Color(0xFF8B4513).withOpacity(0.3 + (_imageHoverAnimation.value * 0.2)),
                                                          width: 3 + (_imageHoverAnimation.value * 2),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(0xFF8B4513).withOpacity(0.2 + (_imageHoverAnimation.value * 0.3)),
                                                            blurRadius: 15 + (_imageHoverAnimation.value * 10),
                                                            spreadRadius: 1 + (_imageHoverAnimation.value * 2),
                                                            offset: Offset(0, 6 + (_imageHoverAnimation.value * 4)),
                                                          ),
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 175,
                                                        backgroundColor: const Color(0xFF0B3D91),
                                                        backgroundImage: const AssetImage('assets/mirtha_photo.jpg'),
                                                        onBackgroundImageError: (exception, stackTrace) {
                                                          // Handle error silently
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Content
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(40),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'About Me',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 36,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF0B3D91),
                                          ),
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
                                        const SizedBox(height: 30),
                                        Text(
                                          'Career Objective',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF2B2B2B),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'Passionate and detail-oriented final-year Computer Science Engineering student with internship experience in Quality Assurance Testing and UI/UX design. Currently building expertise in software development across multiple technologies and eager to contribute to innovative, user-focused software solutions. Seeking a dynamic tech environment to grow as a full-stack software developer and create impactful applications.',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF2B2B2B),
                                            height: 1.8,
                                          ),
                                        ),
                                        const SizedBox(height: 40),
                                        Row(
                                          children: [
                                            // View Resume Button
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                try {
                                                  final Uri url = Uri.parse('https://yellow-merilyn-98.tiiny.site');
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                                  } else {
                                                    await launchUrl(url, mode: LaunchMode.inAppWebView);
                                                  }
                                                } catch (e) {
                                                  if (mounted) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Error opening resume: $e'),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              icon: const Icon(Icons.visibility),
                                              label: Text(
                                                'View Resume',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFFF5C518),
                                                foregroundColor: const Color(0xFF0B3D91),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            // Download Resume Button
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                try {
                                                  final Uri url = Uri.parse('https://yellow-merilyn-98.tiiny.site');
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                                  } else {
                                                    await launchUrl(url, mode: LaunchMode.inAppWebView);
                                                  }
                                                } catch (e) {
                                                  if (mounted) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Error opening resume: $e'),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              icon: const Icon(Icons.download),
                                              label: Text(
                                                'Download Resume',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF0B3D91),
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 60),
                            
                            // Fun Fact Highlight Box
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF0B3D91), Color(0xFFF5C518)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0B3D91).withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.lightbulb,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fun Fact',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'I love debugging code almost as much as I love creating it! There\'s something satisfying about finding and fixing those elusive bugs.',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
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
                            // Profile Image
                            MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  _isImageHovered = true;
                                });
                                _imageHoverController.forward();
                              },
                              onExit: (_) {
                                setState(() {
                                  _isImageHovered = false;
                                });
                                _imageHoverController.reverse();
                              },
                              child: AnimatedBuilder(
                                animation: _imageHoverAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 1.0 + (_imageHoverAnimation.value * 0.05),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF0B3D91).withOpacity(0.2 + (_imageHoverAnimation.value * 0.1)),
                                            blurRadius: 20 + (_imageHoverAnimation.value * 10),
                                            offset: Offset(0, 10 + (_imageHoverAnimation.value * 5)),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFF8B4513).withOpacity(0.3 + (_imageHoverAnimation.value * 0.2)),
                                              width: 2 + (_imageHoverAnimation.value * 2),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF8B4513).withOpacity(0.2 + (_imageHoverAnimation.value * 0.3)),
                                                blurRadius: 10 + (_imageHoverAnimation.value * 10),
                                                spreadRadius: 1 + (_imageHoverAnimation.value * 2),
                                                offset: Offset(0, 4 + (_imageHoverAnimation.value * 4)),
                                              ),
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: 125,
                                            backgroundColor: const Color(0xFF0B3D91),
                                            backgroundImage: const AssetImage('assets/mirtha_photo.jpg'),
                                            onBackgroundImageError: (exception, stackTrace) {
                                              // Handle error silently
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // Content
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Me',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0B3D91),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: Container(
                                    width: 60,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5C518),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  'Career Objective',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2B2B2B),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Passionate and detail-oriented final-year Computer Science Engineering student with internship experience in Quality Assurance Testing and UI/UX design. Currently building expertise in software development across multiple technologies and eager to contribute to innovative, user-focused software solutions. Seeking a dynamic tech environment to grow as a full-stack software developer and create impactful applications.',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF2B2B2B),
                                    height: 1.8,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                // Mobile Resume Buttons
                                Column(
                                  children: [
                                    // View Resume Button
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        try {
                                          final Uri url = Uri.parse('https://yellow-merilyn-98.tiiny.site');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url, mode: LaunchMode.externalApplication);
                                          } else {
                                            await launchUrl(url, mode: LaunchMode.inAppWebView);
                                          }
                                        } catch (e) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Error opening resume: $e'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.visibility),
                                      label: Text(
                                        'View Resume',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFF5C518),
                                        foregroundColor: const Color(0xFF0B3D91),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Download Resume Button
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        try {
                                          final Uri url = Uri.parse('https://yellow-merilyn-98.tiiny.site');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url, mode: LaunchMode.externalApplication);
                                          } else {
                                            await launchUrl(url, mode: LaunchMode.inAppWebView);
                                          }
                                        } catch (e) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Error opening resume: $e'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.download),
                                      label: Text(
                                        'Download Resume',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF0B3D91),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // Fun Fact Highlight Box
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF0B3D91), Color(0xFFF5C518)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0B3D91).withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.lightbulb,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fun Fact',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'I love debugging code almost as much as I love creating it!',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
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