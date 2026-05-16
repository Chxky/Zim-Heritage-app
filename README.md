# ZimHeritage - Zimbabwe Heritage-Based Curriculum Learning Platform

**ZimHeritage** is a comprehensive educational platform for the Zimbabwe Heritage-Based Curriculum, covering ECD A through Form 6 (15 grade levels).

## Features

- **Full Curriculum Coverage**: All 15 grade levels (ECD A → Form 6) with subjects aligned to the Zimbabwe Ministry of Education framework
- **Interactive Lessons**: Rich study content with objectives, explanations, examples, and practice questions
- **Past Exam Questions**: Real ZIMSEC-style past exam questions (Grade 5 to Form 6) with model answers and marking guides
- **AI Tutor**: Google Gemini-powered tutoring assistant that provides personalised learning support
- **Homework System**: Digital homework creation, submission, and marking workflow
- **Progress Tracking**: Performance analytics per subject and topic
- **Visual Aids**: Learning pictures for ECD to Grade 2 foundational levels
- **Multi-Role Support**: Student, Teacher, Parent, and Admin dashboards
- **Offline Mode**: Works without internet using built-in curriculum data
- **Firebase Ready**: Optional Firebase backend for cloud synchronisation

## Tech Stack

- **Framework**: Flutter 3.x (Dart 3.11+)
- **AI**: Google Gemini API
- **Backend**: Firebase (Auth, Firestore, Storage) — optional, works fully offline
- **Theme**: Custom Zimbabwe heritage-inspired dark theme

## Build & Deploy

```bash
# Development
flutter run -d chrome

# Android APK
flutter build apk --release

# iOS Archive
flutter build ios --release

# Analyze
flutter analyze
```

## Project Structure

```
lib/
├── main.dart                 # Entry, routing, splash, login, dashboards
├── data/                     # Curriculum content, lessons, exam questions
│   ├── zimbabwe_curriculum.dart
│   ├── lesson_content.dart   # 50+ lessons across all grades
│   ├── past_exam_questions.dart
│   ├── book_data.dart
│   └── ecd_visual_aids.dart
├── models/                   # Data models
├── screens/                  # UI screens
│   ├── student/              # Student dashboard, lessons, exams, progress
│   └── teacher/              # Teacher dashboard, AI assistant, review
├── services/                 # Firebase, mock data, auth
├── theme/                    # Zimbabwe flag color palette
└── widgets/                  # Reusable components
```

## Demo Credentials

| Role | Email | Password |
|------|-------|----------|
| Student | student@demo.com | 123456 |
| Teacher | teacher@demo.com | 123456 |
| Parent | parent@demo.com | 123456 |
| Admin | admin@demo.com | 123456 |

## License

All curriculum content © Zimbabwe Ministry of Education. App © ZimHeritage Education.
