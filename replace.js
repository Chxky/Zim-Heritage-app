const fs = require('fs');
const path = require('path');

const baseDir = r'c:\Users\User\Desktop\zim heritage app\lib';
const files = [
    'main.dart',
    'theme/app_theme.dart',
    'widgets/glass_card.dart',
    'widgets/nav_bar.dart',
    'widgets/edu_drawer.dart',
    'widgets/ai_tutor.dart',
    'widgets/ai_reading_assistant.dart',
    'screens/admin_user_management_screen.dart',
    'screens/parent_child_detail_screen.dart',
    'screens/notifications_screen.dart',
    'screens/forgot_password_screen.dart',
    'screens/registration_screen.dart',
    'screens/settings_screen.dart',
    'screens/student/student_dashboard.dart',
    'screens/student/view_homework_screen.dart',
    'screens/student/submit_homework_screen.dart',
    'screens/student/subjects_screen.dart',
    'screens/student/progress_screen.dart',
    'screens/teacher/teacher_dashboard.dart',
    'screens/teacher/homework_create_screen.dart',
    'screens/teacher/ai_assistant_screen.dart'
];

let successCount = 0;
let filesModified = [];

files.forEach(file => {
    const filePath = path.join(baseDir, file);
    
    if (fs.existsSync(filePath)) {
        const content = fs.readFileSync(filePath, 'utf-8');
        const originalContent = content;
        
        // Replace .withValues(alpha: with .withOpacity(
        const newContent = content.replace(/\.withValues\(alpha:\s*/g, '.withOpacity(');
        
        // Write back if changed
        if (newContent !== originalContent) {
            fs.writeFileSync(filePath, newContent, 'utf-8');
            successCount++;
            filesModified.push(file);
            console.log('OK: Modified ' + file);
        } else {
            console.log('OK: No changes in ' + file);
        }
    } else {
        console.log('ERROR: Not found ' + file);
    }
});

console.log('');
console.log('Summary: Modified ' + successCount + ' files');
if (filesModified.length > 0) {
    console.log('\nModified files:');
    filesModified.forEach(f => console.log('  - ' + f));
}
