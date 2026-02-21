<div align="center">

# Anxiety & Mental Wellness App

[![React Native](https://img.shields.io/badge/React_Native-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)](https://reactnative.dev)
[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://typescriptlang.org)
[![Expo](https://img.shields.io/badge/Expo-000020?style=for-the-badge&logo=expo&logoColor=white)](https://expo.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> A cross-platform mobile application for anxiety management — featuring physiological tremor detection, haptic-guided breathing exercises, and longitudinal anxiety tracking.

</div>

---

## Overview

Mental wellness apps often rely on self-reporting and generic advice. This app goes further by using the device's hardware — accelerometer sensors and haptic motors — to deliver real physiological feedback. Users can detect anxiety-linked tremors, practice breathing with tactile guidance, and track their anxiety patterns over time.

Built in React Native with TypeScript for type safety and cross-platform deployment on both iOS and Android.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                       Screen Layer                          │
│  HomeScreen · BreathingScreen · TrackerScreen · HistoryScreen│
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                    Feature Modules                          │
│                                                             │
│  TremorDetector          BreathingGuide       AnxietyLogger │
│  ─────────────           ─────────────────    ────────────  │
│  Accelerometer API       Haptics API          AsyncStorage  │
│  Signal processing       Session config       Local DB      │
│  Threshold alerts        Phase timing         Chart data    │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│               Device Hardware / Native APIs                 │
│  Accelerometer · Haptic Engine · Local Storage              │
└─────────────────────────────────────────────────────────────┘
```

---

## Key Features

### Tremor Detection
- Uses the device accelerometer to measure hand movement frequency and amplitude
- Applies signal processing to distinguish anxiety-linked fine motor tremors from general movement
- Alerts the user when tremor patterns exceed configurable thresholds

### Haptic-Guided Breathing
- Structured breathing sessions (e.g., 4-7-8, box breathing) guided by haptic pulses
- The phone vibrates at the start and end of each inhale/hold/exhale phase — no need to look at the screen
- Session duration and breathing pattern are fully configurable

### Anxiety Tracker
- Log anxiety levels (1–10) with optional notes and timestamps
- Visualise trends over days and weeks with charts
- Identify correlations between tremor data and self-reported anxiety

---

## Tech Stack

| Component | Technology |
|---|---|
| Framework | React Native |
| Language | TypeScript |
| Build System | Expo |
| Sensor Access | expo-sensors (Accelerometer) |
| Haptic Feedback | expo-haptics |
| Local Storage | AsyncStorage / SQLite |
| Navigation | React Navigation |
| Charts | react-native-chart-kit |

---

## Getting Started

```bash
# Clone the repo
git clone https://github.com/Ghost-tech-ng/Anxiety-app.git
cd Anxiety-app

# Install dependencies
npm install

# Start the Expo development server
npx expo start
```

Scan the QR code with the **Expo Go** app on your phone, or run in a simulator:

```bash
npx expo run:ios     # iOS simulator
npx expo run:android # Android emulator
```

---

## Project Structure

```
Anxiety-app/
├── app/
│   ├── (tabs)/
│   │   ├── index.tsx          # Home screen
│   │   ├── breathing.tsx      # Breathing guide
│   │   ├── tracker.tsx        # Anxiety logger
│   │   └── history.tsx        # Trend charts
│   └── _layout.tsx
├── components/
│   ├── TremorDetector.tsx     # Accelerometer integration
│   ├── BreathingGuide.tsx     # Haptic session controller
│   └── AnxietyChart.tsx       # Trend visualisation
├── hooks/
│   └── useAccelerometer.ts    # Sensor data hook
└── utils/
    └── storage.ts             # AsyncStorage helpers
```

---

## Author

**Eghosa Osemwegie** — [GitHub](https://github.com/Ghost-tech-ng) · [Portfolio](http://www.eghosa.tech) · [Email](mailto:osemwegiee@gmail.com)
