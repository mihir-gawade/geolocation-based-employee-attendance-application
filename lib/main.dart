import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}

// Authentication screen for login/signup
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Attendance App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(role: 'employee')),
                );
              },
              child: Text("Employee Login"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(role: 'hr')),
                );
              },
              child: Text("HR Login"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text("Sign Up as HR"),
            ),
          ],
        ),
      ),
    );
  }
}

// Login screen for employee or HR
class LoginScreen extends StatelessWidget {
  final String role;
  LoginScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${role.toUpperCase()} Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (role == 'employee') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeDashboard()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HRDashboard()),
                  );
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// Signup screen for HR
class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HRDashboard()),
                );
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashboard for Employees
class EmployeeDashboard extends StatefulWidget {
  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  DateTime? entryTime;
  DateTime? exitTime;

  void markAttendance() {
    // Get current time
    DateTime now = DateTime.now();

    if (entryTime == null) {
      entryTime = now;
      // Record entry time in the database
      // Send data to central database (e.g., Firebase, etc.)
      print("Attendance marked: Entry at $entryTime");
    } else if (exitTime == null) {
      exitTime = now;
      // Record exit time in the database
      // Send data to central database
      print("Attendance marked: Exit at $exitTime");
    }

    // Mark employee as present or absent based on entry/exit time
    if (entryTime!.isAfter(DateTime(now.year, now.month, now.day, 9, 0))) {
      print("Late entry, marked as absent");
    }
    if (exitTime!.isBefore(DateTime(now.year, now.month, now.day, 17, 0))) {
      print("Leaving early, marked as absent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: markAttendance,
              child: Text(entryTime == null
                  ? "Mark Entry"
                  : (exitTime == null ? "Mark Exit" : "Attendance Recorded")),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to analytics screen (for employee)
              },
              child: Text("View Performance & Appraisal Chances"),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashboard for HR
class HRDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to analytics dashboard for HR
              },
              child: Text("View Analytics & Attendance Data"),
            ),
            ElevatedButton(
              onPressed: () {
                // Fetch analyzed data from central database (using ML models)
              },
              child: Text("Make Informed Decisions"),
            ),
          ],
        ),
      ),
    );
  }
}
