import 'package:flutter/material.dart';
import 'package:Bitesy/features/search_page/presentation/bloc/search_page_bloc.dart';
import '../../../restaurant/widgets/star.dart';
import '../../data/model/restaurant_model.dart';

class RestaurantTile extends StatelessWidget {
  final RestaurantModel restaurantModel;
  final SearchPageBloc restaurantBloc;

  const RestaurantTile(
      {super.key, required this.restaurantBloc, required this.restaurantModel});

  @override
  Widget build(BuildContext context) {
    final int avgRating = double.parse(restaurantModel.avgRating).round();
    return GestureDetector(
      onTap: () => restaurantBloc.add(NavigateToRestaurantPageEvent(restaurantModel)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: 150,
                  child: Stack(children: [
                    Image.network(
                      restaurantModel.images[0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int i = 0; i < avgRating; i++)
                            const Star(
                                width: 25,
                                height: 25,
                                color: Colors.amber,
                                starSize: 20),
                        ],
                      ),
                    ),
                  ])),
                  const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurantModel.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(restaurantModel.numReviews.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          )),
                          const SizedBox(width: 5,),
                      const Icon(Icons.reviews, color: Colors.brown),
                    ],
                  )
                ],
              ),
              Text(
                restaurantModel.address,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
