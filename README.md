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

A lightweight, customizable navigation bar widget for flutter which can be used as a FAB as well as a fixed Widget where you can change position of FAB with elevation

## Features
    Customization(you can customize nav bar as per your requirement)
 BottomNavyBar

iconSize - the item icon's size
items - navigation items, required more than one item  
selectedIndex - the current item index. Use this to change the selected item. Defaults to zero
onItemSelected - required to listen when an item is tapped it provides the selected item's index
backgroundColor - the navigation bar's background color
showElevation - if false the appBar's elevation will be removed
containerHeight - changes the Navigation Bar's height
selectedColor - Color of a selected index
label - Name of Scrren 
screen - Widget/Screen you want to Show

BottomNavyBarItem

icon - the icon of this item
title - the text that will appear next to the icon when this item is selected
activeColor - the active item's background and text color
inactiveColor - the inactive item's icon color
textAlign - property to change the alignment of the item title
## Getting started

Add the dependency in pubspec.yaml:

## Usage

@override
  Widget build(BuildContext context) => Scaffold(
        drawer: const DrawerWidget(),
        body: BottomNavBar(
          bottomItems: <BottomBarItem>[
            BottomBarItem(
              selectedColor: Colors.green,
              label:  'Screen 1',
              screen: const HomeScreen(),
              selectedIcon: Icons.collections_bookmark_outlined,
            ),
            BottomBarItem(
              selectedColor:Colors.red
              label:  'Screen 2,
              screen: const SearchScreen(),
              selectedIcon: Icons.search_rounded,
            ),
            BottomBarItem(
              selectedColor: Colors.amber
              label:'screen 3',
              selectedIcon: Icons.menu_open_rounded,
              screen: const Screen3()
              
            ),
            BottomBarItem(
              selectedColor: Colors.grey
              label: 'item 4',
              screen: const  'Screen 4,
              selectedIcon: Icons.notifications_active,
            )
          ],
        ),
      );

 
## Additional information

 
