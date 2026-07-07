# 📝 Todo App

A modern, clean, and offline-first Todo application built with **Flutter**, following **Clean Architecture** principles and powered by **Riverpod** for state management and **Hive** for local persistence.

The application is designed to provide a smooth task management experience while maintaining a scalable and maintainable project structure.

---

## 📱 Features

### ✅ Task Management
- Create new tasks
- Edit existing tasks
- Delete tasks
- Mark tasks as completed
- Restore completed tasks
- View task details
- Set task priority
- Add task description
- Assign due dates
- Categorize tasks

---

### 📂 Category Management
- Create custom categories
- Delete categories
- Choose custom colors for each category
- Display category badges across the application

---

### ✅ Completed Tasks
- Dedicated screen for completed tasks
- Automatically updates when tasks are completed or restored
- Keeps active and completed tasks separated

---

### 🎨 User Experience
- Material 3 Design
- Light Theme
- Dark Theme
- Responsive layouts
- Smooth page transitions
- Animated Checkbox
- Interactive Bottom Navigation
- Custom Priority Badges
- Date Picker
- Color Picker for Categories
- Popup Menus
- Modal Bottom Sheets

---

### 💾 Local Storage
- Offline-first architecture
- Persistent local database using Hive
- Automatic data restoration after application restart
- Type-safe Hive adapters
- Fast local CRUD operations

---

## 🏗 Architecture

The project follows **Clean Architecture**, separating responsibilities into independent layers.

```
lib/
│
├── core/
├── config/
├── services/
├── shared/
│
└── features/
    ├── tasks/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── categories/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── done/
    ├── navigation/
    └── settings/
```

---

## 🛠 Tech Stack

### Framework
- Flutter

### Language
- Dart

### State Management
- Riverpod

### Local Database
- Hive
- Hive Generator

### Dependency Injection
- Riverpod Providers

### Navigation
- Navigator 2.0 (Named Routes)

### Code Generation
- build_runner

### Unique IDs
- uuid

### Date Formatting
- intl

---

## 📦 Packages Used

```yaml
flutter_riverpod
hive
hive_flutter
hive_generator
build_runner
uuid
intl
provider
```

---

## 🧩 Custom Widgets

The application includes several reusable widgets:

- TaskCard
- AnimatedCheckbox
- PriorityBadge
- CategoryChip
- DatePickerField
- AppScaffold
- AppSliverScaffold
- Navigation Items
- TaskForm

---

## 🚀 Implemented Functionalities

### Tasks

- ✔ Create Task
- ✔ Update Task
- ✔ Delete Task
- ✔ Complete Task
- ✔ Restore Task
- ✔ View Task Details
- ✔ Assign Priority
- ✔ Assign Category
- ✔ Assign Due Date

---

### Categories

- ✔ Create Category
- ✔ Delete Category
- ✔ Custom Color Selection
- ✔ Category Persistence

---

### Done

- ✔ Display Completed Tasks
- ✔ Restore Completed Tasks

---

### Persistence

- ✔ Hive Database
- ✔ Automatic Data Loading
- ✔ Generated Hive Adapters
- ✔ Offline Support

---

### UI

- ✔ Material 3
- ✔ Bottom Navigation
- ✔ Modal Bottom Sheets
- ✔ Popup Menus
- ✔ Theme Support
- ✔ Animations
- ✔ Responsive Layout

---

## 📂 Data Flow

```
UI
 ↓
Riverpod Providers
 ↓
Use Cases
 ↓
Repository
 ↓
Local Data Source
 ↓
Hive Database
```

---

## 📸 Screens

- Home
- Add Task
- Edit Task
- Task Details
- Categories
- Completed Tasks
- Settings
- Search

---

## 🔄 State Management

Riverpod is used throughout the application to manage:

- Tasks Stream
- Categories Stream
- Theme Mode
- CRUD Operations
- UI Updates

---

## 💡 Future Improvements

- Search tasks
- Advanced filtering
- Sorting options
- Category editing
- Swipe actions
- Notifications
- Recurring tasks
- Statistics Dashboard
- Backup & Restore
- Cloud synchronization
- Authentication
- Multiple workspaces

---

## 📖 Learning Objectives

This project was built to practice:

- Flutter Development
- Clean Architecture
- Riverpod
- Hive Database
- Repository Pattern
- SOLID Principles
- State Management
- Local Persistence
- Modular Project Structure
- Reusable Widgets

---

## 👨‍💻 Author

**John George**

Computer Engineering Student

Flutter Developer | Front-End Developer

---

## ⭐ If you like this project

Give it a ⭐ on GitHub and feel free to contribute or share your feedback.