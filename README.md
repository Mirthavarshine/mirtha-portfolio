# Mirthavarshine RP - Flutter Portfolio

A beautiful, responsive Flutter web portfolio showcasing the skills, projects, and experience of Mirthavarshine RP.

## 🌟 Features

### Design & UI
- **Modern Design**: Clean and professional layout with Deep Teal & Soft Mint color theme
- **Responsive**: Fully responsive design that works on all devices
- **Smooth Animations**: Fade-in, slide-up, and hover animations throughout
- **Interactive Elements**: Hover effects, smooth scrolling, and dynamic interactions

### Sections
- **Hero Section**: Eye-catching introduction with profile image and animated text
- **About Section**: Personal information with career objective and download resume
- **Skills Section**: Horizontal scrolling skill badges for all technologies
- **Projects Section**: Horizontal scrolling project cards with detailed popups
- **Experience Section**: Timeline view of work experience
- **Certificates Section**: Carousel displaying certificates and achievements
- **Education Section**: Academic background and achievements
- **Achievements Section**: Recognition and awards
- **Contact Section**: Contact form with social media links

### Functionality
- **Sticky Navigation**: Fixed navigation bar with smooth scrolling
- **Mobile Menu**: Hamburger menu for mobile devices
- **Contact Form**: Functional form with validation (Firebase ready)
- **Social Links**: Direct links to email, phone, and LinkedIn
- **Project Details**: Interactive popup modals for project information
- **Certificate Viewer**: Full-screen certificate viewing

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Web browser for testing

### Installation
1. Clone or download the project files
2. Navigate to the project directory: `cd flutter_portfolio`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run -d chrome`

### File Structure
```
flutter_portfolio/
├── lib/
│   ├── main.dart                 # Main app entry point
│   ├── screens/
│   │   └── home_screen.dart      # Main screen with all sections
│   └── widgets/
│       ├── navigation_bar.dart   # Navigation component
│       ├── hero_section.dart     # Hero section
│       ├── about_section.dart    # About section
│       ├── skills_section.dart   # Skills section
│       ├── projects_section.dart # Projects section
│       ├── experience_section.dart # Experience section
│       ├── certificates_section.dart # Certificates section
│       ├── education_section.dart # Education section
│       ├── achievements_section.dart # Achievements section
│       └── contact_section.dart  # Contact section
├── assets/
│   ├── mirtha_photo.jpg         # Profile photo
│   ├── certificate_accenture.jpg # Accenture certificate
│   └── certificate_nptel.jpg    # NPTEL certificate
├── pubspec.yaml                 # Dependencies and assets
└── README.md                    # Project documentation
```

## 🎨 Customization

### Personal Information
Update the following in the respective widget files:
- Profile information in `hero_section.dart`
- About content in `about_section.dart`
- Skills list in `skills_section.dart`
- Project details in `projects_section.dart`
- Experience details in `experience_section.dart`
- Contact information in `contact_section.dart`

### Colors
The color scheme is defined in `main.dart`:
```dart
Color(0xFF014D4E), // Deep Teal - Primary
Color(0xFFA7C4BC), // Soft Mint - Secondary
Color(0xFFFFFFFF), // Pure White - Background
Color(0xFF4F4F4F), // Warm Gray - Accent
```

### Assets
Add your images to the `assets/` folder and update `pubspec.yaml`:
```yaml
assets:
  - assets/your_image.jpg
```

## 📱 Responsive Design

The portfolio is fully responsive and includes:
- **Desktop**: Full layout with side-by-side sections
- **Tablet**: Adjusted layouts and spacing
- **Mobile**: Single-column layout with hamburger menu

### Breakpoints
- Mobile: < 768px
- Desktop: > 768px

## 🔧 Technical Details

### Technologies Used
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Google Fonts**: Poppins and Inter font families
- **Flutter Staggered Animations**: Smooth animations
- **Carousel Slider**: Certificate carousel
- **URL Launcher**: Social media links

### Key Features
- **Material Design**: Modern UI components
- **Custom Animations**: Staggered and fade animations
- **Form Validation**: Client-side validation
- **Responsive Layout**: Adaptive design
- **Interactive Elements**: Hover effects and transitions

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0
  flutter_staggered_animations: ^1.1.1
  carousel_slider: ^4.2.1
  url_launcher: ^6.2.2
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
```

## 📧 Contact Form

The contact form includes:
- **Validation**: Required fields and email format validation
- **Firebase Ready**: Prepared for Firebase integration
- **Success Messages**: User feedback on submission

To implement actual Firebase functionality:
1. Set up Firebase project
2. Add Firebase configuration
3. Replace form submission logic in `contact_section.dart`

## 🎯 Performance

- **Optimized Images**: Efficient image loading
- **Minimal Dependencies**: Only essential packages
- **Efficient Animations**: Hardware-accelerated animations
- **Lazy Loading**: Scroll-based content loading

## 🚀 Deployment

### Firebase Hosting
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login to Firebase: `firebase login`
3. Initialize Firebase: `firebase init hosting`
4. Build the app: `flutter build web`
5. Deploy: `firebase deploy`

### Other Platforms
- **Netlify**: Connect to GitHub repository
- **Vercel**: Import Flutter web project
- **GitHub Pages**: Deploy from GitHub Actions

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Feel free to fork this project and customize it for your own portfolio!

## 📞 Support

If you have any questions or need help customizing the portfolio, feel free to reach out!

---

**Built with ❤️ by Mirthavarshine RP**
*Final Year CSE Student & Software Developer*
