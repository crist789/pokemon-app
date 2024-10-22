import 'package:flutter/material.dart';
import 'package:pokemon_app/domain/models/pokemon_model.dart';
import 'package:pokemon_app/presentation/pages/details/details_page.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.pokemon,
    required this.nextEvolutions,
  });

  final PokemonModel pokemon;
  final List<PokemonModel> nextEvolutions;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        _goToDetails(context);
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              _nameAndNumber(),
              _typeAndImage(),
            ],
          ),
        ),
      ),
    );
  }

  void _goToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          pokemon: pokemon,
          nextEvolutions: nextEvolutions,
        ),
      ),
    );
  }

  Widget _typeAndImage() {
    return Expanded(
      child: Row(
        children: [
          Expanded(child: _type()),
          Expanded(child: _image()),
        ],
      ),
    );
  }

  Widget _image() {
    return Center(
      child: Image.network(
        pokemon.img,
        height: 100,
        width: 100,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 2)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Column _type() {
    final Map<String, Color> typecolors = {
      'Fire': Colors.red,
      'Water': Colors.blue,
      'Grass': Colors.green,
      'Poison': Colors.purple,
      'Bug': Colors.lightGreen,
      'Ice': Colors.lightBlue.shade200,
      'Flying': Colors.deepPurple.shade200,
      'Psychic': Colors.pink,
      'Normal': Colors.brown.shade100,
      'Electric': Colors.yellow,
      'Ground': Colors.amber.shade300,
      'Rock': Colors.brown,
      'Fighting': Colors.orange,
      'Dragon': Colors.teal.shade200,
      'Ghost': Colors.purple.shade900,
    };
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pokemon.type
          .map(
            (e) => Container(
              decoration: BoxDecoration(
                color: typecolors[e] ?? Colors.black45,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  e,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _nameAndNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              pokemon.name,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            const Text("#"),
            Text(pokemon.num),
          ],
        )
      ],
    );
  }
}
