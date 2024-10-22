import 'package:flutter/material.dart';
import 'package:pokemon_app/domain/models/pokemon_model.dart';

class DetailsPage extends StatelessWidget {
  final PokemonModel pokemon;
  final List<PokemonModel> nextEvolutions;

  DetailsPage({super.key, required this.pokemon, required this.nextEvolutions});
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
  @override
  Widget build(BuildContext context) {
    String firstType = pokemon.type.isNotEmpty ? pokemon.type[0] : 'unknown';
    Color backgroundColor = typecolors[firstType] ?? Colors.amberAccent;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: _backButton(context),
          ),
          _cardDetails(),
          _pokemonImage(),
        ],
      ),
    );
  }

  Padding _pokemonImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Image.network(pokemon.img, height: 300, width: 400),
    );
  }

  Padding _cardDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 300,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 80,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              _name(),
              const SizedBox(height: 20),
              _heigth(),
              _weigth(),
              const SizedBox(height: 20),
              _typesTitle(),
              _types(),
              _weaknessTitle(),
              _weakness(),
              const SizedBox(height: 20),
              _nextEvolutionsTitle(),
              _nextEvolutions(),
            ],
          ),
        ),
      ),
    );
  }

  Text _nextEvolutionsTitle() {
    return const Text(
      "Next Evolutions",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        fontFamily: 'verdana',
      ),
    );
  }

  Widget _weakness() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pokemon.weaknesses.map((e) => _itemColor(e)).toList(),
      ),
    );
  }

  Text _weaknessTitle() {
    return const Text(
      "Weakness",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        fontFamily: 'verdana',
      ),
    );
  }

  Widget _types() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pokemon.type.map((e) => _itemColor(e)).toList(),
      ),
    );
  }

  Padding _itemColor(String e) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: typecolors[e] ?? Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            e,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Text _typesTitle() {
    return const Text(
      "Types",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        fontFamily: 'verdana',
      ),
    );
  }

  Text _weigth() {
    return Text(
      "Weigth:${pokemon.weight} ",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _heigth() {
    return Text(
      "Heigth: ${pokemon.height}",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Row _name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          pokemon.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontFamily: 'verdana',
          ),
        ),
        const Text(
          " #",
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            fontFamily: 'verdana',
          ),
        ),
        Text(
          pokemon.num,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            fontFamily: 'verdana',
          ),
        ),
      ],
    );
  }

  Widget _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget _nextEvolutions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: nextEvolutions
            .map(
              (poke) => Image.network(
                poke.img,
                height: 80,
                width: 80,
              ),
            )
            .toList(),
      ),
    );
  }
}
