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
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        
        return _nextEvolutionTxt
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        
        return _nextEvolutionLevel
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        
        return _attack
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }

    var type: String {
        
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
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
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
            // Creating the Alamofire get request with the pokemonURL
        Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["weight"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                    // Creating the array for types and making sure it is bigger than 0
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                        // If there is more than one type we are going to add it too
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    
                } else {
                    
                    self._type = ""
                }
                
                    // There are different descriptions, we are only interested in the first
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                            // The description is inside an URL so we need another request
                        Alamofire.request(descURL, method: .get).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    
                                    self._description = newDescription
                                }
                            }
                            
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                            // Excluding mega evolutions
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                                // Extracting the next evo id from the evolution url
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                    // Checking if the next evo level exists
                                if let lvlExist = evolutions[0]["level"] as? Int {
                                    
                                    self._nextEvolutionLevel = "LVL \(lvlExist)"
                                    
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                        
                    }
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)

            }
            
            completed()
        }
        
    }
    
}

