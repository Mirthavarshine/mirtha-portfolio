import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioNavigationBar extends StatefulWidget {
  final Function(String) onNavItemTap;

  const PortfolioNavigationBar({
    super.key,
    required this.onNavItemTap,
  });

  @override
  State<PortfolioNavigationBar> createState() => _PortfolioNavigationBarState();
}

class _PortfolioNavigationBarState extends State<PortfolioNavigationBar> {
  bool _isMenuOpen = false;

  final List<Map<String, String>> _navItems = [
    {'title': 'Home', 'id': 'home'},
    {'title': 'About', 'id': 'about'},
    {'title': 'Skills', 'id': 'skills'},
    {'title': 'Projects', 'id': 'projects'},
    {'title': 'Experience', 'id': 'experience'},
    {'title': 'Education', 'id': 'education'},
    {'title': 'Achievements', 'id': 'achievements'},
    {'title': 'Certificates', 'id': 'certificates'},
    {'title': 'Contact', 'id': 'contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0B3D91).withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Logo
                  Text(
                    'Mirthavarshine',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B3D91),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Desktop Navigation
                  if (MediaQuery.of(context).size.width > 768)
                    Row(
                      children: _navItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            onTap: () => widget.onNavItemTap(item['id']!),
                            child: Text(
                              item['title']!,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2B2B2B),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  
                  // Mobile Menu Button
                  if (MediaQuery.of(context).size.width <= 768)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isMenuOpen = !_isMenuOpen;
                        });
                      },
                      icon: Icon(
                        _isMenuOpen ? Icons.close : Icons.menu,
                        color: const Color(0xFF0B3D91),
                        size: 28,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        
        // Mobile Menu Overlay
        if (_isMenuOpen && MediaQuery.of(context).size.width <= 768)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    ..._navItems.map((item) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: InkWell(
                          onTap: () {
                            widget.onNavItemTap(item['id']!);
                            setState(() {
                              _isMenuOpen = false;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF0B3D91).withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item['title']!,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF0B3D91),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: const Color(0xFF0B3D91).withOpacity(0.6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
} 