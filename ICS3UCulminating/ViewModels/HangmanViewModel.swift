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
    
    // Match History
    private(set) var gameHistory: [GameHistory] = []
    
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
        
        // Load saved stats and history
        loadStats()
        loadHistory()
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
            
            // Check if this guess ended the game
            if game.isWinner {
                totalWins += 1
                addToHistory(isWin: true)
                saveStats()
            } else if game.isLoser {
                totalLosses += 1
                addToHistory(isWin: false)
                saveStats()
            }
        }
    }
    
    /// Resets the game state with a new word.
    func startNewGame() {
        self.game = WordLoader.startNewGame()
    }
    
    /// Adds the current game result to history.
    private func addToHistory(isWin: Bool) {
        let entry = GameHistory(word: game.currentWord, isWin: isWin)
        // Add to the beginning of the array so most recent is at index 0
        gameHistory.insert(entry, at: 0)
        saveHistory()
    }
    
    /// Resets the persistent win/loss counters and history.
    func resetAllData() {
        totalWins = 0
        totalLosses = 0
        gameHistory = []
        saveStats()
        saveHistory()
    }
    
    // MARK: - Persistence Functions
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func historyFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent("hangman_history.json")
    }
    
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
    
    /// Saves the game history to a JSON file.
    private func saveHistory() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(gameHistory)
            try data.write(to: historyFilePath(), options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to save history: \(error.localizedDescription)")
        }
    }
    
    /// Loads the game history from a JSON file.
    private func loadHistory() {
        let path = historyFilePath()
        if FileManager.default.fileExists(atPath: path.path) {
            do {
                let data = try Data(contentsOf: path)
                let decoder = JSONDecoder()
                gameHistory = try decoder.decode([GameHistory].self, from: data)
            } catch {
                print("Failed to load history: \(error.localizedDescription)")
            }
        }
    }
}
