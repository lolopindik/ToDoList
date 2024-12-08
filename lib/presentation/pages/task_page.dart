import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/presentation/animations/scale_animation.dart';
import 'package:bloc_to_do/presentation/widgets/category_picker_widget.dart';
import 'package:bloc_to_do/presentation/widgets/date_picker_widget.dart';
import 'package:bloc_to_do/presentation/widgets/textfiled_handler_widget.dart';
import 'package:bloc_to_do/presentation/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';

class TaskPage {
  Widget buildTaskPage(BuildContext context, bool edit) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                              top: MediaQuery.of(context).size.height * 0.045),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ScaleAnimation().createAnimation(
                              context,
                              Text(
                                edit ? 'Edit Task' : 'Add new task',
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
                            radius: MediaQuery.of(context).size.height * 0.035,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close_rounded,
                                  size: MediaQuery.of(context).size.height *
                                      0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.052),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('Task Title', style: ToDoTextStyles.black16),
                        ),
                        TextfiledHandlerWidget().buildTitle(context),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: CategoryPickerWidget()
                                .buildCategoryPicker(context)),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: DatePickerWidget()
                                      .buildDatePicker(context),
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
                                    child: TimePickerWidget()
                                        .buildTimePicker(context)),
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
                        TextfiledHandlerWidget().buildNotes(context)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
