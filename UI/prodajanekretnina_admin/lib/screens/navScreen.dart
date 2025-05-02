
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';



class CommonNavigation extends StatelessWidget {
  //const CommonNavigation({super.key});

  final int selectedIndex;
  final Function(int) onItemSelected;
  //final void Function()? refreshKonzola;
  final VoidCallback? refreshKonzolaCallBack;

  const CommonNavigation({super.key, required this.onItemSelected, required this.selectedIndex, this.refreshKonzolaCallBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NavigationRail(
          leading: Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Customize the color of the border
                  width: 2.0, // Customize the thickness of the border
                ),
              )),
              child: Column(children: [
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {
                    // Handle the leading icon button press here.
                  },
                ),
                const Text("Asad Tabak"),
              ])),
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemSelected,
          groupAlignment: -1,
          labelType: NavigationRailLabelType.all,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.dashboard),
              label: Text('Konzola'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.developer_board),
              label: Text('Uređaji'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.task),
              label: Text('Radni zadaci'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Administrator'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: const [
             
           
            ],
          ),
        ),
      ],
    );
  }
}