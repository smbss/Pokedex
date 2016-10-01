//
//  Pokemon.swift
//  Pokedex
//
//  Created by smbss on 27/09/2016.
//  Copyright © 2016 smbss. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
    
        return _pokedexId
    }

    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
        // Since the download of data is asynchronous it may not be available to populate the labels
        // This way we need to create the typealias DownloadComplete on Constants
        // This will allow the function to know when the download has been completed
    func downloadPokemonDetail(completed: DownloadComplete) {
        
            // Creating the Alamofire get request with the pokemonURL
        Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
            
            print(response.result.value)
            
        }
    }
    
}

