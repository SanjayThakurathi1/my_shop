library botton_nav_bar;

import 'package:flutter/material.dart';

///this is a model for custom navigatorBar with following parameter
class BottomBarItem {
  ///initializing Constructor with BottomNavBarItem
  BottomBarItem(
      {required this.selectedIcon,
      required this.label,
      this.screen,
      this.selectedColor,
      this.centerDockedTitle});

  ///screen of bottomNavigation Bar
  Widget? screen;

  ///Selected Icon of a NavigationBar
  IconData selectedIcon;

  ///color of selected item
  Color? selectedColor;

  ///label represts the title of NavBar
  String label;
  //
  String? centerDockedTitle;
}

///BottomNavBarScreen
class BottomNavBar extends StatefulWidget {
  ///initializing Constructor of bottom Nav Bar
  const BottomNavBar({
    required this.bottomItems,
    super.key,
  });

  ///list of BottomBarItem
  final List<BottomBarItem> bottomItems;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

///Collector   Function

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: widget.bottomItems[_pageIndex].screen!,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            elevation: 20,
            child: const Icon(
              Icons.qr_code_scanner,
              size: 40,
            ),
          ),
        ),
        bottomNavigationBar: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(
                widget.bottomItems.length + 1,
                (int index) => Expanded(
                  child: index == (widget.bottomItems.length / 2)
                      ? Container(
                          height: 45,
                          padding: const EdgeInsets.only(top: 26),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            // if (index == 0) {
                            //   Scaffold.of(context).closeDrawer();
                            //   return;
                            // }
                            setState(() {
                              _pageIndex =
                                  index > (widget.bottomItems.length / 2)
                                      ? index - 1
                                      : index;
                            });
                            if (_pageIndex == 0) {
                              setState(() {});
                            }
                          },
                          child: SizedBox(
                            height: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                  child: Icon(
                                    widget
                                        .bottomItems[(index >
                                                (widget.bottomItems.length / 2)
                                            ? index - 1
                                            : index)]
                                        .selectedIcon,
                                    size: (index > widget.bottomItems.length / 2
                                                ? index - 1
                                                : index) ==
                                            _pageIndex
                                        ? 33
                                        : 27,
                                    color:
                                        (index > widget.bottomItems.length / 2
                                                    ? index - 1
                                                    : index) ==
                                                _pageIndex
                                            ? widget.bottomItems[_pageIndex]
                                                .selectedColor
                                            : Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                  child: Text(
                                    widget
                                        .bottomItems[(index >
                                                (widget.bottomItems.length / 2)
                                            ? index - 1
                                            : index)]
                                        .label,
                                    style: TextStyle(
                                      color:
                                          (index > widget.bottomItems.length / 2
                                                      ? index - 1
                                                      : index) ==
                                                  _pageIndex
                                              ? widget.bottomItems[_pageIndex]
                                                  .selectedColor
                                              : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          (index > widget.bottomItems.length / 2
                                                      ? index - 1
                                                      : index) ==
                                                  _pageIndex
                                              ? 11
                                              : 10.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      );
}
