import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AcademicDetailsSetupScreen extends StatefulWidget {
  const AcademicDetailsSetupScreen({super.key});

  @override
  State<AcademicDetailsSetupScreen> createState() =>
      _AcademicDetailsSetupScreenState();
}

class _AcademicDetailsSetupScreenState
    extends State<AcademicDetailsSetupScreen> {
  // Supabase Database
  final _supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> currentStateData;

  // Current step index
  int currentIndex = 0;

  // Selected values
  int? selectedSemester;
  String? selectedDepartment;
  String? selectedSection;

  // Available options
  late List<int> semesters; // from 1 to 8. not all semesters are running all the time
  late List<String> departments; // CSE DSAI and ECE (fetching from db for future proof)
  List<String> sections = ['A', 'B'];

  @override
  void initState() {
    super.initState();
    currentStateData = _fetchCurrentStateData();
    _loadSavedData();
  }

  // Load data from SharedPreferences
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // selectedSemester = prefs.getInt('semester');
      // selectedDepartment = prefs.getString('department');
      // selectedSection = prefs.getString('section');

      // Determine which step to start on based on saved data
      if (selectedSemester != null) {
        currentIndex = 1; // Move to department selection
        if (selectedDepartment != null) {
          currentIndex =
              selectedDepartment == 'CSE'
                  ? 2
                  : 3; // Move to section or completion
        }
      }
    });
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    if (selectedSemester != null) {
      await prefs.setInt('semester', selectedSemester!);
    }

    if (selectedDepartment != null) {
      await prefs.setString('department', selectedDepartment!);
    }

    if (selectedSection != null) {
      await prefs.setString('section', selectedSection!);
    }
  }

  void _moveToNextStep() async {
    await _saveData();

    setState(() {
      if (currentIndex == 1 && selectedDepartment != 'CSE') {
        // Skip section selection if department is not CSE
        currentIndex = 3;
      } else {
        currentIndex++;
      }
    });
  }

  void _moveToPreviousStep() {
    setState(() {
      if (currentIndex == 3 && selectedDepartment != 'CSE') {
        // Skip section selection if coming back from the final screen
        currentIndex = 1;
      } else {
        currentIndex--;
      }
    });
  }

  Future<List<Map<String, dynamic>>> _fetchCurrentStateData() async {
    try {
      final response = await _supabase.from('current_state').select();

      debugPrint('DEV: Supabase `current_state` data fetch SUCCESSFUL');
      return response;
    } catch (e) {
      debugPrint('DEV: Error fetching `current_state` from Supabase: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentStateData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(child: Text("let's setup your academics!")),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          var data = snapshot.data.toString();
          return Scaffold(
            body: Center(
              child: Row(children: [Text('No data found'), Text(data)]),
            ),
          );
        }

        // Convert list of maps to key-value map
        final Map<String, dynamic> result = {
          for (var item in snapshot.data!) item['name']: item['data'],
        };

        semesters = result["running_sems"].cast<int>().toList();
        departments = result["departments"].cast<String>().toList();
        // final List<String> sections = ['A', 'B'];

        return _buildScreen(context);
      },
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Details'),
        centerTitle: true,
        elevation: 0,
        leading:
            currentIndex > 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _moveToPreviousStep,
                )
                : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value:
                    (currentIndex + 1) / (selectedDepartment == 'CSE' ? 4 : 3),
                backgroundColor: Colors.grey[200],
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),

              Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    // Step 1: Semester Selection
                    _buildSemesterSelection(),

                    // Step 2: Department Selection
                    _buildDepartmentSelection(),

                    // Step 3: Section Selection (only for CSE)
                    _buildSectionSelection(),

                    // Step 4: Complete/Summary
                    _buildCompletionScreen(),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Navigation buttons
              if (currentIndex < 3) ...[
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _canMoveNext() ? _moveToNextStep : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      currentIndex == 2 ? 'Complete' : 'Continue',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the main app screen
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
                      print('Academic details saved successfully!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool _canMoveNext() {
    switch (currentIndex) {
      case 0:
        return selectedSemester != null;
      case 1:
        return selectedDepartment != null;
      case 2:
        return selectedDepartment == 'CSE' ? selectedSection != null : true;
      default:
        return true;
    }
  }

  Widget _buildSemesterSelection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Semester',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Which semester are you currently in?',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: semesters.length,
            itemBuilder: (context, index) {
              final semester = semesters[index];
              final isSelected = selectedSemester == semester;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSemester = semester;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      semester.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentSelection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Department',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Which department are you enrolled in?',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100],
            ),
            child: Column(
              children:
                  departments.map((department) {
                    final isSelected = selectedDepartment == department;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedDepartment = department;
                          // Clear section if department is not CSE
                          if (department != 'CSE') {
                            selectedSection = null;
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                  width: 2,
                                ),
                                color:
                                    isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                              ),
                              child:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        size: 18,
                                        color: Colors.white,
                                      )
                                      : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    department,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getDepartmentDescription(department),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getDepartmentDescription(String dept) {
    switch (dept) {
      case 'CSE':
        return 'Computer Science & Engineering';
      case 'ECE':
        return 'Electronics & Communication Engineering';
      case 'DSAI':
        return 'Data Science & Artificial Intelligence';
      default:
        return '';
    }
  }

  Widget _buildSectionSelection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Section',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Which section are you assigned to?',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Row(
            children:
                sections.map((section) {
                  final isSelected = selectedSection == section;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSection = section;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: section == 'A' ? 8 : 0),
                        height: 160,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1)
                                  : Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[300],
                              ),
                              child: Center(
                                child: Text(
                                  section,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Section $section',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 24),
          Text(
            'Academic Details Saved!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildInfoRow('Semester', 'Semester $selectedSemester'),
                const SizedBox(height: 16),
                _buildInfoRow('Department', selectedDepartment ?? ''),
                if (selectedDepartment == 'CSE') ...[
                  const SizedBox(height: 16),
                  _buildInfoRow('Section', 'Section $selectedSection'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
