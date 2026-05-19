import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/demo_data.dart';
import '../data/heritage_data.dart';
import '../data/national_data.dart';
import '../models/heritage.dart';
import '../theme/app_theme.dart';

class ZimbabweMapScreen extends StatefulWidget {
  const ZimbabweMapScreen({super.key});

  @override
  State<ZimbabweMapScreen> createState() => _ZimbabweMapScreenState();
}

class _ZimbabweMapScreenState extends State<ZimbabweMapScreen> {
  bool _showProvinces = true;
  bool _showHeritage = true;
  bool _showSchools = false;

  // Province centroid positions (fractional x,y on the SVG viewBox)
  static const Map<String, Offset> _provincePositions = {
    'Bulawayo': Offset(0.27, 0.72),
    'Harare': Offset(0.67, 0.38),
    'Manicaland': Offset(0.82, 0.52),
    'Mashonaland Central': Offset(0.60, 0.22),
    'Mashonaland East': Offset(0.72, 0.42),
    'Mashonaland West': Offset(0.48, 0.30),
    'Masvingo': Offset(0.60, 0.70),
    'Matabeleland North': Offset(0.28, 0.38),
    'Matabeleland South': Offset(0.33, 0.62),
    'Midlands': Offset(0.45, 0.55),
  };

  // Heritage site positions (fractional x,y on the SVG viewBox)
  static const Map<String, Offset> _heritagePositions = {
    'Great Zimbabwe': Offset(0.62, 0.68),
    'Khami Ruins': Offset(0.24, 0.70),
    'Matobo Hills': Offset(0.28, 0.64),
    'Victoria Falls': Offset(0.08, 0.35),
    'National War Memorial': Offset(0.67, 0.40),
    'Chinhoyi Caves': Offset(0.50, 0.28),
    'Tsindi Ruins': Offset(0.75, 0.50),
    'Domboshava Rock': Offset(0.65, 0.35),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zimbabwe Education Map',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/zimbabwe_map_outline.svg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                        AppTheme.primaryGreen,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  if (_showProvinces) ..._buildProvinceMarkers(),
                  if (_showHeritage) ..._buildHeritageMarkers(),
                  if (_showSchools) ..._buildSchoolMarkers(),
                ],
              ),
            ),
          ),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.surfaceDark,
      child: Row(
        children: [
          _buildFilterChip('Provinces', _showProvinces, (v) => setState(() => _showProvinces = v), AppTheme.gold),
          const SizedBox(width: 8),
          _buildFilterChip('Heritage', _showHeritage, (v) => setState(() => _showHeritage = v), Colors.purple),
          const SizedBox(width: 8),
          _buildFilterChip('Schools', _showSchools, (v) => setState(() => _showSchools = v), AppTheme.greenBright),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected, ValueChanged<bool> onToggle, Color color) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onToggle,
      selectedColor: color.withValues(alpha: 0.2),
      checkmarkColor: color,
      labelStyle: TextStyle(
        color: selected ? color : AppTheme.white60,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(color: selected ? color : AppTheme.white20),
    );
  }

  List<Widget> _buildProvinceMarkers() {
    final provinces = DemoData.provinceMetrics;
    return provinces.entries.map((entry) {
      final pos = _provincePositions[entry.key];
      if (pos == null) return const SizedBox.shrink();
      final passRate = entry.value['passRate'] as double;
      final color = passRate >= 70
          ? AppTheme.greenBright
          : (passRate >= 60 ? AppTheme.gold : AppTheme.redBright);

      return Positioned(
        left: pos.dx * MediaQuery.of(context).size.width - 20,
        top: pos.dy * (MediaQuery.of(context).size.height - 180) - 20,
        child: GestureDetector(
          onTap: () => _showProvinceInfo(entry.key, entry.value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                  boxShadow: [
                    BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8),
                  ],
                ),
                child: Center(
                  child: Text('${passRate.toStringAsFixed(0)}%',
                    style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(entry.key.length > 12 ? '${entry.key.substring(0, 10)}..' : entry.key,
                  style: const TextStyle(color: AppTheme.white, fontSize: 8)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildHeritageMarkers() {
    final sites = getHeritageSites();
    return sites.map((site) {
      final pos = _heritagePositions[site.name];
      if (pos == null) return const SizedBox.shrink();

      return Positioned(
        left: pos.dx * MediaQuery.of(context).size.width - 12,
        top: pos.dy * (MediaQuery.of(context).size.height - 180) - 12,
        child: GestureDetector(
          onTap: () => _showHeritageInfo(site),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple, width: 1.5),
            ),
            child: const Icon(Icons.museum, color: Colors.purple, size: 14),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildSchoolMarkers() {
    final provinces = getProvinces();
    final List<Widget> markers = [];
    for (final province in provinces) {
      for (final district in province.districts) {
        for (final school in district.schools) {
          // Approximate position based on lat/lng
          final x = ((school.lng - 25) / 8.5).clamp(0.0, 1.0);
          final y = ((school.lat + 22.5) / 7).clamp(0.0, 1.0);
          markers.add(
            Positioned(
              left: x * MediaQuery.of(context).size.width - 6,
              top: y * (MediaQuery.of(context).size.height - 180) - 6,
              child: GestureDetector(
                onTap: () => _showSchoolInfo(school, district.name, province.name),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.greenBright, width: 1),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    return markers;
  }

  void _showProvinceInfo(String name, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStat('Schools', '${data['schools']}', Icons.school, AppTheme.greenBright),
                _buildStat('Students', '${data['students']}', Icons.people, AppTheme.gold),
                _buildStat('Pass Rate', '${data['passRate']}%', Icons.trending_up,
                  (data['passRate'] as double) >= 70 ? AppTheme.greenBright : AppTheme.redBright),
              ],
            ),
            const SizedBox(height: 12),
            Text('Risk Level: ${(data['risk'] as String).toUpperCase()}',
              style: TextStyle(
                color: (data['risk'] as String) == 'high' ? AppTheme.redBright : AppTheme.greenBright,
                fontWeight: FontWeight.bold,
              )),
          ],
        ),
      ),
    );
  }

  void _showHeritageInfo(HeritageSite site) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(site.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                ),
                if (site.isUnesco)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                    ),
                    child: const Text('UNESCO', style: TextStyle(color: AppTheme.gold, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text('${site.location}, ${site.province}',
              style: const TextStyle(color: AppTheme.white60)),
            const SizedBox(height: 16),
            Text(site.description,
              style: const TextStyle(color: AppTheme.white70, fontSize: 14)),
            const SizedBox(height: 12),
            Text(site.significance,
              style: const TextStyle(color: AppTheme.white50, fontSize: 13, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  void _showSchoolInfo(dynamic school, String district, String province) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(school.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            Text('$district, $province', style: const TextStyle(color: AppTheme.white60)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStat('Enrolled', '${school.enrolment}', Icons.people, AppTheme.greenBright),
                _buildStat('Teachers', '${school.teachers}', Icons.person, AppTheme.gold),
                _buildStat('Pass Rate', '${school.passRate.toStringAsFixed(0)}%', Icons.trending_up,
                  school.passRate >= 70 ? AppTheme.greenBright : AppTheme.gold),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (school.hasInternet) _buildInfraChip('Internet', Icons.wifi, AppTheme.greenBright),
                if (school.hasElectricity) _buildInfraChip('Electricity', Icons.bolt, AppTheme.gold),
                if (school.hasWater) _buildInfraChip('Water', Icons.water_drop, Colors.blue),
                if (!school.hasInternet) _buildInfraChip('No Internet', Icons.wifi_off, AppTheme.redBright),
                if (!school.hasElectricity) _buildInfraChip('No Electricity', Icons.power_settings_new, AppTheme.redBright),
                if (!school.hasWater) _buildInfraChip('No Water', Icons.water_drop_outlined, AppTheme.redBright),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildInfraChip(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        avatar: Icon(icon, size: 14, color: color),
        label: Text(label, style: TextStyle(fontSize: 10, color: color)),
        backgroundColor: color.withValues(alpha: 0.1),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppTheme.surfaceDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(AppTheme.greenBright, 'Pass ≥70%'),
          _buildLegendItem(AppTheme.gold, 'Pass 60-70%'),
          _buildLegendItem(AppTheme.redBright, 'Pass <60%'),
          _buildLegendItem(Colors.purple, 'Heritage Sites'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 10)),
      ],
    );
  }
}
