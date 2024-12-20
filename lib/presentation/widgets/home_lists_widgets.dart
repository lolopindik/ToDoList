import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/CheckBox/check_box_bloc.dart';
import 'package:bloc_to_do/logic/bloc/ComapeData/comapre_data_bloc.dart';
import 'package:bloc_to_do/presentation/widgets/icons_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBuilder {
  Widget buildTopList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: ToDoColors.mainColor, borderRadius: BorderRadius.circular(30)),
      child: BlocBuilder<ComapreDataBloc, ComapreDataState>(
        builder: (context, state) {
          if (state is ComapreDataLoading) {
            return const Center(
                child: CupertinoActivityIndicator(
              radius: 20,
            ));
          } else if (state is ComapreDataLoaded) {
            if (state.taskList.isEmpty) {
              return const Center(
                child: Text(
                  'No active tasks',
                  style: ToDoTextStyles.black16,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  final task = state.taskList[index];
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
                      //todo other logic
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
            );
          } else if (state is ComapreDataFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget buldBottomList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
          color: ToDoColors.mainColor, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(top: 5, left: 20, bottom: 5),
                  width: 100,
                  height: 40,
                  child: const Text(
                    'Lorem lorem lorem lorem lorem lorem',
                    style: ToDoTextStyles.black16,
                  ));
            }),
      ),
    );
  }
}
