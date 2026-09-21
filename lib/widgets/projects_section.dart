import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'AI Prompt Evaluation & Structured Response Testing',
      'subtitle': 'Prompt Engineering Project',
      'category': 'AI/ML',
      'description':
          'Designed and refined prompts for generating structured responses across different task scenarios. Evaluated AI-generated responses for relevance, consistency, instruction adherence, and formatting accuracy. Experimented with zero-shot and few-shot prompting techniques to improve response quality. Documented prompt variations and compared outputs to identify opportunities for prompt refinement.',
      'techStack': ['Prompt Engineering', 'LLMs', 'Python', 'JSON'],
      'image': 'assets/project1.jpg',
      'achievements': [
        'Prompt Design and Refinement',
        'Zero-shot and Few-shot Prompting',
        'Structured Response Generation',
        'AI Response Evaluation',
        'Instruction Adherence',
        'Output Comparison',
        'Prompt Optimization',
      ],
      'date': '',
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

  List<Map<String, dynamic>> get _filteredProjects => _projects;

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
                      
                      // Single featured project — no search/filter clutter
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 768) {
                            return Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 560),
                                child: SizedBox(
                                  height: 580,
                                  child: AnimationConfiguration.staggeredList(
                                    position: 0,
                                    duration: const Duration(milliseconds: 600),
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: _buildProjectCard(
                                          _filteredProjects.first,
                                          0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
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
                                        height: 560,
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
                                if ((project['date'] as String).isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    project['date'],
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                ],
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
                              if ((project['date'] as String).isNotEmpty) ...[
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
                        'Project Highlights',
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