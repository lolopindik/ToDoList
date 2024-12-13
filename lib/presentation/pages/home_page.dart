import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/presentation/animations/fade_animation.dart';
import 'package:bloc_to_do/presentation/widgets/home_lists_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage {
  Widget buildHomePage(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks =
                snapshot.data!.getStringList('collectedDataList') ?? [];
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
                        color: ToDoColors.mainColor,
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        FadeAnimation().createAnimation(
                          context,
                          const Text(
                            'Bloc ToDo List',
                            style: ToDoTextStyles.white30,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ListBuilder().buildTopList(context),
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
                          ListBuilder().buldBottomList(context),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CupertinoActivityIndicator(radius: 20.0));
        });
  }
}
