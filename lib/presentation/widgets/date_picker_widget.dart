import 'package:buzz_tech/constants/preferences.dart';
import 'package:buzz_tech/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerWidget {
  final String? initialDate;

  DatePickerWidget({this.initialDate});

  Widget buildDatePicker(BuildContext context) {
    return BlocBuilder<DatepickerBloc, DatepickerState>(
      builder: (context, state) {
        final dateBloc = BlocProvider.of<DatepickerBloc>(context);

        String selectedDate = state is DatepickerSelected
            ? "${state.selectedDate.toLocal()}".split(' ')[0]
            : initialDate ?? '';

        if (dateBloc.dateController.text != selectedDate) {
          //* Added event to update data in the bloc
          dateBloc.dateController.text = selectedDate;
          dateBloc.add(DateSelectedEvent(DateTime.parse(selectedDate)));
        }

        return GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
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
