# 📝 Flutter Todo App

A complete Todo App built with Flutter that demonstrates task management, local data persistence, navigation, asynchronous programming, and reusable widget design.

---

# 🚀 Features

## Core Functionality

✅ Add a new task using a TextField and button

✅ Display all tasks using `ListView.builder`

✅ Mark tasks as complete/incomplete by tapping on them

✅ Delete tasks using swipe-to-delete (`Dismissible`) or delete icon

✅ Confirmation dialog before deleting a task

✅ Undo deleted tasks using `SnackBar`

✅ Persist tasks using `SharedPreferences`

✅ Tasks remain available after app restart

---

## Navigation

Uses a `BottomNavigationBar` with three tabs:

### 📋 All Tasks

Displays every task.

### ⏳ Pending Tasks

Displays only incomplete tasks.

### ✅ Completed Tasks

Displays only completed tasks.

---

## FutureBuilder

On application startup:

* Loads saved tasks from `SharedPreferences`
* Displays a loading spinner while data is loading
* Automatically renders the UI when data becomes available

---




---

# 📂 Project Structure

```text
lib/
├── main.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── all_tasks_screen.dart
│   ├── pending_tasks_screen.dart
│   └── completed_tasks_screen.dart
│
├── widgets/
│   ├── task_tile.dart
│   └── empty_state.dart
│
└── services/
    └── storage_service.dart
```

---

# 📖 Folder Responsibilities

## screens/

Contains all application screens.

### home_screen.dart

* Main screen of the application
* Hosts the BottomNavigationBar
* Controls navigation between tabs

### all_tasks_screen.dart

* Displays all tasks
* Supports task completion and deletion

### pending_tasks_screen.dart

* Displays only pending tasks
* Filters tasks where completion status is false

### completed_tasks_screen.dart

* Displays only completed tasks
* Filters tasks where completion status is true

---

## widgets/

Contains reusable UI components.

### task_tile.dart

Reusable task widget responsible for:

* Showing task title
* Toggle complete/incomplete state
* Delete action
* Swipe-to-delete functionality

### empty_state.dart

Reusable widget displayed when:

* No tasks exist
* No pending tasks exist
* No completed tasks exist

---

## services/

Contains business logic and local storage management.

### storage_service.dart

Handles:

* Saving tasks
* Loading tasks
* Updating tasks
* Deleting tasks
* SharedPreferences operations

---

# 🛠 Dependencies

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter

  shared_preferences: ^2.2.3
```

Install dependencies:

```bash
flutter pub get
```

---

# ▶️ Getting Started

## Clone the Repository

```bash
git clone <repository-url>
```

## Navigate to Project Folder

```bash
cd todo_app
```

## Install Dependencies

```bash
flutter pub get
```

## Run the Application

```bash
flutter run
```

---

# 📱 Screen Overview

## Home Screen

Contains:

* AppBar
* BottomNavigationBar
* Navigation logic

---

## All Tasks Screen

Features:

* Display all tasks
* Add tasks
* Toggle completion
* Delete tasks
* Pull-to-refresh

---

## Pending Tasks Screen

Features:

* Display incomplete tasks only
* Automatically updates when tasks are completed
* Supports deletion and refresh

---

## Completed Tasks Screen

Features:

* Display completed tasks only
* Automatically updates when tasks are marked incomplete
* Supports deletion and refresh

---

# 🔄 Application Workflow

1. App launches.
2. FutureBuilder loads tasks from SharedPreferences.
3. Loading spinner is shown.
4. Tasks are displayed after loading.
5. User adds a task.
6. Task is saved locally.
7. User marks task complete/incomplete.
8. Task state updates instantly.
9. User deletes a task.
10. Confirmation dialog appears.
11. Task is deleted.
12. SnackBar provides Undo option.
13. All changes are saved automatically.

---

# 🧠 Flutter Concepts Covered

This project demonstrates:

* StatefulWidget
* ListView.builder
* BottomNavigationBar
* FutureBuilder
* SharedPreferences
* AlertDialog
* SnackBar
* Dismissible
* RefreshIndicator
* Local Storage
* Reusable Widgets
* Navigation
* State Management
* Asynchronous Programming




