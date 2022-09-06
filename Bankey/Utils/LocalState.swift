//
//  LocalState.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 06/09/22.
//

import Foundation

public class LocalState{
    
    private enum Keys:String{
        case hasOnBoarded
    }
    
    public static var hasOnBoarded:Bool{
        get{
            return UserDefaults.standard.bool(forKey: Keys.hasOnBoarded.rawValue)
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnBoarded.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
