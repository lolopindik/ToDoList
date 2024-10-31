import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcons {
  Widget buildIcon(BuildContext context, int icon, double height) {
    return (icon == 1)
        ? SvgPicture.asset('lib/assets/icons/Category=Event.svg',
            height: height)
        : (icon == 2)
            ? SvgPicture.asset('lib/assets/icons/Category=Goal.svg',
                height: height)
            : SvgPicture.asset('lib/assets/icons/Category=Task.svg',
                height: height);
  }
}
