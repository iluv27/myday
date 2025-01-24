import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myday/home/bloc/tasks_bloc.dart';
import 'package:myday/theme/theme.dart';
import 'package:intl/intl.dart'; // For date formatting

final TextEditingController dateController = TextEditingController();

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();

    // Format the current date
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd HH:mm');
    final DateTime currentDate = DateTime.now();
    dateController.text =
        dateFormatter.format(currentDate); // Default current date

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Create Task',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_document),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title input
            Text(
              'Task Title',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter task title',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Due Date input
            Text(
              'Due Date and Time',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 10),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'Select due date and time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                // Show date picker and time picker
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    // ignore: use_build_context_synchronously
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentDate),
                  );

                  if (pickedTime != null) {
                    final DateTime combinedDate = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );

                    dateController.text =
                        dateFormatter.format(combinedDate); // Update text field
                  }
                }
              },
            ),
            SizedBox(height: 30),

            // Create Task button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final taskTitle = titleController.text;
                  final taskDueDate = DateTime.parse(dateController.text);

                  if (taskTitle.isNotEmpty) {
                    // final newTask = TaskTemplate(
                    //   title: taskTitle,
                    //   dueDate: taskDueDate,
                    // );

                    context.read<TasksBloc>().add(
                        AddTasksEvent(task: taskTitle, dueDate: taskDueDate));
                    Navigator.pop(context);
                  } else {
                    // Show a snack bar if the title is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a task title')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Create Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
