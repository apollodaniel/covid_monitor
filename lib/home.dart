

import 'package:covid_monitor/AllCountriesTab.dart';
import 'package:covid_monitor/HomeTab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {


  bool isLightTheme = true;
  Icon currentThemeModeIcon = Icon(Icons.dark_mode);

  final _currentThemeShKey = "current_theme";

  late TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configureCurrentTheme();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid monitor"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(onPressed: () {changeTheme();}, icon: currentThemeModeIcon),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              text: "Home",
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "All countries",
              icon: Icon(Icons.people),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTab(),
          AllCountriesTab()
        ],
      )
    );
  }

  configureCurrentTheme()async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    bool _isLightTheme = _sharedPreferences.getBool(_currentThemeShKey) ?? false;
    isLightTheme = _isLightTheme;
    if(_isLightTheme){
      MyApp.of(context)?.changeTheme(ThemeMode.light);
      setState(() {
        currentThemeModeIcon = Icon(Icons.dark_mode);
      });
    }else{
      MyApp.of(context)?.changeTheme(ThemeMode.dark);
      setState(() {
        currentThemeModeIcon = Icon(Icons.light_mode);
      });
    }
  }

  changeTheme()async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    if(isLightTheme){
      MyApp.of(context)?.changeTheme(ThemeMode.dark);
      isLightTheme = false;
      setState(() {
        currentThemeModeIcon = Icon(Icons.light_mode);
      });
    }else{
      MyApp.of(context)?.changeTheme(ThemeMode.light);
      isLightTheme = true;
      setState(() {
        currentThemeModeIcon = Icon(Icons.dark_mode);
      });
    }

    print(await _sharedPreferences.setBool(_currentThemeShKey, isLightTheme));
  }


}
