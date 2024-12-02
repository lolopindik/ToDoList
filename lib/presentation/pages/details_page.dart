import 'package:bloc_to_do/presentation/widgets/details_bloc_builder_widget.dart';
import 'package:flutter/material.dart';

class DetailsPage {
  Widget buildDetailsPage(BuildContext context) {
    return DetailsBlocBuilderWidget().buildEditTaskBlocBuilder(context);
  }
}
