import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:bloc_to_do/presentation/animations/scale_animation.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloc_to_do/constants/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ToDoColors.mainColor,
      bottomNavigationBar:
          CustomButton().buildBottombar(context, 'Save', () {}),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/assets/img/HomeFrame.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.045),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: ScaleAnimation().createAnimation(
                                context,
                                const Text(
                                  'Add new task',
                                  style: ToDoTextStyles.white24,
                                ),
                              ),
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
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.06,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: ToDoColors.mainColor,
                              radius:
                                  MediaQuery.of(context).size.height * 0.035,
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close_rounded,
                                    size: MediaQuery.of(context).size.height *
                                        0.05),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.052),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Task Title',
                                style: ToDoTextStyles.black16),
                          ),
                          BlocBuilder<TextFieldHandlerBloc,
                              TextFieldHandlerState>(
                            builder: (context, state) {
                              return TextField(
                                onChanged: (title) {
                                  context
                                      .read<TextFieldHandlerBloc>()
                                      .add(TitleEvent(title));
                                },
                                maxLength: 30,
                                decoration: const InputDecoration(
                                  hintText: 'Task Title',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ToDoColors.mainColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: BlocBuilder<CategorypickerCubit,
                                CategorypickerState>(
                              builder: (context, state) {
                                double categorySize =
                                    MediaQuery.of(context).size.height * 0.07;
                                double selectedCategorySize =
                                    MediaQuery.of(context).size.height * 0.085;
                                if (state is CategorypickerSelected) {
                                  int selectedCategoryIndex =
                                      state.categoryIndex;
                                  debugPrint(
                                      'Selected category index: $selectedCategoryIndex');
                                }
                                return Row(
                                  children: [
                                    const Text(
                                      'Category',
                                      style: ToDoTextStyles.black16,
                                    ),
                                    const SizedBox(width: 24),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CategorypickerCubit>()
                                            .categoryPickEvent();
                                      },
                                      icon: SvgPicture.asset(
                                          'lib/assets/icons/Category=Event.svg',
                                          height:
                                              (state is CategorypickerSelected &&
                                                      state.categoryIndex == 1)
                                                  ? selectedCategorySize
                                                  : categorySize),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CategorypickerCubit>()
                                            .categoryPickGoal();
                                      },
                                      icon: SvgPicture.asset(
                                          'lib/assets/icons/Category=Goal.svg',
                                          height:
                                              (state is CategorypickerSelected &&
                                                      state.categoryIndex == 2)
                                                  ? selectedCategorySize
                                                  : categorySize),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CategorypickerCubit>()
                                            .categoryPickTask();
                                      },
                                      icon: SvgPicture.asset(
                                          'lib/assets/icons/Category=Task.svg',
                                          height:
                                              (state is CategorypickerSelected &&
                                                      state.categoryIndex == 3)
                                                  ? selectedCategorySize
                                                  : categorySize),
                                    ),
                                  ],
                                );
                              },
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
                                    child: Text('Date',
                                        style: ToDoTextStyles.black16),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: BlocBuilder<DatepickerBloc,
                                        DatepickerState>(
                                      builder: (context, state) {
                                        final dateBloc =
                                            BlocProvider.of<DatepickerBloc>(
                                                context);
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
                                                  pickedDate));
                                            }
                                          },
                                          child: AbsorbPointer(
                                            child: TextField(
                                              controller:
                                                  dateBloc.dateController,
                                              decoration: const InputDecoration(
                                                suffixIcon: Icon(Icons
                                                    .calendar_today_outlined),
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
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Time',
                                        style: ToDoTextStyles.black16),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: BlocBuilder<TimepickerBloc,
                                        TimepickerState>(
                                      builder: (context, state) {
                                        final timeBloc =
                                            BlocProvider.of<TimepickerBloc>(
                                                context);
                                        return GestureDetector(
                                          onTap: () async {
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
                                              controller:
                                                  timeBloc.timeController,
                                              decoration: const InputDecoration(
                                                suffixIcon:
                                                    Icon(Icons.timer_sharp),
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
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Notes',
                                style: ToDoTextStyles.black16,
                              ),
                            ),
                          ),
                          BlocBuilder<TextFieldHandlerBloc,
                              TextFieldHandlerState>(
                            builder: (context, state) {
                              return TextFormField(
                                onChanged: (notes) {
                                  context
                                      .read<TextFieldHandlerBloc>()
                                      .add(NotesEvent(notes));
                                },
                                maxLines:
                                    (MediaQuery.of(context).size.height * 0.008)
                                        .toInt(),
                                decoration: const InputDecoration(
                                  hintText: 'Notes',
                                  border: OutlineInputBorder(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
