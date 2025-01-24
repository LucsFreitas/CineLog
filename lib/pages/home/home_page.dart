import 'package:flutter/material.dart';

enum PopupMenuPages {
  settings,
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('CineLog'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
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
                    child: Text('Configurações'),
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
                Tab(text: 'Para assistir'),
                Tab(text: 'Assistidos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child:
                        Text("Qual será o próximo filme que iremos assistir?"),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Nenhum filme assistido ainda :("),
                        Text("Bora mudar isso?")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              Navigator.of(context).pushNamed('/add_movie');
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
