import 'package:flutter/material.dart';

class SubjectThemeData {
  final Color primaryColor;
  final Gradient headerGradient;
  final Gradient backgroundGradient;
  final Color glowColor;
  final Color accentColor;
  final Color cardTint;
  final List<BoxShadow> glow;

  const SubjectThemeData({
    required this.primaryColor,
    required this.headerGradient,
    required this.backgroundGradient,
    required this.glowColor,
    required this.accentColor,
    required this.cardTint,
    required this.glow,
  });
}

class SubjectThemes {
  // English / Language - Sapphire Blue
  static const _engPrimary = Color(0xFF1565C0);
  static const _engAccent = Color(0xFF42A5F5);
  static const _engDark = Color(0xFF0D47A1);

  // Mathematics - Emerald Green
  static const _matPrimary = Color(0xFF2E7D32);
  static const _matAccent = Color(0xFF66BB6A);
  static const _matDark = Color(0xFF1B5E20);

  // Shona/Ndebele - Royal Purple
  static const _shoPrimary = Color(0xFF7B1FA2);
  static const _shoAccent = Color(0xFFAB47BC);
  static const _shoDark = Color(0xFF4A148C);

  // Heritage-Social Studies - Amber/Gold
  static const _hssPrimary = Color(0xFFE65100);
  static const _hssAccent = Color(0xFFFF9800);
  static const _hssDark = Color(0xFFBF360C);

  // Science / Environmental - Cyan/Teal
  static const _sciPrimary = Color(0xFF00838F);
  static const _sciAccent = Color(0xFF26C6DA);
  static const _sciDark = Color(0xFF006064);

  // Agriculture - Forest Green
  static const _agrPrimary = Color(0xFF33691E);
  static const _agrAccent = Color(0xFF689F38);
  static const _agrDark = Color(0xFF1B5E20);

  // Arts - Magenta/Rose
  static const _artPrimary = Color(0xFFAD1457);
  static const _artAccent = Color(0xFFE91E63);
  static const _artDark = Color(0xFF880E4F);

  // FRM - Brown/Terracotta
  static const _frmPrimary = Color(0xFF5D4037);
  static const _frmAccent = Color(0xFF8D6E63);
  static const _frmDark = Color(0xFF3E2723);

  // PE/Sports - Crimson Red
  static const _pePrimary = Color(0xFFC62828);
  static const _peAccent = Color(0xFFEF5350);
  static const _peDark = Color(0xFFB71C1C);

  // ICT - Indigo
  static const _ictPrimary = Color(0xFF283593);
  static const _ictAccent = Color(0xFF5C6BC0);
  static const _ictDark = Color(0xFF1A237E);

  // Social-Emotional - Warm Orange
  static const _sedPrimary = Color(0xFFFF8F00);
  static const _sedAccent = Color(0xFFFFB300);
  static const _sedDark = Color(0xFFE65100);

  // Creative - Coral/Pink
  static const _crePrimary = Color(0xFFD81B60);
  static const _creAccent = Color(0xFFF06292);

  // Physical Development - Red
  static const _phyPrimary = Color(0xFFD32F2F);
  static const _phyAccent = Color(0xFFE57373);

  // Indigenous Language - Purple
  static const _indPrimary = Color(0xFF6A1B9A);
  static const _indAccent = Color(0xFFCE93D8);

  static final Map<String, SubjectThemeData> _themeMap = {
    // English
    'eng': SubjectThemeData(
      primaryColor: _engPrimary,
      accentColor: _engAccent,
      glowColor: _engAccent,
      cardTint: _engAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_engDark, _engPrimary, _engAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _engDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _engAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Mathematics
    'mat': SubjectThemeData(
      primaryColor: _matPrimary,
      accentColor: _matAccent,
      glowColor: _matAccent,
      cardTint: _matAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_matDark, _matPrimary, _matAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _matDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _matAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Shona/Ndebele
    'sho': SubjectThemeData(
      primaryColor: _shoPrimary,
      accentColor: _shoAccent,
      glowColor: _shoAccent,
      cardTint: _shoAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_shoDark, _shoPrimary, _shoAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _shoDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _shoAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Heritage-Social Studies
    'hss': SubjectThemeData(
      primaryColor: _hssPrimary,
      accentColor: _hssAccent,
      glowColor: _hssAccent,
      cardTint: _hssAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_hssDark, _hssPrimary, _hssAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _hssDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _hssAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Science (g*_sci, g*_sct)
    'sci': SubjectThemeData(
      primaryColor: _sciPrimary,
      accentColor: _sciAccent,
      glowColor: _sciAccent,
      cardTint: _sciAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_sciDark, _sciPrimary, _sciAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _sciDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _sciAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Agriculture
    'agr': SubjectThemeData(
      primaryColor: _agrPrimary,
      accentColor: _agrAccent,
      glowColor: _agrAccent,
      cardTint: _agrAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_agrDark, _agrPrimary, _agrAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _agrDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _agrAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Visual & Performing Arts
    'vpa': SubjectThemeData(
      primaryColor: _artPrimary,
      accentColor: _artAccent,
      glowColor: _artAccent,
      cardTint: _artAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_artDark, _artPrimary, _artAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _artDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _artAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Family, Religion & Moral Education
    'frm': SubjectThemeData(
      primaryColor: _frmPrimary,
      accentColor: _frmAccent,
      glowColor: _frmAccent,
      cardTint: _frmAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_frmDark, _frmPrimary, _frmAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _frmDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _frmAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Physical Education / Sports
    'pe': SubjectThemeData(
      primaryColor: _pePrimary,
      accentColor: _peAccent,
      glowColor: _peAccent,
      cardTint: _peAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_peDark, _pePrimary, _peAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _peDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _peAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // ICT / Computer
    'ict': SubjectThemeData(
      primaryColor: _ictPrimary,
      accentColor: _ictAccent,
      glowColor: _ictAccent,
      cardTint: _ictAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_ictDark, _ictPrimary, _ictAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _ictDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _ictAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Environmental Science (ECD)
    'env': SubjectThemeData(
      primaryColor: _sciPrimary,
      accentColor: _sciAccent,
      glowColor: _sciAccent,
      cardTint: _sciAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_sciDark, Color(0xFF00838F), _sciAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _sciDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _sciAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Social & Emotional Development (ECD)
    'sed': SubjectThemeData(
      primaryColor: _sedPrimary,
      accentColor: _sedAccent,
      glowColor: _sedAccent,
      cardTint: _sedAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_sedDark, _sedPrimary, _sedAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _sedDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _sedAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Creative Arts (ECD)
    'cre': SubjectThemeData(
      primaryColor: _crePrimary,
      accentColor: _creAccent,
      glowColor: _creAccent,
      cardTint: _creAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [Color(0xFF880E4F), _crePrimary, _creAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          Color(0xFF880E4F).withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _creAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Physical Development (ECD)
    'phy': SubjectThemeData(
      primaryColor: _phyPrimary,
      accentColor: _phyAccent,
      glowColor: _phyAccent,
      cardTint: _phyAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [Color(0xFFB71C1C), _phyPrimary, _phyAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          Color(0xFFB71C1C).withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _phyAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Indigenous Language (ECD)
    'ind': SubjectThemeData(
      primaryColor: _indPrimary,
      accentColor: _indAccent,
      glowColor: _indAccent,
      cardTint: _indAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [Color(0xFF4A148C), _indPrimary, _indAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          Color(0xFF4A148C).withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _indAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),

    // Language & Communication (ECD)
    'lan': SubjectThemeData(
      primaryColor: _engPrimary,
      accentColor: _engAccent,
      glowColor: _engAccent,
      cardTint: _engAccent.withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [_engDark, _engPrimary, _engAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          _engDark.withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: _engAccent.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    ),
  };

  static SubjectThemeData? forSubjectId(String subjectId) {
    final parts = subjectId.split('_');
    if (parts.length < 2) return null;
    final suffix = parts[1];
    return _themeMap[suffix];
  }

  static SubjectThemeData fromSubjectColor(Color subjectColor) {
    return SubjectThemeData(
      primaryColor: subjectColor,
      accentColor: subjectColor,
      glowColor: subjectColor,
      cardTint: subjectColor.withValues(alpha: 0.08),
      headerGradient: LinearGradient(
        colors: [
          subjectColor.withValues(alpha: 0.8),
          subjectColor,
          subjectColor.withValues(alpha: 1.2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          subjectColor.withValues(alpha: 0.2),
          const Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: subjectColor.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    );
  }

  static SubjectThemeData getDefault() {
    return SubjectThemeData(
      primaryColor: const Color(0xFF006B3F),
      accentColor: const Color(0xFF00A85A),
      glowColor: const Color(0xFF00E676),
      cardTint: const Color(0xFF00A85A).withValues(alpha: 0.08),
      headerGradient: const LinearGradient(
        colors: [Color(0xFF004D2E), Color(0xFF006B3F), Color(0xFF00A85A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      backgroundGradient: LinearGradient(
        colors: [
          Color(0xFF004D2E).withValues(alpha: 0.3),
          Color(0xFF0B1A10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      glow: [
        BoxShadow(color: const Color(0xFF00E676).withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 4)),
      ],
    );
  }
}
