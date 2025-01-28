import 'package:buzz_tech/constants/preferences.dart';
import 'package:buzz_tech/logic/bloc/CheckBox/check_box_bloc.dart';
import 'package:buzz_tech/logic/bloc/ComapeData/comapre_data_bloc.dart';
import 'package:buzz_tech/presentation/widgets/icons_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBuilder {
  Widget buildTopList(
      BuildContext context, List<Map<String, dynamic>> activeTasks) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: ToDoColors.mainColor, borderRadius: BorderRadius.circular(30)),
      child: activeTasks.isEmpty
          ? const Center(
              child: Text(
                'No active tasks',
                style: ToDoTextStyles.black16,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: activeTasks.length,
                itemBuilder: (context, index) {
                  final task = activeTasks[index];
                  return GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      Offset tapPosition = details.globalPosition;
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: {
                          'taskId': task['id'],
                          'tapPosition': tapPosition,
                        },
                      );
                    },
                    onTap: () {
                      // todo other logic
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.075,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 1, color: ToDoColors.secondaryColor))),
                      child: Row(
                        children: [
                          CustomIcons().buildIcon(context, task['category'],
                              MediaQuery.of(context).size.height * 0.06),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  task['title'],
                                  style: ToDoTextStyles.black16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                task['selectedTime'],
                                style: ToDoTextStyles.grey14,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: BlocBuilder<CheckBoxBloc, CheckBoxState>(
                                builder: (context, checkboxState) {
                                  final isChecked =
                                      checkboxState.checkedItems[task['id']] ??
                                          false;
                                  return Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? newValue) {
                                      context
                                          .read<CheckBoxBloc>()
                                          .add(ToggleCheckBox(task['id']));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget buildBottomList(
      BuildContext context, List<Map<String, dynamic>> completedTasks) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
          color: ToDoColors.mainColor, borderRadius: BorderRadius.circular(30)),
      child: completedTasks.isEmpty
          ? const Center(
              child: Text(
                'No completed tasks',
                style: ToDoTextStyles.black16,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      Offset tapPosition = details.globalPosition;
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: {
                          'taskId': task['id'],
                          'tapPosition': tapPosition,
                        },
                      );
                    },
                    onTap: () {
                      // todo other logic
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.075,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 1, color: ToDoColors.secondaryColor))),
                      child: Container(
                        color: ToDoColors.anotherColor,
                        child: Row(
                          children: [
                            CustomIcons().buildIcon(context, task['category'],
                                MediaQuery.of(context).size.height * 0.06),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    task['title'],
                                    style: ToDoTextStyles.black16.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                Text(
                                  task['selectedTime'],
                                  style: ToDoTextStyles.black16.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget buildTaskList(BuildContext context) {
    return BlocListener<ComapreDataBloc, ComapreDataState>(
      listener: (context, state) {
        if (state is ComapreDataLoaded) {
          //todo (⊙_⊙;)
        }
      },
      child: BlocBuilder<ComapreDataBloc, ComapreDataState>(
        builder: (context, state) {
          if (state is ComapreDataLoading) {
            return const Center(child: CupertinoActivityIndicator(radius: 20));
          } else if (state is ComapreDataLoaded) {
            final activeTasks = state.activeTasks;
            final completedTasks = state.completedTasks;

            return Column(
              children: [
                // Список активных задач
                buildTopList(context, activeTasks),
                // Список завершенных задач
                buildBottomList(context, completedTasks),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
