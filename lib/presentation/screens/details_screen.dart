import 'package:bloc_to_do/logic/bloc/CompareTask/compare_task_bloc.dart';
import 'package:bloc_to_do/logic/bloc/DataTransfer/data_transfer_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Details')),
      body: BlocBuilder<CompareTaskBloc, CompareTaskState>(
        builder: (context, state) {
          if (state is CompareTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompareTaskSuccess) {
            final task = state.task;
            return BlocBuilder<DataTransferBloc, DataTransferState>(
              builder: (context, dataState) {
                if (dataState is DartaTransferSuccess) {
                  return ListView(
                    children: [
                      ListTile(
                        title: Text('Task ID: ${task['id']}'),
                      ),
                      ListTile(
                        title: Text('Task Title: ${task['title']}'),
                      ),
                      ListTile(
                        title: Text('Task Note: ${task['notes']}'),
                      ),
                    ],
                  );
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
