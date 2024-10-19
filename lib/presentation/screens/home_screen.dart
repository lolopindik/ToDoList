import 'package:bloc_to_do/presentation/animations/fade_animation.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloc_to_do/constants/preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton().buildBottombar(
        context,
        'Add new Task',
        () => Navigator.of(context).pushNamed('/add_task'),
      ),
      body: Stack(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        //!color: Colors.red, |for test|
                        color: ToDoColors.mainColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(
                                    top: 5, left: 20, bottom: 5),
                                width: 100,
                                height: 40,
                                child: const Text(
                                  'Lorem lorem lorem lorem lorem lorem',
                                  style: ToDoTextStyles.black16,
                                ));
                          }),
                    ),
                  ),
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        //!color: Colors.red, |for test|
                        color: ToDoColors.mainColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(
                                    top: 5, left: 20, bottom: 5),
                                width: 100,
                                height: 40,
                                child: const Text(
                                  'Lorem lorem lorem lorem lorem lorem',
                                  style: ToDoTextStyles.black16,
                                ));
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
