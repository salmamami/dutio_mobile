
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({super.key});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Menyapu lantai kamar mandi',
      'done': false,
    },
    {
      'title': 'Membersihkan wastafel',
      'done': false,
    },
    {
      'title': 'Mengepel lantai',
      'done': false,
    },
    {
      'title': 'Menguras bak mandi',
      'done': false,
    },
  ];

  int get completedTasks =>
      tasks.where((task) => task['done'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppTheme.dark,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                          child: Text(
                            'Mission Cleaning',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkGreen,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.eco_outlined,
                          color: AppTheme.darkGreen,
                          size: 27,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // HERO SECTION
                    Container(
                      height: 165,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EEDC),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Positioned(
                            left: 18,
                            top: 18,
                            child: Icon(
                              Icons.assignment_outlined,
                              color: AppTheme.darkGreen,
                              size: 35,
                            ),
                          ),
                          const Positioned(
                            right: 20,
                            top: 15,
                            child: Icon(
                              Icons.lightbulb,
                              color: Color(0xFFE7B849),
                              size: 32,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '🧹',
                                style: TextStyle(fontSize: 55),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Let’s complete our mission!',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkGreen,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PROGRESS CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.sage,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: _progressItem(
                                  'Total Task',
                                  '${tasks.length}',
                                  Icons.checklist,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _progressItem(
                                  'Done',
                                  '$completedTasks',
                                  Icons.task_alt,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _progressItem(
                                  'Not Completed',
                                  '${tasks.length - completedTasks}',
                                  Icons.pending_actions,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: completedTasks / tasks.length,
                              minHeight: 8,
                              backgroundColor: Colors.white54,
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                AppTheme.darkGreen,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '${((completedTasks / tasks.length) * 100).toInt()}% Completed',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TASK TITLE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cleaning Tasks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkGreen,
                          ),
                        ),
                        Text(
                          '$completedTasks/${tasks.length} Done',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.sage,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // TASK LIST
                    ...List.generate(tasks.length, (index) {
                      final task = tasks[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CheckboxListTile(
                          value: task['done'],
                          onChanged: (value) {
                            setState(() {
                              tasks[index]['done'] = value ?? false;
                            });
                          },
                          activeColor: AppTheme.darkGreen,
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Text(
                            task['title'],
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.dark,
                              fontWeight: FontWeight.w500,
                              decoration: task['done']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          controlAffinity:
                              ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // BOTTOM NAVIGATION
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                  ),
                  _NavItem(
                    icon: Icons.check_circle_outline,
                    label: 'Mission',
                    active: true,
                  ),
                  _NavItem(
                    icon: Icons.emoji_events_outlined,
                    label: 'Points',
                  ),
                  _NavItem(
                    icon: Icons.person_outline,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressItem(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.darkGreen, size: 19),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9,
              color: AppTheme.dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 23,
          color: active ? AppTheme.darkGreen : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: active ? AppTheme.darkGreen : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
