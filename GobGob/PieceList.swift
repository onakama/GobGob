//
//  PieceList.swift
//  GobGob
//
//  Created by onakama on 2022/07/14.
//

import Foundation

struct PieceList {
    var list: [Piece]
    
    init(size: Size, camp: Camp) {
        list = []
        list.append(Piece(camp: camp, size: size))
        list.append(Piece(camp: camp, size: size))
    }
}
