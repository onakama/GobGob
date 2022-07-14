//
//  GobGobModel.swift
//  GobGob
//
//  Created by onakama on 2022/07/14.
//

import Foundation

struct GobGobModel {
    var board: [[Piece?]]
    
    init() {
        board = [
            [nil, nil ,nil],
            [nil, nil ,nil],
            [nil, nil, nil]
        ]
    }
    
    //駒配置
    mutating func push(piece: Piece, to: (Int, Int)) -> Bool{
        let cell = to
        var piece = piece
        piece.historyClear()
        if board[cell.0][cell.1] == nil {
            //任意の位置に駒なし
            board[cell.0][cell.1] = piece
            return true
        } else if compare(cell: cell, piece: piece) {
            //任意の位置に駒があり、サイズ比較
            let tempPiece = board[cell.0][cell.1]!
            piece.history = tempPiece.history
            piece.history[tempPiece.size] = tempPiece.camp
            board[cell.0][cell.1] = piece
            return true
        } else {
            print("配置なし")
            return false
        }
    }
    
    mutating func move(from: (Int, Int), to: (Int, Int)) -> Bool {
        guard let fromPiece = board[from.0][from.1] else { return false }
        let result = push(piece: fromPiece, to: to)
        if result == true {
            let pulled = pull(piece: fromPiece)
            board[from.0][from.1] = pulled
            return true
        } else {
            return false
        }
    }
    
    private func pull(piece: Piece) -> Piece? {
        var piece = piece
        if piece.history[.medium]! != nil {
            piece.size = .medium
            piece.camp = piece.history[.medium]!!
            piece.history[.medium]! = nil
            return piece
        } else if piece.history[.small]! != nil {
            piece.size = .small
            piece.camp = piece.history[.small]!!
            piece.history[.small]! = nil
            return piece
        } else {
            return nil
        }
    }
    
    //サイズ比較
    mutating func compare(cell: (Int, Int), piece: Piece) -> Bool {
        let sizeArray: [Size] = Size.allCases
        let pieceSize = sizeArray.firstIndex(of: piece.size)!
        let tempPieceSize = sizeArray.firstIndex(of: board[cell.0][cell.1]!.size)!
        
        if tempPieceSize == pieceSize {
            print("サイズ比較：同一")
            return false
        } else if tempPieceSize < pieceSize {
            return true
        } else {
            print("サイズ比較：小さい")
            return false
        }
    }
    
    func judge() -> Camp? {
        //横判定
        for i in 0...2 {
            guard let piece = board[i][0] else { break }
            if piece.camp == board[i][1]?.camp && piece.camp == board[i][2]?.camp {
                return piece.camp
            }
        }
        
        //縦判定
        for i in 0...2 {
            guard let piece = board[0][i] else { break }
            if piece.camp == board[1][i]?.camp && piece.camp == board[2][i]?.camp {
                return piece.camp
            }
        }
        
        //斜め判定
        guard let piece = board[1][1] else { return nil }
        if piece.camp == board[0][0]?.camp && piece.camp == board[2][2]?.camp {
            return piece.camp
        } else if piece.camp == board[0][2]?.camp && piece.camp == board[2][0]?.camp {
            return piece.camp
        }
        return nil
    }
    
    func pri() {
        print("")
        print("********************")
        for x in 0...2 {
            print("| \(hoge(piece: board[x][0]))\(huga(piece: board[x][0])) | \(hoge(piece: board[x][1]))\(huga(piece: board[x][1])) | \(hoge(piece: board[x][2]))\(huga(piece: board[x][2]))")
        }
        print("********************")
        print("")
        
        func hoge(piece: Piece?) -> String {
            guard let piece = piece else { return "??" }
            switch piece.camp {
            case .blue:
                return "青"
            case .orange:
                return "橙"
            }
        }
        func huga(piece: Piece?) -> String {
            guard let piece = piece else { return "??" }
            switch piece.size {
            case .large:
                return "大"
            case .medium:
                return "中"
            case .small:
                return "小"
            }
        }
    }
    
}
