<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
 
## _Bottom_ _Navigation_ _Bar_ 

The botton_nav_bar library is a custom implementation of the bottom navigation bar in Flutter. The library provides a customizable bottom navigation bar widget that allows users to navigate between different screens in an application. It is built to be flexible and can be adapted to fit any app's design

The botton_nav_bar library includes two main classes:

BottomBarItem: A model class that represents a single item in the bottom navigation bar. The BottomBarItem class has several parameters, including the screen to be displayed when the item is selected, the icon to be displayed when the item is not selected, the selected icon to be displayed when the item is selected, and the label to be displayed for the item.

BottomNavBar: A stateful widget that represents the bottom navigation bar. The BottomNavBar widget takes a list of BottomBarItem objects as input and displays them as a row of items. The widget also includes a floating action button that can be customized with an icon, label, and color.

The BottomNavBar widget allows users to customize several aspects of the bottom navigation bar, including the size and color of the icons and labels, the location of the floating action button, and the font weight of the item label

## _BottomBarItem_ _Parameters_
The BottomBarItem class has the following parameters:

screen: A Widget representing the screen that should be displayed when this item is selected.
icon: A Widget representing the unselected icon for this item.
label: A String representing the label to be displayed below this item.
selectedIcon: An IconData representing the selected icon for this item.

centerDockedTitle: A String representing the title to be displayed in the center of the bottom navigation bar.

bottomItemSelectedColor: A Color representing the color of the selected item in the bottom navigation bar

bottomItemUnSelectedColor: A Color representing the color of the unselected items in the bottom navigation bar

bottomItems: A list of BottomBarItem objects that are used to define the items in the bottom navigation bar.

fabChild: A widget that represents the label of the floating action button (FAB).

fabBackGroundColor: The background color of the FAB.

bottomNavBarColor: The background color of the bottom navigation bar.

floatingActionButtonLocation: The location of the FAB on the screen.

fabIcon: The icon that represents the FAB.

fabElevation: The elevation of the FAB.

fabHeight: The height of the FAB.

fabWidth: The width of the FAB.

bottomNavItemSelectedIconSize: The size of the icon when a bottom navigation bar item is selected.

bottomNavItemunSelectedIconSize: The size of the icon when a bottom navigation bar item is unselected.

bottomNavItemSelectedLabelSize: The font size of the label when a bottom navigation bar item is selected.

bottomNavItemLabelHeight: The height of the label of a bottom navigation bar item.

bottomNavItemIconHeight: The height of the icon of a bottom navigation bar item.

bottomNavItemunSelectedLabelSize: The font size of the label when a bottom navigation bar item is unselected.

bottomNavItemHeight: The height of a bottom navigation bar item.

bottomItemLabelFontWeight: The font weight of the label of a bottom navigation bar item.

onPressFAB: A function that is called when the FAB is pressed.

These parameters can be used to customize and configure the bottom navigation bar and FAB for a package in Dart.
 

 
## _Features_
. Customizable bottom navigation bar.
. Supports floating action button.
. Easy to implement.
. Comes with a demo application.

 
## _Getting_ _started_
```dart
dependencies:
  botton_nav_bar: ^0.1.2
```
 

## _Package_ _Implementation_
```dart
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: BottomNavBar(
          notchedRadius: 30,
          centerNotched: true,
          fabIcon: Icon(Icons.qr_code),
          bottomItems: <BottomBarItem>[
            BottomBarItem(
              bottomItemSelectedColor: Colors.green,
              label: 'Screen 1',
              screen: const Text('A'),
              selectedIcon: Icons.collections_bookmark_outlined,
            ),
            BottomBarItem(
              bottomItemSelectedColor: Colors.green,
              label: 'Screen 2',
              screen: const Text('B'),
              selectedIcon: Icons.search_rounded,
            ),
            BottomBarItem(
              bottomItemSelectedColor: Colors.green,
              label: 'Screen 3',
              selectedIcon: Icons.menu_open_rounded,
              screen: const Text('C'),
            ),
            BottomBarItem(
              bottomItemSelectedColor: Colors.green,
              label: 'Screen 4',
              screen: const Text('D'),
              selectedIcon: Icons.notifications_active,
            )
          ],
        ),
      );
}
```
  


 
## _Additional_ _information_
Added notched shape in the center of bottom navigation bar
Created a custom class CustomNotchedShape which extends the NotchedShape class and overrides the getOuterPath method to return the desired notched path.
The CustomNotchedShape class takes an integer parameter notchType to specify the type of notched shape.
Created three private methods _getOuterPathType1, _getOuterPathType2, and _getOuterPathType3 to return the path for different types of notched shapes.
Modified the BottomNavigationBar widget to use the CustomNotchedShape class for the center item.
Added a notchRadius parameter to the CustomNotchedShape class to customize the radius of the notched shape.
Updated the app's UI to display the new notched shape in the center of the bottom navigation bar.
For more information, check out the botton_nav_bar package on pub.dev.

In this example, the BottomNavBar widget includes four items:  When the user selects an item, the corresponding screen is displayed.

Overall, the botton_nav_bar library provides a convenient and customizable way to implement a bottom navigation bar in a Flutter application.



 

 
