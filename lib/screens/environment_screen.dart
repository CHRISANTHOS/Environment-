import 'package:flutter/material.dart';
import 'chat_screen.dart';

class EnvironmentScreen extends StatefulWidget {
  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _routesOptions = <Widget>[
    EnvironmentScreen(),
    ChatScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EnvHub'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Refresh"),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Log Out"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  //TODO: ADD REFRESH CODE
                }else if(value == 1){
                  //TODO: ADD LOGOUT CODE
                }
              }
          ),
        ],
      ),
      body: _routesOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      ),
    );
  }
}
