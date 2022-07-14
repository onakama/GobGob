//
//  HandModel.swift
//  GobGob
//
//  Created by onakama on 2022/07/14.
//

import Foundation

struct Hand {
    var largePieceList: PieceList
    var mediumPieceList: PieceList
    var smallPieceList: PieceList
    
    
    init(camp: Camp) {
        largePieceList = PieceList(size: .large, camp: camp)
        mediumPieceList = PieceList(size: .medium, camp: camp)
        smallPieceList = PieceList(size: .small, camp: camp)
    }
    
    mutating func get(size: Size) -> Piece {
        switch size {
        case .large:
            return largePieceList.list.removeFirst()
        case .medium:
            return mediumPieceList.list.removeFirst()
        case .small:
            return smallPieceList.list.removeFirst()
        }
    }
    
    mutating func set(piece: Piece) {
        let piece = piece
        switch piece.size {
        case .large:
            largePieceList.list.append(piece)
        case .medium:
            mediumPieceList.list.append(piece)
        case .small:
            smallPieceList.list.append(piece)
        }
    }
}
