import 'package:flutter/material.dart';
import 'package:order_meals/data/dummy_data.dart';
import 'package:order_meals/models/category.dart';
import 'package:order_meals/models/meals.dart';
import 'package:order_meals/screens/meals.dart';
import 'package:order_meals/widgets/category_grid_item.dart';
class CategoriesScreen extends StatefulWidget{
  const CategoriesScreen({
    super.key,
    // required this.onToggleFavorite, 
    required this.availableMeals
    });
  
// final void Function(Meal meal) onToggleFavorite;
final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{
   late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
      lowerBound: 0,
      upperBound: 1,
      );
      _animationController.forward();  // to start animation 
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context,Category category){
  final filteredMeals = widget.availableMeals
  .where((meals) => meals.categories.contains(category.id))
  .toList();
  //  M-1 ->  Navigator.of(context).push(route),
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeals, 
        //onToggleFavorite: onToggleFavorite,
        ),
      ),);
  }

  @override
  Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: _animationController,
    child: GridView(
            padding: EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:3/2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              ),
            children: [
              // availableCategories.map((category) => CategoryGridItem(category: category))
                  for(final category in availableCategories)
                  CategoryGridItem(category: category, 
                  onSelectCategory: () {
                    _selectCategory(context,category); 
                    },)
            ],
            ),
    // builder: (context,child) => Padding(
    //   padding: EdgeInsets.only(
    //     top:100 - _animationController.value * 100,
    //   ),
    //   child: child,
    //   )
    builder: (context,child) => SlideTransition(
      position: Tween(
          begin: Offset(0, 0.3),
          end:Offset(0, 0) ,
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut)),
      child: child,)
      );
  }
}