import 'package:buzz_tech/presentation/widgets/details_bloc_builder_widget.dart';
import 'package:flutter/material.dart';

class DetailsPage {
  Widget buildDetailsPage(BuildContext context) {
    return DetailsBlocBuilderWidget().buildEditTaskBlocBuilder(context);
  }
}
