import 'package:bloc_to_do/constants/preferences.dart';
import 'package:bloc_to_do/logic/bloc/CompareTask/compare_task_bloc.dart';
import 'package:bloc_to_do/logic/bloc/DataTransfer/data_transfer_bloc.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton().buildBottombar(context, 'Edit task', (){}),
      body: BlocBuilder<CompareTaskBloc, CompareTaskState>(
        builder: (context, state) {
          if (state is CompareTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompareTaskSuccess) {
            final task = state.task;
            return BlocBuilder<DataTransferBloc, DataTransferState>(
              builder: (context, dataState) {
                if (dataState is DartaTransferSuccess) {
                  return Stack(children: [
                    Column(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/img/HomeFrame.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.076,
                                  ),
                                  const Center(
                                      child: Text(
                                    'Details',
                                    style: ToDoTextStyles.white30,
                                  )),
                                ],
                              ),
                            )),
                        Flexible(
                            flex: 5,
                            child: Container(
                              color: ToDoColors.mainColor,
                            )),
                      ],
                    ),
                    Positioned.fill(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.065,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: ToDoColors.mainColor,
                              radius:
                                  MediaQuery.of(context).size.height * 0.035,
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.arrow_back_rounded,
                                    size: MediaQuery.of(context).size.height *
                                        0.05),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ]);
                }
                return const Center(
                    child: CupertinoActivityIndicator(
                  radius: 20,
                ));
              },
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
