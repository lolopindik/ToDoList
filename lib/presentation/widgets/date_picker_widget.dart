import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerWidget {
  Widget buildDatePicker(BuildContext context) {
    return BlocBuilder<DatepickerBloc, DatepickerState>(
      builder: (context, state) {
        final dateBloc = BlocProvider.of<DatepickerBloc>(context);
        return GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              dateBloc.add(DateSelectedEvent(pickedDate));
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: dateBloc.dateController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_today_outlined),
                hintText: 'Date',
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
