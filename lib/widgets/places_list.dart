import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/screens/places_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
    required this.onRemovePlace,
  });

  final List<Place> places;
  final void Function(Place place) onRemovePlace;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(places[index]),
        onDismissed: (direction) => onRemovePlace(places[index]),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.background,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete_sweep,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        child: ListTile(
          minVerticalPadding: 8,
          leading: Hero(
            tag: places[index].id,
            child: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(places[index].image),
            ),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            places[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlacesDetailScreen(place: places[index]),
            ));
          },
        ),
      ),
    );
  }
}
