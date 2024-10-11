import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_meals/providers/filters_providers.dart';

class FiltersScreen extends ConsumerWidget{
  const FiltersScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters = ref.watch(filtersProviders);
   return Scaffold(
    appBar: AppBar(
      title: Text('Your Filters'),
    ),
    body:
        Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked){
              ref
              .read(filtersProviders.notifier)
              .setFilter(Filter.glutenFree, isChecked);
            },
            title:Text('Gluten_Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text('Only include gluten_free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34,right: 22),
          ),
      
      // Switch 2
              SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked){
            ref
            .read(filtersProviders.notifier)
            .setFilter(Filter.lactoseFree, isChecked);
            },
            title:Text('Lactose_Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text('Only include Lactose_free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34,right: 22),
          ),
                      SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked){
                ref
                .read(filtersProviders.notifier)
                .setFilter(Filter.vegetarian, isChecked);
            },
            title:Text('vegetarian',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text('Only include vegetarian meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34,right: 22),
          ),
                      SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked){
              ref
              .read(filtersProviders.notifier)
              .setFilter(Filter.vegan, isChecked);
            },
            title:Text('Vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text('Only include vegan meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34,right: 22),
          ),
        ]
      ),
    );
  }
}
