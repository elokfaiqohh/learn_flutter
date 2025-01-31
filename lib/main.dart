import 'package:flutter/material.dart';

void main() {
  runApp(EcourseApp());
}

class EcourseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: EcourseHome(),
    );
  }
}

class EcourseHome extends StatelessWidget {
  final List<Course> courses = [
    Course("Flutter for Beginners", "Learn the basics of Flutter.", Icons.code, Colors.blue),
    Course("Advanced Flutter", "Dive deeper into Flutter development.", Icons.laptop_mac, Colors.green),
    Course("UI/UX Design", "Design stunning apps with great UI/UX.", Icons.design_services, Colors.orange),
    Course("Backend Development", "Learn backend technologies for apps.", Icons.storage, Colors.purple),
    Course("Data Science Basics", "Start your journey in data science.", Icons.bar_chart, Colors.red),
    Course("AI with Python", "Explore AI and ML using Python.", Icons.smart_toy, Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "E-Course Platform",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getGridCount(screenWidth),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2 / 1,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return _buildCourseCard(context, courses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome to E-Course!",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Explore and enhance your skills with our curated courses.",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: course.iconColor.withOpacity(0.2),
                  child: Icon(course.icon, color: course.iconColor),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    course.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              course.description,
              style: TextStyle(color: Colors.grey[700]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  _showCourseDetails(context, course);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: course.iconColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getGridCount(double screenWidth) {
    if (screenWidth > 1200) return 4; // Desktop dengan layar besar
    if (screenWidth > 800) return 3;  // Tablet
    if (screenWidth > 600) return 2;  // Tablet kecil
    return 1;                          // Mobile
  }

  void _showCourseDetails(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course.title),
        content: Text("Description: ${course.description}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}

class Course {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  Course(this.title, this.description, this.icon, this.iconColor);
}
