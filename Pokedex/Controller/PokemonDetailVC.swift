//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by smbss on 29/09/2016.
//  Copyright © 2016 smbss. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")

        nameLbl.text = pokemon.name.capitalized
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetail { 
                // This is the closure of the typealias DownloadCompleted
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        pokedexLbl.text = "\(pokemon.pokedexId)"
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No more evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            evoLbl.text = "Next Evolution: \(pokemon.nextEvolutionName) - \(pokemon.nextEvolutionLevel)"
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
