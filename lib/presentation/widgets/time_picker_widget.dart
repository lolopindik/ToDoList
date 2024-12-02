import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePickerWidget {
  Widget buildTimePicker(BuildContext context) {
    return BlocBuilder<TimepickerBloc, TimepickerState>(
      builder: (context, state) {
        final timeBloc = BlocProvider.of<TimepickerBloc>(context);
        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              final formattedTime =
                  // ignore: use_build_context_synchronously
                  pickedTime.format(context);
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
