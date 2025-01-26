import 'package:flutter/material.dart';

enum PopupMenuPages {
  settings,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
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
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Qual será o próximo filme que iremos assistir?"),
                        SizedBox(height: 15),
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text('Login Page'),
                        ),
                      ]),
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushNamed('/add_movie');
            },
            label: Row(
              children: [Icon(Icons.add), Text('Adicionar filme')],
            ),
          ),
        ),
      ),
    );
  }
}
