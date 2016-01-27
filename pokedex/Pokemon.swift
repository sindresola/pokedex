//
//  Pokemon.swift
//  pokedex
//
//  Created by sindre teigland on 02/11/15.
//  Copyright © 2015 sindre teigland. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    
    private var _spAtk: String!
    private var _spDef: String!
    private var _hp: String!
    private var _speed: String!
    private var _gender: String!
    
    private var _abilities: [String]!
    
    private var _nextEvolutionTxt: String!
    private var _pokemonUrl: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    
    var name:String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var defense:String{
        
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var spAtk:String{
        
        if _spAtk == nil{
            _spAtk = ""
        }
        return _spAtk
    }
    
    var hp:String{
        if _hp == nil{
            _hp = ""
        }
        
        return _hp
    }
    
    var spDef:String{
        
        if _spDef == nil{
            _spDef = ""
        }
        return _spDef
    }
    
    var speed:String{
        
        if _speed == nil{
            _speed = ""
        }
        return _speed
    }
    
    var description:String{
        
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type:String{
        
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var height:String{
        
        if _height == nil{
            _height = ""
        }else{
            _height = formatString(_height)
        }
        print(_height)
        return _height
    }
    
    var weight:String{
        
        if _weight == nil{
            _weight = ""
        }else{
            _weight = formatString(_weight)
        }
        return _weight
    }
    
    var attack:String{
        
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoTxt:String{
        
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvoId:String{
       
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl:String{
        
        if _nextEvoLvl == nil{
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    init(name: String, pokedexId: Int){
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    
    func formatString(input:String) ->String{
        var val:Double!
        val = Double(input)
        val = val / 10
        return String(val)
    }
    
    func downloadPokemonDetails(completetd: DownloadComplete){
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let hp = dict["hp"] as? Int{
                    self._hp = "\(hp)"
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let sp_def = dict["sp_def"] as? Int{
                    self._spDef = "\(sp_def)"
                }
                
                if let sp_atk = dict["sp_atk"] as? Int{
                    self._spAtk = "\(sp_atk)"
                }
                
                if let speed = dict["speed"] as? Int{
                    self._speed = "\(speed)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }else{
                    self._type = "none"
                }
                
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0{
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                         
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>{
                                if let description = descDict["description"] as? String{
                                    self._description = description
                                   
                                }
                            }
                            
                            completetd()
                        }
                    }else{
                        self._description = ""
                    }
                }
                
              
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                    if let to = evolutions[0]["to"] as? String where to.rangeOfString("mega") == nil{ //no mega support yet
                        
                        if let uri = evolutions[0]["resource_uri"] as? String{
                            
                            let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                            let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                            
                            self._nextEvoId = num
                            self._nextEvolutionTxt = to
                            
                            if let lvl = evolutions[0]["level"] as? Int {
                                self._nextEvoLvl = "\(lvl)"
                            }
                    
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
}