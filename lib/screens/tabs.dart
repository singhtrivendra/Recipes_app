import 'package:flutter/material.dart';
import 'package:order_meals/providers/filters_providers.dart';
import 'package:order_meals/providers/wishlist_provider.dart';
import 'package:order_meals/screens/categories.dart';
import 'package:order_meals/screens/filters.dart';
import 'package:order_meals/screens/meals.dart';
import 'package:order_meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const kInitialFilters= {
Filter.glutenFree : false,
Filter.lactoseFree: false,
Filter.vegetarian:false,
Filter.vegan:false,
};
class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});
  
  @override
  ConsumerState<TabsScreen> createState() {
  return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
int _selectedPageIndex = 0;

void _selectPage(int index){
  setState(() {
    _selectedPageIndex = index;
  });
}

void _setScreen(String identifier) async{
  // common condition
  Navigator.of(context).pop();
  if(identifier == 'filters'){
    await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(
      builder: (ctx)=>  FiltersScreen(),
      ),
      );
  }
}
  @override
    Widget build(BuildContext context) {

      final availableMeals =ref.watch(filteredMealsProvider);
      Widget activePage = CategoriesScreen(
        availableMeals: availableMeals,
        );
    var activePageTitle = 'Categories';
      if(_selectedPageIndex == 1){
        final favoriteMeals = ref.watch(favoriteMealsProvider);
        activePage =  MealsScreen(
        meals: favoriteMeals, 
        );  
        activePageTitle = 'Wishlist';
      }
   return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal,),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Wishlist'),
        ],
        ),
   );
  } 
}