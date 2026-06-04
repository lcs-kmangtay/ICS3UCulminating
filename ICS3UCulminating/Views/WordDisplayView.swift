//
//  WordDisplayView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import SwiftUI

// MARK: - View

struct WordDisplayView: View {
    
    // MARK: - Stored properties
    
    // The word to display
    let word: String
    
    // The letters that have been guessed
    let guessedLetters: [Character]
    
    // MARK: - Computed properties
    
    // Convert the word into an array of characters for the ForEach loop
    var wordLetters: [Character] {
        var letters: [Character] = []
        for character in word {
            letters.append(character)
        }
        return letters
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<wordLetters.count, id: \.self) { index in
                let letter = wordLetters[index]
                
                VStack(spacing: 4) {
                    // Show the letter if it's in the guessed letters array, otherwise show a space
                    if guessedLetters.contains(letter) {
                        Text(String(letter))
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                    } else {
                        Text(" ")
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                    }
                    
                    // The underline
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 30, height: 4)
                }
            }
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    VStack {
        // Not guessed yet
        WordDisplayView(word: "SWIFT", guessedLetters: [])
        
        // Partially guessed
        WordDisplayView(word: "SWIFT", guessedLetters: ["S", "I"])
        
        // Fully guessed
        WordDisplayView(word: "SWIFT", guessedLetters: ["S", "W", "I", "F", "T"])
    }
}
