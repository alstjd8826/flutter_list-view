import 'package:flutter/material.dart';
import 'package:scroll_view/layout/main_layout.dart';
import 'package:scroll_view/screen/custom_scroll_view_screen.dart';
import 'package:scroll_view/screen/grid_view_screen.dart';
import 'package:scroll_view/screen/list_view_screen.dart';
import 'package:scroll_view/screen/refrash_indicator.dart';
import 'package:scroll_view/screen/reorderable_list_view_screen.dart';
import 'package:scroll_view/screen/scrollbar_screen.dart';
import 'package:scroll_view/screen/single_child_scroll_view_screen.dart';
import 'package:scroll_view/type/screen_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ScreenModel> screens = [
    ScreenModel(
      builder: (_) => SingleChildScrollViewScreen(),
      name: 'SingleChildScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ListViewScreen(),
      name: 'ListViewScreen',
    ),
    ScreenModel(
      builder: (_) => GridViewScreen(),
      name: 'GridViewScreen',
    ),
    ScreenModel(
      builder: (_) => ReorderableListViewScreen(),
      name: 'ReorderableListViewScreen',
    ),
    ScreenModel(
      builder: (_) => CustomScrollViewScreen(),
      name: 'CustomScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ScrollbarScreen(),
      name: 'ScrollbarScreen',
    ),
    ScreenModel(
      builder: (_) => RefreshIndicatorScreen(),
      name: 'RefreshIndicatorScreen',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          clipBehavior: Clip.none, // 아래부분이 잘리지 않는다
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens
                .map(
                  (screen) => renderButton(
                    builder: screen.builder,
                    name: screen.name,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget renderButton({
    required WidgetBuilder builder,
    required String name,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: builder,
          ),
        );
      },
      child: Text(name),
    );
  }
}
