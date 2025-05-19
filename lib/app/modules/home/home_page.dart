import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/modules/home/home_page_movie_list_tab.dart';
import 'package:cine_log/app/modules/home/sort_options_notifier.dart';
import 'package:cine_log/app/modules/home/widgets/home_drawer.dart';
import 'package:cine_log/app/modules/home/widgets/home_layout_settings_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupMenuPages {
  settings,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SortOptionsNotifier sortNotifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sortNotifier = context.read<SortOptionsNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          title: Text(Messages.appName),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => HomeLayoutSettingsModal(
                    sortNotifier: sortNotifier,
                  ),
                );
              },
              icon: Icon(Icons.sort),
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (PopupMenuPages selected) {
                switch (selected) {
                  case PopupMenuPages.settings:
                    Navigator.of(context).pushNamed('/settings');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<PopupMenuPages>>[
                  PopupMenuItem<PopupMenuPages>(
                    value: PopupMenuPages.settings,
                    child: Text(Messages.settings),
                  )
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              tabs: <Widget>[
                Tab(text: Messages.toWatch),
                Tab(text: Messages.watched),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: const [
                MovieListTab(filter: MovieFilter.toWatch),
                MovieListTab(filter: MovieFilter.watched),
              ],
            )),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushNamed('/find_movie');
            },
            label: Row(
              children: [Icon(Icons.add), Text(Messages.addMovie)],
            ),
          ),
        ),
      ),
    );
  }
}
