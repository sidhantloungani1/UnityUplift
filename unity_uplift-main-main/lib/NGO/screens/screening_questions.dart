import "package:flutter/material.dart";
import "package:unity_uplift/components/custom_btn.dart";
import 'package:unity_uplift/NGO/screens/view_scholarship.dart';

class screening_questions extends StatefulWidget {
  const screening_questions({super.key});

  @override
  State<screening_questions> createState() => _screening_questionsState();
}

class _screening_questionsState extends State<screening_questions> {
  List<String> questions = [
    'what is skill set',
    'how much experience do you have in this feild'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Do it later'),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'Applicant collection',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Applicant Email',
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(
                    trailing: InkWell(
                      child: const Icon(Icons.delete),
                      onTap: () {
                        _showDeleteConfirmationDialog(context, index);
                      },
                    ),
                    title: Text(questions[index]),
                  ),
                ),
              ),
            ),
            CustomBtn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => viewscholarship(),
                  ),
                );
              },
              height: 50,
              width: 50.0,
              text: 'Done',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddQuestionDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildQuestionItem(int index) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(questions[index]),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteConfirmationDialog(context, index),
        ),
      ),
    );
  }

  Future<void> _showAddQuestionDialog(BuildContext context) async {
    String newQuestion = '';
    String skillPlaceholder = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Question'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Question'),
                onChanged: (value) {
                  newQuestion = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Skill Placeholder (optional)'),
                onChanged: (value) {
                  skillPlaceholder = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addNewQuestion(newQuestion, skillPlaceholder);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNewQuestion(String question, String skillPlaceholder) {
    if (question.isNotEmpty) {
      String newQuestion = skillPlaceholder.isNotEmpty
          ? '$question [$skillPlaceholder]'
          : question;
      setState(() {
        questions.add(newQuestion);
      });
    } else {
      // Handle empty question input
      // You can show a snackbar or another type of error feedback to the user
    }
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Question'),
          content: const Text('Are you sure you want to delete this question?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteQuestion(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }
}
