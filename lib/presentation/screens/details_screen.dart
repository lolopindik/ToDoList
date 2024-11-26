import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/CompareTask/compare_task_bloc.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ToDoColors.mainColor,
      bottomNavigationBar: CustomButton()
          .buildBottombar(context, 'Edit task', () {}), // TODO: Add function
      body: BlocBuilder<CompareTaskBloc, CompareTaskState>(
        builder: (context, state) {
          if (state is CompareTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompareTaskSuccess) {
            final task = state.task;
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: MediaQuery.of(context).size.height * 0.045),
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: const BoxDecoration(
                    color: ToDoColors.mainColor,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/img/HomeFrame.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.035,
                        backgroundColor: ToDoColors.mainColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: ToDoColors.seedColor,
                            size: 35,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text(
                        'Details',
                        style: ToDoTextStyles.white24,
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              task['category'] == 1
                                  ? 'lib/assets/icons/Category=Event.svg'
                                  : task['category'] == 2
                                      ? 'lib/assets/icons/Category=Goal.svg'
                                      : 'lib/assets/icons/Category=Task.svg',
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                task['title'] ?? '',
                                style: ToDoTextStyles.black24,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Data: ',
                                style: ToDoTextStyles.black24,
                              ),
                              TextSpan(
                                  text: '${task['selectedDate']}'
                                      .substring(0, 10),
                                  style: ToDoTextStyles.black18),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Time: ',
                                style: ToDoTextStyles.black24,
                              ),
                              TextSpan(
                                  text: '${task['selectedTime']}',
                                  style: ToDoTextStyles.black18),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Note: ',
                                style: ToDoTextStyles.black24,
                              ),
                              TextSpan(
                                  text: '${task['notes']}',
                                  style: ToDoTextStyles.black18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CompareTaskFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
