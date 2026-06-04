//
//  GameHistory.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import Foundation

// MARK: - Model

struct GameHistory: Identifiable, Codable {
    
    // MARK: - Stored properties
    
    let id: UUID
    let word: String
    let date: Date
    let isWin: Bool
    
    // MARK: - Initializer
    
    init(word: String, isWin: Bool) {
        self.id = UUID()
        self.word = word
        self.date = Date()
        self.isWin = isWin
    }
}
