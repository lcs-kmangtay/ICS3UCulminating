//
//  HangmanViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import Foundation
import Observation

// MARK: - View Model

@Observable
class HangmanViewModel {
    
    // MARK: - Stored properties
    
    // The underlying game model
    private(set) var game: HangmanGame
    
    // Persistent stats
    private(set) var totalWins: Int = 0
    private(set) var totalLosses: Int = 0
    
    // MARK: - Computed properties
    
    // Expose game properties for the view
    var currentWord: String {
        return game.currentWord
    }
    
    var guessedLetters: [Character] {
        return game.guessedLetters
    }
    
    var incorrectGuessesCount: Int {
        return game.incorrectGuessesCount
    }
    
    var maxIncorrectGuesses: Int {
        return game.maxIncorrectGuesses
    }
    
    var isWinner: Bool {
        return game.isWinner
    }
    
    var isLoser: Bool {
        return game.isLoser
    }
    
    // MARK: - Initializer
    
    init() {
        // Start a new game using the helper
        self.game = WordLoader.startNewGame()
        
        // Load saved stats
        loadStats()
    }
    
    // MARK: - Functions
    
    /// Processes a letter guess from the user.
    /// - Parameter letter: The character guessed.
    func submitGuess(_ letter: Character) {
        // Don't process if the game is already over
        if game.isWinner || game.isLoser {
            return
        }
        
        // Ensure the letter is uppercase for consistency
        let upperLetter = Character(String(letter).uppercased())
        
        // Check if the letter was already guessed
        var alreadyGuessed: Bool = false
        for existingLetter in game.guessedLetters {
            if existingLetter == upperLetter {
                alreadyGuessed = true
                break
            }
        }
        
        // Only add if it's a new guess
        if alreadyGuessed == false {
            game.guessedLetters.append(upperLetter)
            
            // Check if this guess ended the game and update stats
            if game.isWinner {
                totalWins += 1
                saveStats()
            } else if game.isLoser {
                totalLosses += 1
                saveStats()
            }
        }
    }
    
    /// Resets the game state with a new word.
    func startNewGame() {
        self.game = WordLoader.startNewGame()
    }
    
    /// Resets the persistent win/loss counters.
    func resetStats() {
        totalWins = 0
        totalLosses = 0
        saveStats()
    }
    
    // MARK: - Persistence Functions
    
    /// Saves the current win/loss counts to UserDefaults.
    private func saveStats() {
        let defaults = UserDefaults.standard
        defaults.set(totalWins, forKey: "HangmanTotalWins")
        defaults.set(totalLosses, forKey: "HangmanTotalLosses")
    }
    
    /// Loads the win/loss counts from UserDefaults.
    private func loadStats() {
        let defaults = UserDefaults.standard
        totalWins = defaults.integer(forKey: "HangmanTotalWins")
        totalLosses = defaults.integer(forKey: "HangmanTotalLosses")
    }
}
