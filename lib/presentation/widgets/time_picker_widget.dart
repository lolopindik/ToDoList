import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePickerWidget {
  final String? initialTime;

  TimePickerWidget({this.initialTime});

  Widget buildTimePicker(BuildContext context) {
    return BlocBuilder<TimepickerBloc, TimepickerState>(
      builder: (context, state) {
        final timeBloc = BlocProvider.of<TimepickerBloc>(context);

        String selectedTime = state is TimepickerSelected
            ? timeBloc.timeController.text
            : initialTime ?? '';

        if (timeBloc.timeController.text != selectedTime) {
          timeBloc.timeController.text = selectedTime;
        }

        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              // ignore: use_build_context_synchronously
              final formattedTime = pickedTime.format(context);
              timeBloc.add(TimeSelectedEvent(pickedTime, formattedTime));
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: timeBloc.timeController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.timer_sharp),
                hintText: 'Time',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ToDoColors.mainColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
