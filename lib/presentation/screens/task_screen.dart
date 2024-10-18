import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_to_do/constants/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/img/HomeFrame.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: ToDoColors.mainColor,
                ),
              ),
            ],
          ),
          // Основное содержимое
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.075,
                left: 15,
                right: 15,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: ToDoColors.mainColor,
                          radius: MediaQuery.of(context).size.height * 0.038,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close_rounded,
                                size:
                                    MediaQuery.of(context).size.height * 0.05),
                          ),
                        ),
                      ),
                      const Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Add new task',
                            style: ToDoTextStyles.white24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.052),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Task Title', style: ToDoTextStyles.black16),
                  ),
                  const TextField(
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ToDoColors.mainColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        const Text(
                          'Category',
                          style: ToDoTextStyles.black16,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'lib/assets/icons/Category=Event.svg',
                              height: MediaQuery.of(context).size.height * 0.07,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'lib/assets/icons/Category=Goal.svg',
                              height: MediaQuery.of(context).size.height * 0.07,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'lib/assets/icons/Category=Task.svg',
                              height: MediaQuery.of(context).size.height * 0.07,
                            ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Date', style: ToDoTextStyles.black16),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: BlocProvider(
                              create: (_) => DatepickerBloc(),
                              child:
                                  BlocBuilder<DatepickerBloc, DatepickerState>(
                                builder: (context, state) {
                                  final dateBloc =
                                      BlocProvider.of<DatepickerBloc>(context);

                                  return GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        dateBloc.add(DateSelectedEvent(
                                          pickedDate,
                                        ));
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: TextField(
                                        controller: dateBloc.dateController,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                              Icons.calendar_today_outlined),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Time', style: ToDoTextStyles.black16),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: BlocProvider(
                              create: (_) => TimepickerBloc(),
                              child:
                                  BlocBuilder<TimepickerBloc, TimepickerState>(
                                builder: (context, state) {
                                  final timeBloc =
                                      BlocProvider.of<TimepickerBloc>(context);
                                  return GestureDetector(
                                    onTap: () async {
                                      final timeBloc =
                                          BlocProvider.of<TimepickerBloc>(
                                              context);
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        final formattedTime =
                                            // ignore: use_build_context_synchronously
                                            pickedTime.format(context);
                                        timeBloc.add(TimeSelectedEvent(
                                            pickedTime, formattedTime));
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
