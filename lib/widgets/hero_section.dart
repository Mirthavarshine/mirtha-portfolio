import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../utils/resume_utils.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey? projectsKey;
  
  const HeroSection({super.key, this.projectsKey});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _imageController;
  late AnimationController _hoverController;
  late AnimationController _typingController;
  late AnimationController _particleController;
  late AnimationController _scrollIndicatorController;
  late Animation<double> _textAnimation;
  late Animation<double> _imageAnimation;
  late Animation<double> _hoverAnimation;
  late Animation<double> _typingAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _scrollIndicatorAnimation;
  bool _isHovered = false;
  
  // Typing animation variables
  String _displayText = "";
  String _fullText = "Software Engineer | Generative AI & Prompt Engineer";
  int _textIndex = 0;
  bool _isTypingComplete = false;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _scrollIndicatorController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );
    _typingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _typingController, curve: Curves.easeInOut),
    );
    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );
    _scrollIndicatorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scrollIndicatorController, curve: Curves.easeInOut),
    );
    
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _textController.forward();
    _imageController.forward();
    _typingController.forward();
    _particleController.repeat();
    _scrollIndicatorController.repeat(reverse: true);
    
    // Start typing animation
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      _typeNextCharacter();
    });
  }

  void _typeNextCharacter() {
    if (_textIndex < _fullText.length) {
      setState(() {
        _displayText = _fullText.substring(0, _textIndex + 1);
        _textIndex++;
      });
      Future.delayed(const Duration(milliseconds: 50), _typeNextCharacter);
    } else {
      setState(() {
        _isTypingComplete = true;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    _hoverController.dispose();
    _typingController.dispose();
    _particleController.dispose();
    _scrollIndicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B3D91), // Navy Blue
            Color(0xFFF5C518), // Gold
            Colors.white,
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated Background Particles
          AnimatedBuilder(
            animation: _particleAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(_particleAnimation.value),
                size: Size.infinite,
              );
            },
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 768) {
                    // Desktop Layout
                    return Row(
                      children: [
                        // Profile Image
                        Expanded(
                          flex: 1,
                          child: AnimatedBuilder(
                            animation: _imageAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, 50 * (1 - _imageAnimation.value)),
                                child: Opacity(
                                  opacity: _imageAnimation.value,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF0B3D91).withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: MouseRegion(
                                        onEnter: (_) {
                                          setState(() {
                                            _isHovered = true;
                                          });
                                          _hoverController.forward();
                                        },
                                        onExit: (_) {
                                          setState(() {
                                            _isHovered = false;
                                          });
                                          _hoverController.reverse();
                                        },
                                        child: AnimatedBuilder(
                                          animation: _hoverAnimation,
                                          builder: (context, child) {
                                            return Transform.scale(
                                              scale: 1.0 + (_hoverAnimation.value * 0.1),
                                              child: Transform.rotate(
                                                angle: _hoverAnimation.value * 0.05,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(0xFF8B4513).withOpacity(0.3 + (_hoverAnimation.value * 0.2)),
                                                      width: 4 + (_hoverAnimation.value * 2),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(0xFF8B4513).withOpacity(0.2 + (_hoverAnimation.value * 0.3)),
                                                        blurRadius: 20 + (_hoverAnimation.value * 10),
                                                        spreadRadius: 2 + (_hoverAnimation.value * 3),
                                                        offset: Offset(0, 8 + (_hoverAnimation.value * 4)),
                                                      ),
                                                    ],
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 140,
                                                    backgroundColor: const Color(0xFF0B3D91),
                                                    backgroundImage: const AssetImage('assets/mirtha_photo.jpg'),
                                                    onBackgroundImageError: (exception, stackTrace) {
                                                      // Handle error silently
                                                    },
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
                              );
                            },
                          ),
                        ),
                        
                        // Text Content
                        Expanded(
                          flex: 1,
                          child: AnimatedBuilder(
                            animation: _textAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(50 * (1 - _textAnimation.value), 0),
                                child: Opacity(
                                  opacity: _textAnimation.value,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Welcome to My Portfolio",
                                        style: GoogleFonts.poppins(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Hi, I'm Mirthavarshine",
                                        style: GoogleFonts.poppins(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(0.9),
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Typing Animation
                                      AnimatedBuilder(
                                        animation: _typingAnimation,
                                        builder: (context, child) {
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  _displayText,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              if (!_isTypingComplete)
                                                AnimatedOpacity(
                                                  opacity: _typingAnimation.value,
                                                  duration: const Duration(milliseconds: 500),
                                                  child: Container(
                                                    width: 2,
                                                    height: 24,
                                                    color: Colors.white,
                                                    margin: const EdgeInsets.only(left: 2, top: 4),
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Text(
                                          "Prompt Engineering enthusiast with experience in software development, API integration, quality assurance, and AI-assisted problem-solving.",
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      // CTA Buttons
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // Scroll to projects section
                                              if (widget.projectsKey?.currentContext != null) {
                                                Scrollable.ensureVisible(
                                                  widget.projectsKey!.currentContext!,
                                                  duration: const Duration(milliseconds: 800),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: const Color(0xFF0B3D91),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 40,
                                                vertical: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Text(
                                              "View My Projects",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              try {
                                                await ResumeUtils.openResume();
                                              } catch (e) {
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Error downloading resume: $e'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            icon: const Icon(Icons.download),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFFF5C518),
                                              foregroundColor: const Color(0xFF0B3D91),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 40,
                                                vertical: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            label: Text(
                                              "Download Resume",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Mobile Layout
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Image
                        AnimatedBuilder(
                          animation: _imageAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - _imageAnimation.value)),
                              child: Opacity(
                                opacity: _imageAnimation.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF0B3D91).withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF8B4513).withOpacity(0.3),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF8B4513).withOpacity(0.2),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 95,
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
                        
                        const SizedBox(height: 40),
                        
                        // Text Content
                        AnimatedBuilder(
                          animation: _textAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - _textAnimation.value)),
                              child: Opacity(
                                opacity: _textAnimation.value,
                                child: Column(
                                  children: [
                                    Text(
                                      "Welcome to My Portfolio",
                                      style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Hi, I'm Mirthavarshine",
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.9),
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    // Typing Animation
                                    AnimatedBuilder(
                                      animation: _typingAnimation,
                                      builder: (context, child) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                _displayText,
                                                style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            if (!_isTypingComplete)
                                              AnimatedOpacity(
                                                opacity: _typingAnimation.value,
                                                duration: const Duration(milliseconds: 500),
                                                child: Container(
                                                  width: 2,
                                                  height: 18,
                                                  color: Colors.white,
                                                  margin: const EdgeInsets.only(left: 2, top: 2),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "Prompt Engineering enthusiast with experience in software development, API integration, quality assurance, and AI-assisted problem-solving.",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    // CTA Buttons
                                    Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Scroll to projects section
                                            if (widget.projectsKey?.currentContext != null) {
                                              Scrollable.ensureVisible(
                                                widget.projectsKey!.currentContext!,
                                                duration: const Duration(milliseconds: 800),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: const Color(0xFF0B3D91),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                          child: Text(
                                            "View My Projects",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            try {
                                              await ResumeUtils.openResume();
                                            } catch (e) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Error downloading resume: $e'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          icon: const Icon(Icons.download),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFFF5C518),
                                            foregroundColor: const Color(0xFF0B3D91),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                          label: Text(
                                            "Download Resume",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          
          // Scroll Indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _scrollIndicatorAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 10 * _scrollIndicatorAnimation.value),
                    child: Column(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.8),
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Scroll to explore',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Particle Background Painter
class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent particles
    
    for (int i = 0; i < 50; i++) {
      final x = (random.nextDouble() * size.width);
      final y = (random.nextDouble() * size.height + animationValue * 100) % size.height;
      final radius = random.nextDouble() * 3 + 1;
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 