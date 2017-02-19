# ![](http://i.imgur.com/NXjVOrT.png) Pokedex

This is a Pokedex app that uses [Alamofire](https://github.com/Alamofire/Alamofire) to connect to [PokeAPI](https://pokeapi.co/docsv1/) and retrieve relevant stats and data for 718 pokemon. Pokemons are presented in a UICollectionView and can be filtered through the UISearchBar. In order to prevent a high volume of API requests a CVS file with basic pokemon info is parsed and used to reduce network calls. Background music is optional.
![](http://g.recordit.co/36u02Apubh.gif)

### Future Improvements
* Update to PokeAPI V2
* Implement retrieval of moves/attacks
* Improve error handling and logic
* Handle network requests on a different class
