import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/CheckBox/check_box_bloc.dart';
import 'package:bloc_to_do/logic/bloc/ComapeData/comapre_data_bloc.dart';
import 'package:bloc_to_do/presentation/animations/fade_animation.dart';
import 'package:bloc_to_do/presentation/widgets/home_lists_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage {
  Widget buildHomePage(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data!.getStringList('collectedDataList') ?? [];
          final hasTasks = tasks.isNotEmpty;

          return Stack(
            children: [
              Column(
                children: [
                  Flexible(
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
                  Flexible(
                    flex: 3,
                    child: Container(
                      color: ToDoColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.075,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    children: [
                      FadeAnimation().createAnimation(
                        context,
                        Text(
                          DateFormat('MMMM d, yyy').format(DateTime.now()),
                          style: ToDoTextStyles.white16,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      FadeAnimation().createAnimation(
                        context,
                        const Text(
                          'Bloc ToDo List',
                          style: ToDoTextStyles.white30,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      BlocListener<CheckBoxBloc, CheckBoxState>(
                        listener: (context, checkboxState) {
                          if (checkboxState is CheckBoxIsChecked) {
                            context.read<ComapreDataBloc>().fetchData();
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
                                  ListBuilder().buildTopList(context, activeTasks),
                                  if (hasTasks) ...[
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 24),
                                        child: Text(
                                          'Completed',
                                          style: ToDoTextStyles.black16,
                                        ),
                                      ),
                                    ),
                                    ListBuilder().buildBottomList(context, completedTasks),
                                  ],
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(child: CupertinoActivityIndicator(radius: 20.0));
      },
    );
  }
}
