//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by sindre teigland on 02/11/15.
//  Copyright © 2015 sindre teigland. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class PokemonDetailVC: UIViewController {

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var descriptLbl: UILabel!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var pokedexIdLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var baseAttackLbl: UILabel!
    @IBOutlet var currentEvoImg: UIImageView!
    @IBOutlet var nextEvoImg: UIImageView!
    @IBOutlet var evoLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        

        //mainImg.image = UIImage.gifWithName("\(pokemon.pokedexId)")
        
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done
            self.updateUi()
        }
    }
    func updateUi (){
        descriptLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        baseAttackLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            var str = "Next Evolution: \(pokemon.nextEvoTxt)"
            print(pokemon.nextEvoTxt)
            print(pokemon.nextEvoLvl)
            if pokemon.nextEvoLvl != "" {
                str += " - LVL \(pokemon.nextEvoLvl)"
            }
            evoLbl.text = str
        }
        
        
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
  
    
    
   
}
