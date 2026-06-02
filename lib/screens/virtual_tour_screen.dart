import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class VirtualTourScreen extends StatefulWidget {
  final String siteName;
  const VirtualTourScreen({super.key, required this.siteName});

  @override
  State<VirtualTourScreen> createState() => _VirtualTourScreenState();
}

class _VirtualTourScreenState extends State<VirtualTourScreen> with TickerProviderStateMixin {
  bool _isInitializing = true;
  late AnimationController _pulseController;
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      body: Stack(
        children: [
          // Simulated 3D Environment Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/zim_bird_real.png', 
              fit: BoxFit.cover,
              color: AppTheme.surfaceDark.withValues(alpha: 0.7),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          
          if (!_isInitializing) ...[
            // Scanning line effect
            AnimatedBuilder(
              animation: _scanController,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height * _scanController.value,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gold.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            // Floating Interactive Hotspots
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.3,
              child: _buildHotspot('Historical Marker'),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              right: MediaQuery.of(context).size.width * 0.2,
              child: _buildHotspot('Artifact Detail'),
            ),
          ],

          SafeArea(
            child: Column(
              children: [
                _buildTopHUD(context),
                const Spacer(),
                if (_isInitializing)
                  _buildLoadingState()
                else
                  _buildBottomHUD(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHUD(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlassCard(
                padding: EdgeInsets.zero,
                borderRadius: 12,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.gold),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderColor: AppTheme.gold.withValues(alpha: 0.5),
                borderRadius: 20,
                child: Row(
                  children: [
                    FadeTransition(
                      opacity: _pulseController,
                      child: const Icon(Icons.fiber_manual_record, color: AppTheme.redBright, size: 12),
                    ),
                    const SizedBox(width: 8),
                    const Text('LIVE VR FEED', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
                  ],
                ),
              ),
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Image.asset('assets/images/zim_flag_real.png', height: 16, width: 24, fit: BoxFit.cover),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHUDData('ELEV', '1,100M', Icons.height),
              Column(
                children: [
                  const Text('MINISTRY OF PRIMARY AND SECONDARY EDUCATION', 
                    style: TextStyle(color: AppTheme.white50, fontSize: 8, letterSpacing: 2, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(widget.siteName.toUpperCase(), 
                    style: const TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 3)),
                ],
              ),
              _buildHUDData('COORD', '20°16\'S', Icons.gps_fixed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: AppTheme.gold.withValues(alpha: 0.5),
                strokeWidth: 2,
              ),
            ),
            RotationTransition(
              turns: _pulseController,
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  color: AppTheme.gold,
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
            const Icon(Icons.vrpano, color: AppTheme.gold, size: 32),
          ],
        ),
        const SizedBox(height: 24),
        const Text('INITIALIZING 3D ENVIRONMENT', 
          style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 8),
        const Text('Calibrating geometry and textures...', 
          style: TextStyle(color: AppTheme.white50, fontSize: 12)),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildBottomHUD() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        borderColor: AppTheme.gold.withValues(alpha: 0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('INTERACTIVE HERITAGE TOUR', 
              style: TextStyle(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text('Swipe to look around. Pinch to zoom in on structural details. Tap the glowing markers to read historical accounts from the National Archives.',
              style: TextStyle(color: AppTheme.white70, height: 1.5, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHUDAction(Icons.threesixty, 'Rotate'),
                _buildHUDAction(Icons.zoom_in, 'Zoom'),
                _buildHUDAction(Icons.menu_book, 'Archives'),
                _buildHUDAction(Icons.volume_up, 'Audio Guide'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHUDData(String label, String value, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.gold, size: 14),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppTheme.white50, fontSize: 8, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(color: AppTheme.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHUDAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.gold.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: AppTheme.gold, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppTheme.white70, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildHotspot(String tooltip) {
    return FadeTransition(
      opacity: _pulseController,
      child: Tooltip(
        message: tooltip,
        preferBelow: false,
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.gold),
        ),
        textStyle: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.gold, width: 2),
            color: AppTheme.gold.withValues(alpha: 0.3),
            boxShadow: [
              BoxShadow(
                color: AppTheme.gold.withValues(alpha: 0.6),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: const Center(
            child: Icon(Icons.add, color: AppTheme.white, size: 16),
          ),
        ),
      ),
    );
  }
}
