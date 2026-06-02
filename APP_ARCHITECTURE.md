# ZimHeritage Study App — Architecture & Design Guide

## Overview

ZimHeritage is a **Flutter web application** built for the **Zimbabwe Heritage-Based Curriculum**. It serves as an educational platform connecting **students, teachers, parents, and administrators** across all 15 grade levels (ECD A through Form 6). The app supports two modes:

1. **Firebase Mode (online)** — Uses Firebase Auth, Firestore, and Storage for real data persistence.
2. **Offline Mock Mode (default)** — Uses hardcoded static data from `lib/data/` when Firebase is unavailable. Automatically falls back on initialization failure.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x (Dart 3.11+) |
| Platform | Web (Chrome), with Android/iOS/Desktop configs |
| State Management | setState (+ GetIt DI container for shared services) |
| Routing | onGenerateRoute with named routes |
| Data | Firebase Firestore (online) / Hive (offline cache) / hardcoded static classes in `lib/data/` (offline fallback) |
| Backend | Firebase Auth + Firestore + Storage + FCM (optional — app works fully offline) |
| Camera | image_picker package (facial recognition) |
| Error Monitoring | Sentry (optional — configured via .env) |
| Localization | Custom AppLocalizations delegate (en/sn/nd) |
| Accessibility | Material 3 Semantics + accessibility_helper service |
| Persistence | Hive (local cache, session storage, offline support) |
| Styling | Material 3 with custom theme |

---

## Project Structure

```
lib/
├── main.dart                          # Entry point, theme, routing, splash, login, parent & admin dashboards
├── theme/
│   └── app_theme.dart                 # Zimbabwe flag color palette, gradients, shadows, component themes
├── models/                            # Plain Dart data classes
│   ├── user.dart                      # User (id, name, email, role, gradeLevel, school, age)
│   ├── subject.dart                   # Subject + Topic + Subtopic
│   ├── homework.dart                  # Homework + HomeworkQuestion
│   ├── submission.dart                # HomeworkSubmission + Answer
│   ├── progress.dart                  # StudentProgress + TopicProgress + StudentRecord
│   └── answer_key.dart                # AnswerKey + AnswerKeyEntry
├── data/                              # Static data layer (mock backend)
│   ├── sample_data.dart               # 10 homeworks, 6 submissions, 9 progress records, 15 students
│   ├── answer_keys.dart               # Answer keys for all grade/subject combinations
│   └── zimbabwe_curriculum.dart       # Full curriculum: 15 grades, subjects, topics by term
├── l10n/                              # Localization ARB files
│   ├── app_en.arb                     # English translations
│   ├── app_sn.arb                     # chiShona translations
│   └── app_nd.arb                     # isiNdebele translations
├── screens/
│   ├── registration_screen.dart       # 3-step wizard: account → age verify → facial capture
│   ├── student/
│   │   ├── student_dashboard.dart      # Student hub with 5-tab navigation + AI tutor
│   │   ├── subjects_screen.dart        # Subject grid + detail with topics/homework
│   │   ├── view_homework_screen.dart   # Homework list with submission status
│   │   └── progress_screen.dart        # Performance charts per subject
│   └── teacher/
│       ├── teacher_dashboard.dart      # Teacher hub, class overview, answer keys, review/marking
│       └── ai_assistant_screen.dart    # AI chat for lesson planning, strategies, assessments
├── services/                          # Business logic & infrastructure
│   ├── analytics_service.dart         # Engagement analytics (paper-based/online tracking)
│   ├── app_config.dart                # Firebase toggle, feature flags
│   ├── auth_service.dart              # Email/password authentication (online + mock)
│   ├── challenge_service.dart         # Weekly challenges and competitions
│   ├── deep_link_service.dart         # Deep link route resolution
│   ├── di_container.dart              # GetIt dependency injection setup
│   ├── env_config.dart                # .env variable loader (USE_FIREBASE, GEMINI_API_KEY, SENTRY_DSN, APP_LOCALE)
│   ├── heritage_service.dart          # Heritage content CRUD
│   ├── homework_repository.dart       # Homework CRUD operations
│   ├── l10n_service.dart              # Localization delegate + in-memory translations
│   ├── local_persistence_service.dart # Hive-based offline cache + session storage
│   ├── mock_data_service.dart         # Offline mock data provider
│   ├── notification_service.dart      # FCM push notification handler
│   ├── passport_service.dart          # Learner Passport feature
│   ├── payment_service.dart           # Payment / subscription management
│   ├── privacy_service.dart           # GDPR-style data export & deletion
│   ├── progress_repository.dart       # Student progress tracking
│   ├── security_service.dart          # Input sanitization, validation, XSS prevention
│   ├── seeding_service.dart           # Database seeding for new deployments
│   ├── sentry_service.dart            # Sentry error monitoring integration
│   ├── submission_repository.dart     # Homework submission management
│   ├── update_service.dart            # In-app update check + store launcher
│   └── user_repository.dart           # User profile CRUD
└── widgets/                           # Reusable widgets
    ├── ai_reading_assistant.dart       # ECD reading exercise with AI correction + star rewards
    ├── ai_tutor.dart                  # Grade-aware AI tutor for all levels
    ├── nav_bar.dart                   # StudentNavBar (5-tab) + TeacherNavBar (5-tab)
    └── state_widgets.dart             # Reusable LoadingState, ErrorState, EmptyState widgets
```

---

## Routing

The app uses `onGenerateRoute` with named routes:

| Route | Screen | Arguments |
|-------|--------|-----------|
| `/` | `SplashScreen` | Animated 3-second branded splash → auto-navigate to `/login` |
| `/login` | `LoginScreen` | Green gradient background, glass card form |
| `/register` | `RegistrationScreen` | 3-step wizard |
| `/dashboard` | Role-based dashboard | `User` object |

Routes use a **SlideTransition** for smooth page transitions.

---

## New Service Tiers (added post-MVP)

### CI/CD Pipeline (`.github/workflows/ci.yml`)
The project includes a GitHub Actions workflow that runs on every push/PR to `main`:
- **analyze**: `flutter pub get` + `flutter analyze` (lint enforcement)
- **test**: `flutter test` (20+ unit tests)
- **build-web**: `flutter build web` (production web bundle)
- **build-android**: `flutter build apk` (release APK)

### Error Monitoring (`lib/services/sentry_service.dart`)
Optional Sentry integration for crash reporting and performance tracing:
- Initialized in `main.dart` via `SentryFlutter.init()` with 20% traces sample rate
- `captureError()` / `captureMessage()` for manual error reporting
- `setUserContext()` / `clearUserContext()` for user-scoped error context
- Configured via `SENTRY_DSN` in `.env` — silently skipped when empty

### Dependency Injection (`lib/services/di_container.dart`)
Uses `GetIt` for lightweight service location:
- `LocalPersistenceService` — Hive-backed offline cache
- `NotificationService` — FCM push notifications
- Registered as singletons, accessed via `DiContainer.get<T>()`

### Local Persistence (`lib/services/local_persistence_service.dart`)
Hive-based storage for offline caching:
- `saveCache(key, data)` / `getCache(key)` / `clearCache()` — generic JSON cache
- `saveSession(data)` / `getSession()` — authenticated session persistence
- `clearAll()` — full data reset (used by privacy data deletion)

### Push Notifications (`lib/services/notification_service.dart`)
Firebase Cloud Messaging integration:
- Request notification permissions on init
- Route FCM token to user context
- Handle foreground messages via `onMessage` stream
- Background message handler for offline delivery
- Runs as singleton via `DiContainer`

### Localization (`lib/l10n/` + `lib/services/l10n_service.dart`)
Trilingual support for English, chiShona (sn), and isiNdebele (nd):
- ARB files in `lib/l10n/` for each locale
- Custom `AppLocalizations` delegate with in-memory translation maps
- `L10nService.getString(context, key)` for runtime lookups
- `L10nService.supportedLocales` + `localeNames` for language picker
- Language picker UI in Settings screen (bottom sheet selection)

### Accessibility (`lib/services/accessibility_helper.dart`)
Semantic markup helpers for screen reader support:
- `wrapButton()` — `Semantics`-wrapped button with label
- `wrapImage()` — accessible image with description
- `wrapHeader()` — level-appropriate heading semantics
- `wrapTextField()` — labeled input field semantics

### Security (`lib/services/security_service.dart`)
Input sanitization and validation:
- `sanitizeInput()` — HTML-entity encoding (`<`, `>`, `"`, `'`, `&`)
- `isValidEmail()` — regex-based email validation
- `isValidPassword()` — minimum 6 characters
- `isValidName()` — minimum 2 characters, alphabetic + spaces
- `isValidPhoneNumber()` — Zimbabwean phone format check
- `sanitizeFilename()` — removes illegal filesystem characters
- `stripHtml()` — removes all HTML tags from strings
- Applied to registration and login form fields

### Deep Linking (`lib/services/deep_link_service.dart`)
Route resolution for incoming deep links:
- `resolveRoute(path)` — maps path segments to named routes
- `parseQueryParams(query)` — URL-encoded query string parser
- Supported routes: `dashboard`, `login`, `register`, `leaderboard`, `challenges`, `heritage`, `calendar`, `map`, `national-dashboard`, `ministry-dashboard`

### Privacy Compliance (`lib/services/privacy_service.dart`)
GDPR-style data management:
- `exportUserData()` — generates a JSON export of user profile + preferences
- `deleteUserData()` — clears all local persistence (session, cache)
- Accessible from Settings screen as "Export My Data" and "Delete My Data"

### In-App Updates (`lib/services/update_service.dart`)
Version check and store navigation:
- `checkForUpdate()` — reads `package_info_plus` version
- `goToStore()` — opens platform app store listing via `url_launcher`
- Displayed in Settings as current version + "Check for Updates" button

### State Widgets (`lib/widgets/state_widgets.dart`)
Reusable UI patterns for loading/error/empty states:
- `LoadingState(message)` — centered spinner with optional label
- `ErrorState(message, onRetry)` — error icon + message + retry button
- `EmptyState(message)` — empty icon + message
- All widgets include `Semantics` annotations for accessibility

---

## Theme System (`lib/theme/app_theme.dart`)

### Zimbabwe Flag Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Primary Green | `#006B3F` | AppBars, buttons, active states |
| Gold/Yellow | `#FFC72C` | Accents, highlights, badges |
| Red | `#CC0000` | Errors, alerts |
| Dark Green | `#004D2E` | Text, dark backgrounds |
| Light Green | `#E8F5E9` | Success backgrounds |
| Cream | `#FFF8E1` | Warm accent backgrounds |

### Pre-computed White Opacity Values

| Constant | Hex | Opacity |
|----------|-----|---------|
| `white90` | `#E6FFFFFF` | 90% |
| `white85` | `#D9FFFFFF` | 85% |
| `white80` | `#CCFFFFFF` | 80% |
| `white70` | `#B3FFFFFF` | 70% |
| `white60` | `#99FFFFFF` | 60% |
| `white50` | `#80FFFFFF` | 50% |
| `white30` | `#4DFFFFFF` | 30% |
| `white20` | `#33FFFFFF` | 20% |
| `white15` | `#26FFFFFF` | 15% |

### Component Themes

- **AppBar**: Green gradient background via `flexibleSpace`
- **Cards**: White background, 16px border radius, soft shadow, no elevation
- **Buttons**: Green filled, 12px border radius, bold text
- **Inputs**: White filled, 12px border radius, green focus border
- **Bottom nav**: White background, green selected, grey unselected

### Shadow System

- `cardShadow` → `Color(0x14000000)` (8% black), blur 12, offset y 4
- `softShadow` → `Color(0x0D000000)` (5% black), blur 8, offset y 2

---

## Navigation System (`lib/widgets/nav_bar.dart`)

### StudentNavBar
5 tabs: **Home** | **Subjects** | **Homework** | **Progress** | **AI Tutor/Reading**

### TeacherNavBar
5 tabs: **Dashboard** | **Students** | **Keys** | **AI** | **Review**

Features:
- Animated pill-shaped active indicator (green tint background)
- Selected icon turns green, unselected turns grey
- 10px font labels
- SafeArea-aware bottom padding

---

## Screen Architectures

### Splash Screen
- `AnimationController` with 2-second duration
- Three parallel animations:
  - `fadeIn` (0.0-0.6 interval, easeIn curve)
  - `scaleUp` (0.5→1.0, elasticOut curve)
  - `slideUp` (offset 0.3→0, easeOut curve)
- Zimbabwe flag colors: green gradient, gold ring on school icon
- 3-second auto-redirect to login

### Login Screen
- Full-screen `AppTheme.splashGradient`
- Semi-transparent white card with `clipBehavior`
- Demo chips with `ActionChip` and green border
- Loading state with `CircularProgressIndicator`
- Error state with red alert box

### Student Dashboard
- Uses `AnimatedSwitcher` for tab transitions
- 5th tab adapts based on grade level:
  - **ECD** → `AIReadingAssistant` (reading exercises)
  - **All other grades** → `AITutor` (chat-based tutoring)
- Welcome card with time-based greeting (sun/cloud/moon icons)
- School name + grade level badge in AppBar
- Gold AI promotional card on overview page

### Teacher Dashboard
- Stats cards with metric labels
- Quick action grid (2×2)
- Recent submissions feed
- All child screens rebuilt with theme consistency

### Parent Dashboard
- Welcome card with family icon
- Child cards with animated progress bars
- School updates feed (homework, reviews, events)

### Admin Dashboard
- 4 metric cards with status badges
- Curriculum overview section
- Grade-level items with badge labels (ECD/PRI/O/A)

---

## AI Features

### AI Reading Assistant (ECD Only)
**Purpose**: Help ECD children learn to read with simulated AI feedback.

**How it works**:
1. A sentence is displayed (e.g. "The cat sat on the mat.")
2. Child types what they read into a text field
3. User presses "Start Reading" (simulates voice detection)
4. AI compares typed text against the correct sentence
5. **On success**: Celebration message + star reward (every 3rd correct answer)
6. **On error**: Specific correction showing which words are wrong
7. Next button cycles through 8 graded exercises

**Features**:
- Star counter in header
- Exercise counter (1/8)
- Age-appropriate content (ECD A / ECD B tagged)
- Animated microphone button with pulse effect
- Color-coded response cards (green for success, gold for needs work)

### AI Tutor (All Grades)
**Purpose**: Provide personalized learning assistance for any subject and level.

**How it works**:
1. User selects subject and difficulty from dropdowns
2. Types a question or request in the chat input
3. AI processes the query based on keyword detection:
   - **"explain"** → grade-appropriate explanation (ECD: simple/visual, Primary: step-by-step, Secondary: analytical)
   - **"practice"** → generates questions at selected difficulty
   - **"check/feedback"** → activates feedback mode
   - **"help/stuck"** → encouragement + scaffolding strategies
   - **general** → overview of capabilities
4. Response shown with formatted markdown (bold headers, italic tips, bullet lists)

**Grade Awareness**:
- **ECD**: Focus on hands-on, visual, verbal learning
- **Primary (Grades 1-7)**: Step-by-step with real-world Zimbabwe examples
- **Secondary (Forms 1-6)**: Analytical thinking, heritage connections

### AI Teaching Assistant (Teacher)
**Purpose**: Help teachers plan lessons, create assessments, and improve instruction.

**7 response types**:
1. Lesson plan guidance (5-part structure)
2. Teaching strategies (questioning, scaffolding, heritage-based)
3. Practice questions (Easy/Medium/Hard/Mixed)
4. Curriculum guidance (heritage-based, competency-based, cross-cutting)
5. Assessment guidance (rubrics, formative, feedback methods)
6. Homework design (purposeful practice, varied formats)
7. Differentiation (struggling, advanced, all learners)

**Question Designer Dialog**:
- Subject, grade level, difficulty dropdowns
- Topic text input
- Generates a contextualized request to the AI

---

## Data Flow

```
User Action → Screen (setState) → Repository → Firebase Firestore (online) / MockDataService (offline) → UI Update
```

The app uses `AppConfig.useFirebase` (in `lib/services/app_config.dart`) to toggle between modes:

- **Online**: Repositories call Firebase Firestore via `cloud_firestore` package.
- **Offline**: Repositories delegate to `MockDataService` which wraps the static data classes.

Static data sources:
- `lib/data/zimbabwe_curriculum.dart` → 15 grades, subjects, topics with subtopics by term
- `lib/data/sample_data.dart` → 10 homeworks, 6 submissions, 9 progress records, 15 student records
- `lib/data/answer_keys.dart` → Answer keys for ~20 subject/grade combinations

Offline fallback data access:
```dart
MockDataService.getHomeworksByGrade('Form 1');
MockDataService.getProgressForStudent('student_1');
MockDataService.getSubjectsForGradeSync('Grade 3');
MockDataService.getAnswerKeysForGradeSync('ECD A');
```

---

## User Roles & Demo Credentials

| Role | Email | Password | Grade Level | Features |
|------|-------|----------|-------------|----------|
| Student | `student@demo.com` | `123456` | Form 1 | Dashboard, Subjects, Homework, Progress, AI Tutor |
| Teacher | `teacher@demo.com` | `123456` | N/A | Dashboard, Students, Answer Keys, AI Assistant, Review |
| Parent | `parent@demo.com` | `123456` | N/A | View children's progress |
| Admin | `admin@demo.com` | `123456` | N/A | Platform metrics, curriculum overview |

---

## Switching Between Online and Offline Mode

The app auto-detects Firebase availability on startup (`lib/main.dart`). To force offline mode:

```dart
// In lib/services/app_config.dart
class AppConfig {
  static bool useFirebase = false; // Set to true to force Firebase mode
}
```

### Demo Credentials (Offline Mode)

| Role | Email | Password |
|------|-------|----------|
| Student | `student@demo.com` | `123456` |
| Teacher | `teacher@demo.com` | `123456` |
| Parent | `parent@demo.com` | `123456` |
| Admin | `admin@demo.com` | `123456` |

### Adding Real Backend Data

To fully connect to Firebase:

1. Run `flutterfire configure` against your Firebase project
2. Enable Email/Password authentication in Firebase Console
3. Create Firestore collections: `users`, `homeworks`, `submissions`, `progress`, `curriculum`, `subjects`, `answer_keys`
4. Set `AppConfig.useFirebase = true`

---

## Build & Run Commands

```bash
# Development (Chrome)
flutter run -d chrome

# Production build
flutter build web

# Run built version
start build\web\index.html

# Analyze code
flutter analyze

# Run tests
flutter test

# Available batch files
run_dev.bat          # dart pub audit + flutter analyze + flutter run -d chrome
run_tests.bat        # dart pub audit + flutter analyze + flutter test
deploy.bat           # dart pub audit + flutter analyze + flutter test + flutter build web
run_offline.bat      # opens build/web/index.html
```

---

## Visual Identity Standards

| Element | Style |
|---------|-------|
| Border Radius (cards) | 16px |
| Border Radius (buttons) | 12px |
| Border Radius (inputs) | 12px |
| Card shadow | `cardShadow` (8% black, 12px blur) |
| Button style | Filled green, bold white text |
| AppBar | Green gradient, centered title |
| Background | `#F5F5F5` (grey light) |
| Success state | Light green background + green border |
| Error state | Red background + red border |
| Loading state | Circular progress indicator |

---

## AI Disclaimer

All AI responses in this demo are **simulated** using pre-written template responses. They are triggered by keyword matching and do not use actual machine learning or API calls. To integrate real AI:

- **OpenAI API**: Connect to GPT-4/3.5 for natural language tutoring
- **Google Cloud Speech-to-Text**: For actual voice reading recognition in ECD mode
- **Custom ML model**: Train on Zimbabwe curriculum data for context-aware responses
