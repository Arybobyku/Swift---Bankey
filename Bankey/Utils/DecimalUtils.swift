//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 14/09/22.
//

import Foundation

extension Decimal{
    var doubleValue:Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
