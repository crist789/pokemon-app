import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/domain/models/pokemon_model.dart';
import 'package:pokemon_app/presentation/widgets/card_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<PokemonModel>? pokemons;
  List<PokemonModel>? filteredPokemons;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final pokemonList = await fetchData();
    setState(() {
      pokemons = pokemonList;
      filteredPokemons = pokemonList;
    });
  }

  Future<List<PokemonModel>> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    String json = await rootBundle.loadString('db/data.json');
    var decodedJson = jsonDecode(json);
    var pokemons = (decodedJson['pokemon'] as List)
        .map((e) => PokemonModel.fromJson(e))
        .toList();
    return pokemons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _appbar(),
              _list(),
            ],
          ),
          _search(),
        ],
      ),
    );
  }

  Positioned _search() {
    return Positioned(
      top: 50,
      left: 10,
      right: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 100,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: Colors.black12,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextFormField(
                  onChanged: _pokemonSearch,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _appbar() {
    return Container(
      height: 180,
      color: Colors.blue,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _pokedex(),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _button() {
    return IconButton(
      onPressed: () {},
      icon: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipOval(
              child: Container(
                color: Colors.white,
                height: 30,
                width: 30,
                child: const Icon(
                  Icons.light_mode,
                  color: Colors.amber,
                ),
              ),
            ),
            const Text(
              "LIGTH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pokedex() {
    return const Text(
      "Pokedex",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _list() {
    final pokesList = filteredPokemons;
    return Expanded(
      child: pokesList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _gridView(
              pokesList,
            ),
    );
  }

  Widget _gridView(List<PokemonModel> pokemons) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.3, crossAxisSpacing: 10,
          mainAxisSpacing: 10, // Número de columnas
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          var pokemon = pokemons[index];
          var nextEvolutions = pokemon.nextEvolution;
          final nextEvolutionsList =
              _getNextEvolutions(nextEvolutions, pokemons);

          return CardWidget(
              pokemon: pokemon, nextEvolutions: nextEvolutionsList);
        },
      ),
    );
  }

  List<PokemonModel> _getNextEvolutions(
    List<Evolution>? nextEvolutions,
    List<PokemonModel> pokemons,
  ) {
    List<PokemonModel> pokemonList = [];

    if (nextEvolutions == null) return pokemonList;

    for (var next in nextEvolutions) {
      var nextEvolutionIndex =
          pokemons.indexWhere((pokemon) => pokemon.num == next.num);
      if (nextEvolutionIndex != -1) {
        final nextEvol = pokemons[nextEvolutionIndex];
        pokemonList.add(nextEvol);
      }
    }

    return pokemonList;
  }

  void _pokemonSearch(String value) {
    List<PokemonModel>? newlist;
    if (value.isEmpty) {
      newlist = pokemons;
    } else {
      newlist = pokemons
          ?.where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredPokemons = newlist;
    });
  }
}
