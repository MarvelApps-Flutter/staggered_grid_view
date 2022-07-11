import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_gridview_module/dummy_data/dummy_data.dart';

import '../constant/image_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DummyData _data;
  int tappedIndex = 3;
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _data = DummyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Staggered Gridview Module"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          tappedIndex == 1
              ? _staggeredGridView()
              : tappedIndex == 2
                  ? _quiltedStaggeredGridView()
                  : _masonryStaggeredGridView(),
          _bottomTapBar()
        ],
      ),
    );
  }

  Column _bottomTapBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.blue.shade400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_button(1), _button(2), _button(3)],
          ),
        )
      ],
    );
  }

  InkWell _button(int tapIndex) {
    return InkWell(
      onTap: () {
        setState(() {
          tappedIndex = tapIndex;
        });
      },
      child: Column(
        children: [
          Icon(
            Icons.layers_outlined,
            size: 33,
            color: tapIndex == tappedIndex ? Colors.red : Colors.white,
          ),
          Text(
            "Layout $tapIndex",
            textScaleFactor: 1.3,
          ),
        ],
      ),
    );
  }

  Widget _staggeredGridView() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 100, left: 10, right: 10),
        child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 15,
            crossAxisSpacing: 8,
            children: List<Widget>.generate(_data.imagesList.length,
                (index) => _staggeredGridViewTile(index))),
      ),
    );
  }

  Widget _staggeredGridViewTile(int index) {
    int crosscount, maincount;
    if (index % 5 == 0) {
      crosscount = 2;
      maincount = 2;
    } else if (index % 5 == 1) {
      crosscount = 2;
      maincount = 1;
    } else if (index % 5 == 2) {
      crosscount = 1;
      maincount = 1;
    } else if (index % 5 == 3) {
      crosscount = 1;
      maincount = 1;
    } else {
      crosscount = 4;
      maincount = 2;
    }

    return StaggeredGridTile.count(
      crossAxisCellCount: crosscount,
      mainAxisCellCount: maincount,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
              color: Colors.white,
              child: FadeInImage(
                image: Image.network(_data.imagesList[index]).image,
                placeholder: Image.asset(
                  ImageConstant.placeHolder,
                  fit: BoxFit.fill,
                ).image,
              ))),
    );
  }

  Widget _quiltedStaggeredGridView() {
    return GridView.custom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate((context, index) {
        if (index >= _data.imagesList.length) {
          index = index % _data.imagesList.length;
        } else {
          index = index;
        }
        return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                color: Colors.white,
                child: FadeInImage(
                  image: Image.network(_data.imagesList[index]).image,
                  placeholder: Image.asset(
                    ImageConstant.placeHolder,
                    fit: BoxFit.fill,
                  ).image,
                )));
      }),
    );
  }

  Widget _masonryStaggeredGridView() {
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        if (index >= _data.imagesList.length) {
          index = index % _data.imagesList.length;
        } else {
          index = index;
        }
        return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                color: Colors.white,
                child: FadeInImage(
                  image: Image.network(_data.imagesList[index]).image,
                  placeholder: Image.asset(
                    ImageConstant.placeHolder,
                    fit: BoxFit.cover,
                  ).image,
                )));
      },
    );
  }
}
