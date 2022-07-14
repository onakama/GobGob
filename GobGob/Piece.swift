//
//  Piece.swift
//  GobGob
//
//  Created by onakama on 2022/07/14.
//

import Foundation

struct Piece {
    var camp: Camp
    var size: Size
    var history: [Size: Camp?] = [.small: nil, .medium: nil]
    
    mutating func historyClear() {
        history = [.small: nil, .medium: nil]
    }
}
