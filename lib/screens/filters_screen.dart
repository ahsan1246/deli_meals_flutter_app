import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters_screen';

  final Map<String, bool> filterValData;
  final Function saveFilters;
  const FilterScreen(this.filterValData, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  initState() {
    super.initState();

    print(widget.filterValData['gluten']);
    _glutenFree = widget.filterValData['gluten'];
    _vegetarian = widget.filterValData['vegetarian'];
    _vegan = widget.filterValData['vegan'];
    _lactoseFree = widget.filterValData['lactose'];
  }

  Widget _buildSwitchListTile(
    bool _switchCurrentValue,
    String _switchTitle,
    String _switchSubTitle,
    Function updateValue,
  ) {
    return SwitchListTile.adaptive(
      value: _switchCurrentValue,
      onChanged: updateValue,
      title: Text(_switchTitle),
      subtitle: Text(_switchSubTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.save_rounded),
              onPressed: () {
                widget.saveFilters({
                  "gluten": _glutenFree,
                  "vegetarian": _vegetarian,
                  "vegan": _vegan,
                  "lactose": _lactoseFree,
                });
                Navigator.of(context).pushReplacementNamed('/');
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  _glutenFree,
                  "Gluten-Free",
                  "Only include gluten free meals.",
                  (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  _vegetarian,
                  "Vegetarian",
                  "Only include vegetarian meals.",
                  (val) {
                    setState(() {
                      _vegetarian = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  _vegan,
                  "Vegan",
                  "Only include vegan meals.",
                  (val) {
                    setState(() {
                      _vegan = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  _lactoseFree,
                  "Lactose-Free",
                  "Only include lactose free meals.",
                  (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
