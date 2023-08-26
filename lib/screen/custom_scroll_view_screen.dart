import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scroll_view/const/colors.dart';
import 'package:scroll_view/layout/main_layout.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  // 최대 높이
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  // 최소 높이
  double get minExtent => minHeight;

  @override
  // covariant 상속된 클래스도 사용가능
  // oldDelegate 빌드가 실행되었을 때 이전 delegate
  // newDelegate -> this
  // shouldRebuild 새로 빌드를 할지 말지 결정
  // false 빌드 안함 true 빌드함
  bool shouldRebuild(covariant _SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          renderSliverPersistentHeader(),
          renderSliverChildBuilderList(),
          renderSliverPersistentHeader(),
          renderBuilderSliverGrid(),
          renderSliverPersistentHeader(),
          renderSliverChildBuilderList(),
          renderSliverPersistentHeader(),
          renderBuilderSliverGrid()
        ],
      ),
    );
  }

  SliverList renderSliverChildList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
    );
  }

  SliverList renderSliverChildBuilderList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 10,
      ),
    );
  }

  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  SliverGrid renderBuilderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 50,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  Widget renderWhyUseCustomScrollView() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: 1,
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: 1,
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

// AppBar
  SliverAppBar renderSliverAppBar() {
    return const SliverAppBar(
      floating: true, // true list의 중간에도 보임 / false 이면 최상단에서만 앱바가 보인다.
      pinned: false, // 앱바를 고정한다.
      snap: true, // floating이 true일때만 사용가능, 앱바 자석효과
      stretch: true, // 맨위에서 스크롤햇을대 남는영역 차지 physics bouncing일 경우에만!
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('flexible'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  SliverPersistentHeader renderSliverPersistentHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Text(
                '신기하지??',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          maxHeight: 150,
          minHeight: 75),
    );
  }

  Widget renderContainer(
      {required Color color, required int index, double? height}) {
    print(index);

    return Container(
      key: Key(
        index.toString(),
      ),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
