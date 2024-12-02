
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_music_app/common/helpers/is_dark_mode.dart';
import 'package:my_music_app/core/configs/assets/app_vectors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSize{
  final Widget ? title;
  final Widget ? action;
  final bool hidebackbutton;
  final Color? backgroundColor;
  const BasicAppBar({this.title, this.hidebackbutton = false, super.key, this.action, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      //"??" check if null
      title: title ?? Text(""),
      actions: [action ?? Container()],
      backgroundColor: backgroundColor?? Colors.transparent,
      elevation: 0,
      leading: hidebackbutton ? null: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: context.isDarkMode? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 15,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        )
      ),
    );
  }


  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
