//
//  HangmanGame.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import Foundation

// MARK: - Model

struct HangmanGame {
    
    // MARK: - Stored properties
    
    // The word that the player is trying to guess
    let currentWord: String
    
    // A list of letters that the player has already guessed
    var guessedLetters: [Character] = []
    
    // The maximum number of incorrect guesses allowed before the game is lost
    let maxIncorrectGuesses: Int
    
    // MARK: - Computed properties
    
    // The number of incorrect guesses made so far
    var incorrectGuessesCount: Int {
        var count: Int = 0
        for letter in guessedLetters {
            // Check if the guessed letter is NOT in the current word
            // We use uppercase comparison to ensure it's case-insensitive
            let upperLetter = String(letter).uppercased()
            if currentWord.uppercased().contains(upperLetter) == false {
                count += 1
            }
        }
        return count
    }
    
    // Whether the game has been won
    var isWinner: Bool {
        for letter in currentWord {
            let upperLetter = letter.uppercased()
            if guessedLetters.contains(Character(upperLetter)) == false {
                return false
            }
        }
        return true
    }
    
    // Whether the game has been lost
    var isLoser: Bool {
        return incorrectGuessesCount >= maxIncorrectGuesses
    }
    
    // MARK: - Initializer
    
    init(currentWord: String, maxIncorrectGuesses: Int = 7) {
        self.currentWord = currentWord.uppercased()
        self.maxIncorrectGuesses = maxIncorrectGuesses
    }
    
    // MARK: - Functions
}

// MARK: - Word Loader

struct WordLoader {
    
    // MARK: - Functions
    
    /// Loads a list of words from a JSON file in the app bundle.
    /// - Returns: An array of strings representing the secret words.
    static func loadSecretWords() -> [String] {
        // Locate the JSON file in the main bundle
        guard let url = Bundle.main.url(forResource: "Words", withExtension: "json") else {
            return ["SWIFT"]
        }
        
        // Attempt to load the data from the file
        do {
            let data = try Data(contentsOf: url)
            
            // Decode the JSON data into an array of strings
            let decoder = JSONDecoder()
            let words = try decoder.decode([String].self, from: data)
            
            return words
        } catch {
            return ["SWIFT"]
        }
    }
    
    /// Starts a new game of Hangman by picking a random word.
    /// - Returns: A new HangmanGame instance.
    static func startNewGame() -> HangmanGame {
        let allWords = loadSecretWords()
        
        // Pick a random word from the list
        if let randomWord = allWords.randomElement() {
            return HangmanGame(currentWord: randomWord)
        } else {
            return HangmanGame(currentWord: "SWIFT")
        }
    }
}
