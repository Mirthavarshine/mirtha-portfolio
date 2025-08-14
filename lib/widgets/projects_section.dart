import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Map<int, AnimationController> _hoverControllers = {};
  Map<int, bool> _isHovered = {};
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Drug Network Detection via Messaging Platforms',
      'subtitle': 'Smart India Hackathon 2023',
      'category': 'AI/ML',
      'description': 'Developed an AI-powered system to detect and analyze drug trafficking networks through messaging platforms. Implemented machine learning algorithms for pattern recognition and real-time monitoring. The system achieved 85% accuracy in detection and won 2nd Prize in Smart India Hackathon 2023.',
      'techStack': ['Python', 'Machine Learning', 'NLP', 'Flask', 'MongoDB', 'TensorFlow'],
      'image': 'assets/project1.jpg',
      'achievements': ['Won 2nd Prize in Smart India Hackathon 2023', 'Implemented real-time monitoring system', 'Achieved 85% accuracy in detection', 'Integrated with multiple messaging platforms'],
      'date': 'December 2023',
      'color': Color(0xFF0B3D91),
    },
    {
      'title': 'Indian Knowledge Systems',
      'subtitle': 'VR Learning Module',
      'category': 'VR/AR',
      'description': 'Created an immersive Virtual Reality learning module showcasing Indian knowledge systems. Users can explore ancient texts, architectural marvels, and cultural heritage in an interactive 3D environment. The project demonstrates advanced VR development skills and educational technology integration.',
      'techStack': ['Unity3D', 'C#', 'VR Development', '3D Modeling', 'Blender', 'Oculus SDK'],
      'image': 'assets/project2.jpg',
      'achievements': ['Immersive VR experience', 'Interactive 3D models', 'Educational content integration', 'Cross-platform VR support'],
      'date': 'November 2023',
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'AI Chatbot for User Queries',
      'subtitle': 'Intelligent Support System',
      'category': 'AI/ML',
      'description': 'Built an intelligent chatbot system that handles user queries using natural language processing. The system provides accurate responses and learns from user interactions to improve over time. Features multi-language support and real-time learning capabilities.',
      'techStack': ['Python', 'NLP', 'TensorFlow', 'Flutter', 'Firebase', 'Dialogflow'],
      'image': 'assets/project3.jpg',
      'achievements': ['90% query resolution rate', 'Multi-language support', 'Real-time learning capabilities', 'Seamless integration with existing systems'],
      'date': 'October 2023',
      'color': Color(0xFF9C27B0),
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.all_inclusive, 'color': Color(0xFF0B3D91)},
    {'name': 'AI/ML', 'icon': Icons.psychology, 'color': Color(0xFF0B3D91)},
    {'name': 'VR/AR', 'icon': Icons.view_in_ar, 'color': Color(0xFF4CAF50)},
    {'name': 'Web', 'icon': Icons.web, 'color': Color(0xFFF5C518)},
    {'name': 'Mobile', 'icon': Icons.phone_android, 'color': Color(0xFF9C27B0)},
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
    
    // Initialize hover controllers for each project
    for (int i = 0; i < _projects.length; i++) {
      _hoverControllers[i] = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
      _isHovered[i] = false;
    }
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _hoverControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProjects {
    return _projects.where((project) {
      final matchesCategory = _selectedCategory == 'All' || project['category'] == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty || 
          project['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          project['description'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (project['techStack'] as List<String>).any((tech) => 
              tech.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
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
                  child: Column(
                    children: [
                      // Section Title
                      Text(
                        'Featured Projects',
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
                      
                      // Search Bar
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search projects...',
                            prefixIcon: const Icon(Icons.search, color: Color(0xFF0B3D91)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(color: Color(0xFF0B3D91), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                        ),
                      ),
                      
                      // Category Filters
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 768) {
                            // Desktop Filters
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _categories.map((category) {
                                final isSelected = _selectedCategory == category['name'];
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _selectedCategory = category['name'];
                                      });
                                    },
                                    icon: Icon(
                                      category['icon'],
                                      size: 20,
                                      color: isSelected ? Colors.white : category['color'],
                                    ),
                                    label: Text(
                                      category['name'],
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Colors.white : category['color'],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected ? category['color'] : Colors.white,
                                      foregroundColor: isSelected ? Colors.white : category['color'],
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(
                                          color: category['color'],
                                          width: 2,
                                        ),
                                      ),
                                      elevation: isSelected ? 4 : 0,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            // Mobile Filters
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: _categories.map((category) {
                                final isSelected = _selectedCategory == category['name'];
                                return ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _selectedCategory = category['name'];
                                    });
                                  },
                                  icon: Icon(
                                    category['icon'],
                                    size: 16,
                                    color: isSelected ? Colors.white : category['color'],
                                  ),
                                  label: Text(
                                    category['name'],
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : category['color'],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected ? category['color'] : Colors.white,
                                    foregroundColor: isSelected ? Colors.white : category['color'],
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: category['color'],
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: isSelected ? 4 : 0,
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Projects Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 768) {
                            // Desktop Layout
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: _filteredProjects.length,
                              itemBuilder: (context, index) {
                                final project = _filteredProjects[index];
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: _buildProjectCard(project, index),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            // Mobile Layout
                            return Column(
                              children: _filteredProjects.asMap().entries.map((entry) {
                                int index = entry.key;
                                Map<String, dynamic> project = entry.value;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 24),
                                        child: _buildProjectCard(project, index),
                                      ),
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

  Widget _buildProjectCard(Map<String, dynamic> project, int index) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered[index] = true;
        });
        _hoverControllers[index]?.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered[index] = false;
        });
        _hoverControllers[index]?.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverControllers[index] ?? const AlwaysStoppedAnimation(0),
        builder: (context, child) {
          final hoverValue = _hoverControllers[index]?.value ?? 0;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(hoverValue * 0.1)
              ..rotateX(hoverValue * 0.05),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: project['color'].withOpacity(0.1 + hoverValue * 0.2),
                    blurRadius: 20 + hoverValue * 10,
                    offset: Offset(0, 10 + hoverValue * 5),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => _showProjectDetails(project),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          project['color'].withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Image with Category Badge
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [project['color'], project['color'].withOpacity(0.7)],
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.work,
                                  size: 60,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  project['category'],
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: project['color'],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Project Content
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project['title'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0B3D91),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  project['subtitle'],
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: project['color'],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  project['date'],
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF666666),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  project['description'],
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF2B2B2B),
                                    height: 1.5,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 20),
                                
                                // Tech Stack
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: (project['techStack'] as List<String>).take(3).map((tech) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: project['color'].withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        tech,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: project['color'],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                
                                const Spacer(),
                                
                                // View Details Button
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () => _showProjectDetails(project),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: project['color'],
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: Text(
                                      'View Details',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showProjectDetails(Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: project['color'],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['title'],
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            project['subtitle'],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  project['category'],
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                project['date'],
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFF5C518),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B3D91),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project['description'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2B2B2B),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      Text(
                        'Technologies Used',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B3D91),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (project['techStack'] as List<String>).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: project['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: project['color'],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      
                      Text(
                        'Key Achievements',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B3D91),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...(project['achievements'] as List<String>).map((achievement) {
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
                                  color: project['color'],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  achievement,
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
            ],
          ),
        ),
      ),
    );
  }
} 