import 'package:flutter/material.dart';
import 'package:voice_recorder/Modules/Module_2_Recorder/UI/recorder.dart';
import 'package:voice_recorder/Modules/Module_3_Player/UI/player.dart';
import 'package:voice_recorder/Modules/Module_4_Settings/UI/settings.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _appBarTitle = 'Recorder';
  List<Widget> _appBarActions = [
    IconButton(
        icon: const Icon(
          Icons.more_vert,
          color: whiteColor,
        ),
        onPressed: () {})
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _updateAppBar(_tabController.index);
        });
      }
    });
  }

  void _updateAppBar(int index) {
    switch (index) {
      case 0:
        _appBarTitle = 'Recorder';
        _appBarActions = [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
            onPressed: () {
              // Handle mic icon press
            },
          ),
        ];
        break;
      case 1:
        _appBarTitle = 'Player';
        _appBarActions = [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: whiteColor,
            ),
            onPressed: () {
              // Handle play icon press
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
            onPressed: () {
              // Handle pause icon press
            },
          ),
        ];
        break;
      case 2:
        _appBarTitle = 'Settings';
        _appBarActions = [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
            onPressed: () {
              // Handle settings icon press
            },
          ),
        ];
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRedColor,
        elevation: 5,
        title: Text(
          _appBarTitle,
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        actions: _appBarActions,
        shadowColor: greyColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: whiteColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          tabs: [
            Tab(
              icon: Icon(
                _tabController.index == 0 ? Icons.mic : Icons.mic_none,
                size: _tabController.index == 0 ? 28 : 22,
                color: whiteColor,
              ),
            ),
            Tab(
              icon: Icon(
                _tabController.index == 1
                    ? Icons.play_arrow
                    : Icons.play_arrow_outlined,
                size: _tabController.index == 1 ? 28 : 22,
                color: whiteColor,
              ),
            ),
            Tab(
              icon: Icon(
                _tabController.index == 2
                    ? Icons.settings
                    : Icons.settings_outlined,
                size: _tabController.index == 2 ? 28 : 22,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Recorder(),
          Player(),
          Settings(),
        ],
      ),
    );
  }
}
