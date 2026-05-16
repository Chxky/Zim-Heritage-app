import '../models/national_models.dart';

List<Province> getProvinces() => [
  Province(id: 'prov_bul', name: 'Bulawayo', population: 1651000, districts: [
    District(id: 'dist_bul_c', name: 'Bulawayo Central', population: 450000, schools: [
      School(id: 'sch_bul_1', name: 'Bulawayo High School', type: 'secondary', sector: 'government', enrolment: 1200, teachers: 45, passRate: 78.5, attendanceRate: 91.2, hasInternet: true, hasElectricity: true, hasWater: true, lat: -20.148, lng: 28.587),
      School(id: 'sch_bul_2', name: 'Mpopoma Primary', type: 'primary', sector: 'government', enrolment: 850, teachers: 28, passRate: 72.3, attendanceRate: 88.7, hasInternet: false, hasElectricity: true, hasWater: true, lat: -20.165, lng: 28.565),
      School(id: 'sch_bul_3', name: 'St Columbus High', type: 'secondary', sector: 'mission', enrolment: 980, teachers: 38, passRate: 85.1, attendanceRate: 95.4, hasInternet: true, hasElectricity: true, hasWater: true, lat: -20.132, lng: 28.602),
    ]),
  ]),
  Province(id: 'prov_har', name: 'Harare', population: 3150000, districts: [
    District(id: 'dist_har_c', name: 'Harare Central', population: 980000, schools: [
      School(id: 'sch_har_1', name: 'Prince Edward School', type: 'secondary', sector: 'government', enrolment: 1500, teachers: 52, passRate: 82.4, attendanceRate: 93.1, hasInternet: true, hasElectricity: true, hasWater: true, lat: -17.822, lng: 31.044),
      School(id: 'sch_har_2', name: 'Queen Elizabeth High', type: 'secondary', sector: 'government', enrolment: 1350, teachers: 48, passRate: 79.8, attendanceRate: 90.5, hasInternet: true, hasElectricity: true, hasWater: true, lat: -17.835, lng: 31.028),
    ]),
  ]),
  Province(id: 'prov_mas', name: 'Masvingo', population: 1585000, districts: [
    District(id: 'dist_mas_c', name: 'Masvingo Central', population: 320000, schools: [
      School(id: 'sch_mas_1', name: 'Masvingo High', type: 'secondary', sector: 'government', enrolment: 920, teachers: 34, passRate: 68.2, attendanceRate: 85.3, hasInternet: false, hasElectricity: true, hasWater: true, lat: -20.074, lng: 30.828),
    ]),
  ]),
  Province(id: 'prov_mid', name: 'Midlands', population: 1815000, districts: [
    District(id: 'dist_gwe', name: 'Gweru', population: 410000, schools: [
      School(id: 'sch_gwe_1', name: 'Gweru High', type: 'secondary', sector: 'government', enrolment: 1050, teachers: 40, passRate: 71.5, attendanceRate: 87.8, hasInternet: true, hasElectricity: true, hasWater: true, lat: -19.462, lng: 29.812),
    ]),
  ]),
  Province(id: 'prov_man', name: 'Manicaland', population: 1950000, districts: [
    District(id: 'dist_mut', name: 'Mutare', population: 495000, schools: [
      School(id: 'sch_mut_1', name: 'Mutare High', type: 'secondary', sector: 'government', enrolment: 880, teachers: 32, passRate: 74.6, attendanceRate: 89.2, hasInternet: false, hasElectricity: true, hasWater: true, lat: -18.970, lng: 32.645),
    ]),
  ]),
  Province(id: 'prov_mat_n', name: 'Matabeleland North', population: 750000, districts: [
    District(id: 'dist_lup', name: 'Lupane', population: 140000, schools: [
      School(id: 'sch_lup_1', name: 'Lupane High', type: 'secondary', sector: 'government', enrolment: 650, teachers: 24, passRate: 58.3, attendanceRate: 78.5, hasInternet: false, hasElectricity: false, hasWater: true, lat: -18.931, lng: 27.769),
    ]),
  ]),
  Province(id: 'prov_mat_s', name: 'Matabeleland South', population: 710000, districts: [
    District(id: 'dist_gwanda', name: 'Gwanda', population: 165000, schools: [
      School(id: 'sch_gwa_1', name: 'Gwanda High', type: 'secondary', sector: 'government', enrolment: 720, teachers: 27, passRate: 62.1, attendanceRate: 81.4, hasInternet: false, hasElectricity: true, hasWater: true, lat: -20.933, lng: 29.012),
    ]),
  ]),
];

List<NationalMetric> getNationalMetrics() => [
  const NationalMetric(label: 'Schools', value: '9,872', delta: '+124', isPositive: true, icon: IconType.school),
  const NationalMetric(label: 'Enrolled Students', value: '4.8M', delta: '+2.3%', isPositive: true, icon: IconType.student),
  const NationalMetric(label: 'Trained Teachers', value: '148,200', delta: '+3,400', isPositive: true, icon: IconType.teacher),
  const NationalMetric(label: 'Pass Rate (2024)', value: '68.4%', delta: '+4.1%', isPositive: true, icon: IconType.passRate),
  const NationalMetric(label: 'Avg Attendance', value: '86.2%', delta: '-1.3%', isPositive: false, icon: IconType.attendance),
  const NationalMetric(label: 'Schools with Internet', value: '32.1%', delta: '+8.5%', isPositive: true, icon: IconType.internet),
];

List<NDS1KPI> getNDS1KPIs() => [
  const NDS1KPI(indicator: 'Gross Enrolment Ratio (Primary)', baseline2021: 95.2, target2025: 100.0, current: 97.8, status: 'on-track'),
  const NDS1KPI(indicator: 'Gross Enrolment Ratio (Secondary)', baseline2021: 52.0, target2025: 65.0, current: 58.4, status: 'on-track'),
  const NDS1KPI(indicator: 'Pass Rate (Grade 7)', baseline2021: 58.3, target2025: 75.0, current: 68.4, status: 'on-track'),
  const NDS1KPI(indicator: 'Pass Rate (O-Level)', baseline2021: 24.5, target2025: 45.0, current: 35.2, status: 'needs-attention'),
  const NDS1KPI(indicator: 'Pass Rate (A-Level)', baseline2021: 72.1, target2025: 85.0, current: 78.6, status: 'on-track'),
  const NDS1KPI(indicator: 'ICT-Enabled Schools', baseline2021: 18.5, target2025: 50.0, current: 32.1, status: 'on-track'),
  const NDS1KPI(indicator: 'Gender Parity (Secondary)', baseline2021: 0.92, target2025: 1.0, current: 0.96, status: 'on-track'),
  const NDS1KPI(indicator: 'Trained Teacher Ratio', baseline2021: 72.0, target2025: 90.0, current: 81.5, status: 'on-track'),
];

List<NdsGoal> getNdsGoals() => [
  NdsGoal(id: 'goal1', title: 'Universal Primary Completion', description: 'Every child completes primary education by 2030, aligned with SDG 4 and Vision 2030.', progress: 0.82, target: '100% by 2030', milestones: ['85% by 2025 (current: 82%)', '92% by 2027', '100% by 2030'], color: '0xFF2E7D32'),
  NdsGoal(id: 'goal2', title: 'Secondary Education Transformation', description: 'Increase secondary enrolment from 52% to 85% through infrastructure, scholarships, and flexible learning pathways.', progress: 0.58, target: '85% by 2030', milestones: ['65% by 2025 (current: 58%)', '75% by 2027', '85% by 2030'], color: '0xFF1565C0'),
  NdsGoal(id: 'goal3', title: 'Digital Learning For All', description: 'Every school connected with ICT infrastructure, solar power, and digital learning platforms.', progress: 0.32, target: '100% by 2030', milestones: ['50% by 2025 (current: 32%)', '75% by 2027', '100% by 2030'], color: '0xFF7B1FA2'),
  NdsGoal(id: 'goal4', title: 'Teacher Excellence', description: 'All teachers trained, equipped with digital tools, and supported through continuous professional development.', progress: 0.72, target: '90% trained by 2025', milestones: ['81% trained (current)', '85% by 2026', '90% by 2025'], color: '0xFFE65100'),
  NdsGoal(id: 'goal5', title: 'Heritage-Based Curriculum Implementation', description: 'Full rollout of Heritage-Based Curriculum across all 15 grade levels with quality learning materials.', progress: 0.65, target: '100% by 2026', milestones: ['ECD-Grade 4 complete', 'Grade 5-7 by 2024', 'Form 1-6 by 2026'], color: '0xFFAD1457'),
];
