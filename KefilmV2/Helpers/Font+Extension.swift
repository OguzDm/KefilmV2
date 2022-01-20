//
//  Font+Extension.swift
//  KefilmV2
//
//  Created by Oğuz Demirhan on 18.01.2022.
//

import Foundation
import SwiftUI

extension Font {
    static func avenirNext(size: Int) -> Font {
        return Font.custom("Avenir Next", size: CGFloat(size))
    }
    
    static func avenirNextRegular(size: Int) -> Font {
        return Font.custom("AvenirNext-Regular", size: CGFloat(size))
    }
    
    static func avenirNextItalic(size: Int) -> Font{
        return Font.custom("AvenirNext-Italic",size: CGFloat(size))
    }
}
