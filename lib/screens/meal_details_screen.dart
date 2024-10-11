import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_meals/models/meals.dart';
import 'package:order_meals/providers/wishlist_provider.dart';

class MealDetailsScreen extends ConsumerWidget{
  const MealDetailsScreen({
    super.key, 
    required this.meal, 
    // required this.onToggleFavorite
    });

final Meal meal;
// final void Function(Meal meal) onToggleFavorite;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(
            onPressed: (){
              // onToggleFavorite(meal);
             final wasAdded = ref
              .read(favoriteMealsProvider.notifier)
              .toggleMealFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                          wasAdded ? 'Meal added to wishlist'
                          : 'Meal removed'
                          ),
          ),
      );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(microseconds: 300),
              transitionBuilder: (child, animation){
                return RotationTransition(
                  turns: Tween<double>(begin: 0.3,end: 1.0).animate(animation),  // dont take int val for begin and end
                  child: child,
                  );
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
              ),
              ) ,
            ),
        ],
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                        meal.imageUrl,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        ),
            ),
        
          SizedBox(height: 14),
        
          Text('Ingredients',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
          ),),
        
          SizedBox(height: 14),
        
          for(final ingredients in meal.ingredients)
          Text(ingredients,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface),
                ),
        
                SizedBox(height: 24),
        
                Text('Steps',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                  ),
                ),
        
                  SizedBox(height: 24),
        
                for(final steps in meal.steps)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            child: Text(
              textAlign: TextAlign.center,
              steps,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface),
                  ),
          ),
          ],
        ),
      )
    );
  }
}