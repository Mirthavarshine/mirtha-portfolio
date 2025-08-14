import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/contact_service.dart';
import 'dart:async';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _backToTopController;
  late Animation<double> _backToTopAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isSubmitting = false;
  bool _isFormValid = false;
  bool _showBackToTop = false;
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  // Social link hover states
  bool _isLinkedInHovered = false;
  bool _isEmailHovered = false;
  bool _isPhoneHovered = false;
  bool _isGitHubHovered = false;
  bool _isTwitterHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _backToTopController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _backToTopAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backToTopController, curve: Curves.easeInOut),
    );
    
    _animationController.forward();

    // Listen to form changes for validation
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _messageController.addListener(_validateForm);

    // Start timer for live time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _backToTopController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _validateForm() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final isNameValid = name.length >= 3;
    final isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    final isMessageValid = message.length >= 10;

    setState(() {
      _isFormValid = isNameValid && isEmailValid && isMessageValid;
    });
  }

  Future<void> _launchUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open: $url'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _scrollToTop() {
    _backToTopController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _backToTopController.reverse();
      });
    });
    
    // Scroll to top
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final success = await ContactService.sendMessage(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('✅ Thank you! Your message has been sent.'),
                ],
              ),
              backgroundColor: Color(0xFF4CAF50),
              duration: Duration(seconds: 4),
            ),
          );
          _formKey.currentState!.reset();
          setState(() {
            _isFormValid = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Text('❌ Failed to send message. Please try again.'),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
          color: const Color(0xFF0B3D91),
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
                            'Get In Touch',
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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
                          
                          // Contact Content
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 768) {
                                // Desktop - Side by side
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Contact Form
                                    Expanded(
                                      flex: 1,
                                      child: AnimationConfiguration.staggeredList(
                                        position: 0,
                                        duration: const Duration(milliseconds: 600),
                                        child: SlideAnimation(
                                          horizontalOffset: -50.0,
                                          child: FadeInAnimation(
                                            child: _buildContactForm(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    const SizedBox(width: 60),
                                    
                                    // Social Links
                                    Expanded(
                                      flex: 1,
                                      child: AnimationConfiguration.staggeredList(
                                        position: 1,
                                        duration: const Duration(milliseconds: 600),
                                        child: SlideAnimation(
                                          horizontalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: _buildSocialLinks(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                // Mobile - Stacked
                                return Column(
                                  children: [
                                    AnimationConfiguration.staggeredList(
                                      position: 0,
                                      duration: const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: _buildContactForm(),
                                        ),
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 40),
                                    
                                    AnimationConfiguration.staggeredList(
                                      position: 1,
                                      duration: const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: _buildSocialLinks(),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // Footer
                          Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                // Live Time and Date
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5C518).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: const Color(0xFFF5C518),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Coimbatore, Tamil Nadu',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFF5C518),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${_currentTime.day}/${_currentTime.month}/${_currentTime.year}',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 30),
                                
                                // Social Media Icons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSocialIcon(
                                      icon: Icons.business,
                                      label: 'LinkedIn',
                                      url: 'https://linkedin.com/in/mirtha-varshine-r-p-5ba86628b',
                                      isHovered: _isLinkedInHovered,
                                      onHoverChanged: (hovered) {
                                        setState(() {
                                          _isLinkedInHovered = hovered;
                                        });
                                      },
                                      color: const Color(0xFF0077B5),
                                    ),
                                    const SizedBox(width: 20),
                                    _buildSocialIcon(
                                      icon: Icons.email,
                                      label: 'Email',
                                      url: 'mailto:mirthavarshine024@gmail.com',
                                      isHovered: _isEmailHovered,
                                      onHoverChanged: (hovered) {
                                        setState(() {
                                          _isEmailHovered = hovered;
                                        });
                                      },
                                      color: const Color(0xFFEA4335),
                                    ),
                                    const SizedBox(width: 20),
                                    _buildSocialIcon(
                                      icon: Icons.phone,
                                      label: 'Phone',
                                      url: 'tel:+918148085973',
                                      isHovered: _isPhoneHovered,
                                      onHoverChanged: (hovered) {
                                        setState(() {
                                          _isPhoneHovered = hovered;
                                        });
                                      },
                                      color: const Color(0xFF25D366),
                                    ),
                                    const SizedBox(width: 20),
                                    _buildSocialIcon(
                                      icon: Icons.code,
                                      label: 'GitHub',
                                      url: 'https://github.com/mirthavarshine',
                                      isHovered: _isGitHubHovered,
                                      onHoverChanged: (hovered) {
                                        setState(() {
                                          _isGitHubHovered = hovered;
                                        });
                                      },
                                      color: const Color(0xFF333333),
                                    ),
                                    const SizedBox(width: 20),
                                    _buildSocialIcon(
                                      icon: Icons.flutter_dash,
                                      label: 'Twitter',
                                      url: 'https://twitter.com/mirthavarshine',
                                      isHovered: _isTwitterHovered,
                                      onHoverChanged: (hovered) {
                                        setState(() {
                                          _isTwitterHovered = hovered;
                                        });
                                      },
                                      color: const Color(0xFF1DA1F2),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 30),
                                
                                // Copyright
                                Text(
                                  '© 2024 Mirthavarshine RP. All rights reserved.',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
        ),
        
        // Back to Top Button
        Positioned(
          bottom: 30,
          right: 30,
          child: AnimatedBuilder(
            animation: _backToTopAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _backToTopAnimation.value,
                child: FloatingActionButton(
                  onPressed: _scrollToTop,
                  backgroundColor: const Color(0xFFF5C518),
                  foregroundColor: const Color(0xFF0B3D91),
                  elevation: 8,
                  child: const Icon(Icons.keyboard_arrow_up, size: 28),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Message',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B3D91),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'I\'d love to hear from you!',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF2B2B2B).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            
            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name *',
                hintText: 'Enter your full name',
                prefixIcon: const Icon(Icons.person, color: Color(0xFFF5C518)),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0B3D91), width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                if (value.trim().length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email *',
                hintText: 'Enter your email address',
                prefixIcon: const Icon(Icons.email, color: Color(0xFFF5C518)),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0B3D91), width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            // Message Field
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Message *',
                hintText: 'Tell me about your project or inquiry...',
                alignLabelWithHint: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Icon(Icons.message, color: Color(0xFFF5C518)),
                ),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0B3D91), width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Message is required';
                }
                if (value.trim().length < 10) {
                  return 'Message must be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: _isSubmitting || !_isFormValid ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid 
                        ? const Color(0xFFF5C518) 
                        : Colors.grey.withOpacity(0.3),
                    foregroundColor: _isFormValid 
                        ? const Color(0xFF0B3D91) 
                        : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: _isFormValid ? 4 : 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B3D91)),
                          ),
                        )
                      : Text(
                          'Send Message',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Me',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Let\'s connect and explore opportunities together! Feel free to reach out through any of these platforms.',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.9),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        
        // Contact Details
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Information',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildContactDetail(
                Icons.email,
                'mirthavarshine024@gmail.com',
                () => _launchUrl('mailto:mirthavarshine024@gmail.com'),
              ),
              const SizedBox(height: 12),
              _buildContactDetail(
                Icons.phone,
                '+91 8148085973',
                () => _launchUrl('tel:+918148085973'),
              ),
              const SizedBox(height: 12),
              _buildContactDetail(
                Icons.location_on,
                'Coimbatore, Tamil Nadu, India',
                null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String label,
    required String url,
    required bool isHovered,
    required Function(bool) onHoverChanged,
    required Color color,
  }) {
    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
        child: InkWell(
          onTap: () => _launchUrl(url),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isHovered ? const Color(0xFFF5C518) : color,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: (isHovered ? const Color(0xFFF5C518) : color).withOpacity(0.3),
                  blurRadius: isHovered ? 15 : 10,
                  offset: Offset(0, isHovered ? 6 : 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isHovered ? const Color(0xFF0B3D91) : Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactDetail(IconData icon, String text, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFF5C518),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.6),
                size: 14,
              ),
          ],
        ),
      ),
    );
  }
} 