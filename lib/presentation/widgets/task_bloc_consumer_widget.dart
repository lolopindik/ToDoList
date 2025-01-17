import 'package:bloc_to_do/logic/bloc/DataCollection/data_collection_bloc.dart';
import 'package:bloc_to_do/logic/services/snackbar_service.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskConsumer {
  bool type;
  Map? task;
  TaskConsumer(this.type, {this.task});

  Widget buildTaskBlocConsumer(BuildContext context) {
    return BlocConsumer<DataCollectionBloc, DataCollectionState>(
      listener: (context, state) {
        if (state is DateCollectionSuccess) {
          SnackbarService()
              .showSnackbar(context, 'Yeap!', (type) ? 'Data has been changed' : 'Everything went well', true);
          Navigator.pushNamed(context, '/home');
        } else if (state is DataCollectionFailure) {
          SnackbarService().showSnackbar(
              context, (type) ? 'Bruh!' : 'Oups!', (type) ? "There were no changes" : "You haven't filled in all the details", false);
        }
      },
      builder: (context, state) {
        return BlocBuilder<DataCollectionBloc, DataCollectionState>(
          builder: (context, state) {
            //* Add a ternary operator later with a different construct with true
            return CustomButton().buildBottombar(
              context,
              'Save',
              () {
                (type)
                    ? context.read<DataCollectionBloc>().add(
                          SaveDataEvent(context, type, task: task),
                        )
                    : context.read<DataCollectionBloc>().add(
                          SaveDataEvent(context, type),
                        );
              },
            );
          },
        );
      },
    );
  }
}
