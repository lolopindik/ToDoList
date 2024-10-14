import 'package:flutter/material.dart';
import 'package:bloc_to_do/constants/preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Text(
                    '***Сalendar Data***',
                    style: ToDoTextStyles.white16,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  const Text(
                    'Bloc ToDo List',
                    style: ToDoTextStyles.white30,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        //! color: ToDoColors.mainColor,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Completed',
                        style: ToDoTextStyles.black16,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        //! color: ToDoColors.mainColor,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      //todo: add navigation on  button click
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(Size(
                            MediaQuery.of(context).size.width * 1,
                            MediaQuery.of(context).size.height * 0.055)),
                        backgroundColor:
                            WidgetStateProperty.all(ToDoColors.seedColor),
                      ),
                      child: const Text(
                        'Add new task',
                        style: ToDoTextStyles.white16,
                      ),
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
