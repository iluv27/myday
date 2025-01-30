import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myday/constants/toast.dart';
import 'package:myday/home/bloc/tasks_bloc.dart';
import 'package:myday/theme/theme.dart';
import 'package:intl/intl.dart'; // For date formatting

final TextEditingController dateController = TextEditingController();

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('HH:mm');

    // final DateTime currentDate = DateTime.now();
    // dateController.text =
    //     dateFormatter.format(currentDate); // Default current date

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
            ),
          ),
        ),
        title: Text(
          'Create Task',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_note_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Due Date input
            Text(
              'Due Date and Time',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: TextField(
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: '00 - 00 - 00',
                        suffixIcon: Icon(Icons.calendar_today),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      onTap: () async {
                        // Show date picker and time picker
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          dateController.text =
                              dateFormatter.format(pickedDate);
                          // ignore: unused_local_variable
                          final TimeOfDay? pickedTime = await showTimePicker(
                            // ignore: use_build_context_synchronously
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                          );

                          dateController.text =
                              dateFormatter.format(pickedDate);
                        }
                      }),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: TextField(
                    controller: timeController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: '00:00',
                      suffixIcon: Icon(Icons.calendar_today),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final selectedTime = DateTime(now.year, now.month,
                            now.day, pickedTime.hour, pickedTime.minute);
                        timeController.text =
                            timeFormatter.format(selectedTime);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  final taskTitle = titleController.text;
                  final taskDueDate = dateController.text.trim();
                  final taskTime = timeController.text.trim();

                  if (taskTitle.isEmpty) {
                    AppToast.show('Please enter a task title');
                    return;
                  }
                  if (taskDueDate.isEmpty || taskTime.isEmpty) {
                    AppToast.show('Please select a due date and time');
                    return;
                  }

                  final DateTime dueDateTime =
                      DateTime.parse('$taskDueDate $taskTime');

                  context.read<TasksBloc>().add(
                      AddTasksEvent(task: taskTitle, dueDate: dueDateTime));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: const Color.fromARGB(255, 65, 0, 118),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: const Color.fromARGB(255, 20, 0, 37), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Create Task',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
