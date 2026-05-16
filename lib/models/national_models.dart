class Province {
  final String id;
  final String name;
  final int population;
  final List<District> districts;

  const Province({required this.id, required this.name, required this.population, required this.districts});
}

class District {
  final String id;
  final String name;
  final int population;
  final List<School> schools;

  const District({required this.id, required this.name, required this.population, required this.schools});
}

class School {
  final String id;
  final String name;
  final String type;
  final String sector;
  final int enrolment;
  final int teachers;
  final double passRate;
  final double attendanceRate;
  final bool hasInternet;
  final bool hasElectricity;
  final bool hasWater;
  final double lat;
  final double lng;

  const School({
    required this.id, required this.name, required this.type, required this.sector,
    required this.enrolment, required this.teachers, required this.passRate,
    required this.attendanceRate, required this.hasInternet, required this.hasElectricity,
    required this.hasWater, required this.lat, required this.lng,
  });
}

class NationalMetric {
  final String label;
  final String value;
  final String delta;
  final bool isPositive;
  final IconType icon;

  const NationalMetric({required this.label, required this.value, required this.delta, required this.isPositive, required this.icon});
}

enum IconType { school, teacher, student, passRate, attendance, internet, electricity, water, trend, prediction, passport, heritage, content }

class NDS1KPI {
  final String indicator;
  final double baseline2021;
  final double target2025;
  final double current;
  final String status;

  const NDS1KPI({required this.indicator, required this.baseline2021, required this.target2025, required this.current, required this.status});
}

class NdsGoal {
  final String id;
  final String title;
  final String description;
  final double progress;
  final String target;
  final List<String> milestones;
  final String color;

  const NdsGoal({required this.id, required this.title, required this.description, required this.progress, required this.target, required this.milestones, required this.color});
}
