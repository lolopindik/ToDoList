import 'package:bloc_to_do/logic/bloc/DataCollection/data_collection_bloc.dart';
import 'package:bloc_to_do/logic/services/snackbar_service.dart';
import 'package:bloc_to_do/presentation/widgets/bottom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskConsumer {
  Widget buildTaskBlocConsumer(BuildContext context) {
    return BlocConsumer<DataCollectionBloc, DataCollectionState>(
      listener: (context, state) {
        if (state is DateCollectionSuccess) {
          SnackbarService()
              .showSnackbar(context, 'Yeap!', 'Everything went well', true);
          Navigator.pushNamed(context, '/home');
        } else if (state is DataCollectionFailure) {
          SnackbarService().showSnackbar(
              context, 'Oups!', "You haven't filled in all the details", false);
        }
      },
      builder: (context, state) {
        return BlocBuilder<DataCollectionBloc, DataCollectionState>(
          builder: (context, state) {
            return CustomButton().buildBottombar(
              context,
              'Save',
              () {
                context.read<DataCollectionBloc>().add(
                      SaveDataEvent(context),
                    );
              },
            );
          },
        );
      },
    );
  }
}
