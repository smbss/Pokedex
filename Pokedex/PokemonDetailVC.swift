//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Sandro Simes on 29/09/2016.
//  Copyright © 2016 smbss. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
    }
}