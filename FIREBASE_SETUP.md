# Firebase Setup Guide for Contact Form

## 🔥 Firebase Project Setup

### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `mirtha-portfolio` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

### Step 2: Add Web App to Firebase
1. In your Firebase project, click the web icon (</>) to add a web app
2. Register app with nickname: `portfolio-web`
3. Copy the Firebase configuration object

### Step 3: Update Configuration Files

#### Update `lib/config/firebase_config.dart`:
```dart
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: "your-actual-api-key",
    authDomain: "your-project-id.firebaseapp.com",
    projectId: "your-project-id",
    storageBucket: "your-project-id.appspot.com",
    messagingSenderId: "your-messaging-sender-id",
    appId: "your-app-id",
  );
}
```

#### Update `web/index.html`:
```javascript
const firebaseConfig = {
  apiKey: "your-actual-api-key",
  authDomain: "your-project-id.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "your-messaging-sender-id",
  appId: "your-app-id"
};
```

### Step 4: Enable Firestore Database
1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location close to your users
5. Click "Done"

### Step 5: Set Up Firestore Security Rules
1. In Firestore Database, go to "Rules" tab
2. Update the rules to allow write access for contact form:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow anyone to write to contactMessages collection
    match /contactMessages/{document} {
      allow write: if true;
      allow read: if false; // Only allow writes, not reads for security
    }
  }
}
```

## 🚀 Testing the Contact Form

### Local Testing
1. Run the app: `flutter run -d chrome`
2. Navigate to the Contact section
3. Fill out the form with test data
4. Submit the form
5. Check Firebase Console > Firestore Database for the new document

### Expected Behavior
- ✅ Form validation works (name ≥3 chars, valid email, message ≥10 chars)
- ✅ Submit button is disabled until all fields are valid
- ✅ Success message appears on successful submission
- ✅ Form clears after successful submission
- ✅ Error message appears if Firebase write fails
- ✅ Social links open correctly in new tabs/apps

## 📊 Monitoring Contact Messages

### View Messages in Firebase Console
1. Go to Firebase Console > Firestore Database
2. You'll see a `contactMessages` collection
3. Each message will have:
   - `name`: Sender's name
   - `email`: Sender's email
   - `message`: The message content
   - `timestamp`: When the message was sent
   - `status`: Message status (default: "new")

### Message Structure
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "message": "Hi Mirtha, I'd like to discuss a project opportunity...",
  "timestamp": "2025-01-12T10:30:00Z",
  "status": "new"
}
```

## 🔒 Security Considerations

### Production Security Rules
For production, update Firestore rules to be more restrictive:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /contactMessages/{document} {
      // Allow writes only if the document doesn't exist (new messages)
      allow create: if true;
      // Allow reads only for authenticated admin users
      allow read: if request.auth != null && request.auth.token.admin == true;
      // No updates or deletes allowed
      allow update, delete: if false;
    }
  }
}
```

### Rate Limiting
Consider implementing rate limiting to prevent spam:
- Limit messages per email address per hour
- Add CAPTCHA for additional protection
- Monitor for suspicious activity

## 🛠️ Troubleshooting

### Common Issues

#### 1. Firebase Not Initialized
**Error**: `Firebase is not initialized`
**Solution**: Ensure Firebase is initialized in `main.dart` before running the app

#### 2. Permission Denied
**Error**: `Permission denied`
**Solution**: Check Firestore security rules and ensure they allow writes

#### 3. Network Error
**Error**: `Network error occurred`
**Solution**: Check internet connection and Firebase project configuration

#### 4. Invalid API Key
**Error**: `Invalid API key`
**Solution**: Verify the API key in both `firebase_config.dart` and `index.html`

### Debug Steps
1. Check browser console for JavaScript errors
2. Verify Firebase configuration values
3. Test Firestore rules in Firebase Console
4. Check network tab for failed requests

## 📱 Deployment Checklist

Before deploying to production:

- [ ] Update Firebase configuration with production values
- [ ] Set up proper Firestore security rules
- [ ] Test contact form thoroughly
- [ ] Verify social links work correctly
- [ ] Check form validation on mobile devices
- [ ] Test error handling scenarios
- [ ] Monitor Firebase usage and costs

## 💡 Additional Features

### Future Enhancements
1. **Email Notifications**: Set up Firebase Functions to send email notifications
2. **Admin Dashboard**: Create a simple admin panel to view messages
3. **Message Status**: Add read/unread status tracking
4. **Spam Protection**: Implement CAPTCHA or other anti-spam measures
5. **Analytics**: Track form submissions and user interactions

### Email Notifications Setup
To receive email notifications when someone submits the contact form:

1. Set up Firebase Functions
2. Create a function that triggers on new Firestore documents
3. Use a service like SendGrid or Nodemailer to send emails
4. Configure the function to send emails to your address

Your contact form is now fully functional with Firebase integration! 🎉 