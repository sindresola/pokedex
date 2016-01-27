//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by sindre teigland on 02/11/15.
//  Copyright © 2015 sindre teigland. All rights reserved.
//

import UIKit
import YLProgressBar

class PokemonDetailVC: UIViewController {

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!
   
    @IBOutlet var hpLbl: UILabel!
    @IBOutlet var hpStat: YLProgressBar!
   
    @IBOutlet var attackLbl: UILabel!
    @IBOutlet var attackStat: YLProgressBar!
    
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var defenseStat: YLProgressBar!
   
    @IBOutlet var spAtkLbl: UILabel!
    @IBOutlet var spAtkStat: YLProgressBar!
    
    @IBOutlet var spDefLbl: UILabel!
    @IBOutlet var spDefStat: YLProgressBar!
    
    @IBOutlet var speedLbl: UILabel!
    @IBOutlet var speedStat: YLProgressBar!
    
    @IBOutlet var totalLbl: UILabel!

    @IBOutlet var ability1Btn: UIButton!
    @IBOutlet var ability2Btn: UIButton!
    @IBOutlet var ability3Btn: UIButton!
    
    @IBOutlet var egg1Btn: UIButton!
    @IBOutlet var egg2Btn: UIButton!
    @IBOutlet var egg3Btn: UIButton!
  
    @IBOutlet var pokedexIdLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!

    @IBOutlet var heightLbl: UILabel!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        //currentEvoImg.image = img
        

        //mainImg.image = UIImage.gifWithName("\(pokemon.pokedexId)")
        
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done
            self.updateUi()
        }
    }
    func updateUi (){
        //descriptLbl.text = pokemon.description
        //typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        defenseStat.progress = progressValue(pokemon.defense)
        attackLbl.text = pokemon.attack
        attackStat.progress = progressValue(pokemon.attack)
        weightLbl.text = pokemon.weight + " Kg"
        heightLbl.text = pokemon.height + " m"
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        spAtkLbl.text = pokemon.spAtk
        spAtkStat.progress = progressValue(pokemon.spAtk)
        hpLbl.text = pokemon.hp
        hpStat.progress = progressValue(pokemon.hp)
        spDefLbl.text = pokemon.spDef
        spDefStat.progress = progressValue(pokemon.spDef)
        speedLbl.text = pokemon.speed
        speedStat.progress = progressValue(pokemon.speed)
        
        
        
        /*if pokemon.nextEvoId == "" {
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
        }*/
        
        
        
    }
    
    func progressValue(inpValue: String) ->CGFloat{
        var input: Double!
        input = Double(inpValue)

        return CGFloat(input) / 255
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
  
    
    
   
}
