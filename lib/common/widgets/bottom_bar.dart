import 'package:flutter/material.dart';
import 'package:hisab/features/note/screens/note_screen.dart';
import 'package:hisab/features/profile/screens/profile_screen.dart';

import 'package:hisab/features/shared_sheet/screens/shared_sheet_screen.dart';

import '/constants/global_variables.dart';
import '../../features/home/screens/sheet_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 40;


  List<Widget> pages = [
    const SheetScreen(),
    const SharedSheetScreen(),
    const NoteScreen(),
    const ProfileScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.primaryColour,
        unselectedItemColor: GlobalVariables.primaryColour,
        backgroundColor: GlobalVariables.primaryColour,
        iconSize: 28,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: _page == 0
                  ? const Icon(
                      Icons.home,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
            ),
            label: '',
          ),
          //Account
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: _page == 1
                  ? const Icon(
                      Icons.folder_shared,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.folder_shared_outlined,
                      color: Colors.white,
                    ),
            ),
            label: '',
          ),
          //Cart
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: _page == 2
                  ? const Icon(
                      Icons.note,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.note_outlined,
                      color: Colors.white,
                    ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: _page == 3
                  ? const Icon(
                      Icons.person,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.person_outline_outlined,
                      color: Colors.white,
                    ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
