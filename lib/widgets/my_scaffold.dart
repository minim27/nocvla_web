import 'package:flutter/material.dart';
import 'package:nocvla/utils/my_colors.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    this.backgroundColor = MyColors.primary,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.drawerEnableOpenDragGesture = true,
    this.body,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
  });

  final Color backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? body, bottomNavigationBar, drawer, endDrawer;
  final bool drawerEnableOpenDragGesture, extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: key,
        appBar: appBar,
        backgroundColor: backgroundColor,
        drawer: drawer,
        endDrawer: endDrawer,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
