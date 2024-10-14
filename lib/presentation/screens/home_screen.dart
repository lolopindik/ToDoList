import 'package:flutter/material.dart';
import 'package:bloc_to_do/constants/preferences.dart';
import 'package:gap/gap.dart';

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
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: MediaQuery.of(context).size.height * 0.075,
              ),
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    //* need to implement here the data
                    child: Text(
                      '***Сalendar Data***',
                      style: ToDoTextStyles.whiteBold16,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'Bloc ToDo List',
                    style: ToDoTextStyles.whiteBold30,
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
