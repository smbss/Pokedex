//
//  Pokemon.swift
//  Pokedex
//
//  Created by smbss on 27/09/2016.
//  Copyright © 2016 smbss. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
    
        return _pokedexId
    }

    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}

