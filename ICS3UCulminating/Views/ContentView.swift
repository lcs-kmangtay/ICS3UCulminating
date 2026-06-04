//
//  ContentView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import SwiftUI

// MARK: - View

struct ContentView: View {
    
    // MARK: - Stored properties
    
    // The view model to manage game state
    @State var viewModel = HangmanViewModel()
    
    // QWERTY keyboard layout rows
    let row1: [Character] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let row2: [Character] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    let row3: [Character] = ["Z", "X", "C", "V", "B", "N", "M"]
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 0) {
            
            // --- Top Section: Gallows ---
            VStack {
                GallowsView(incorrectGuessesCount: viewModel.incorrectGuessesCount)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            
            Spacer()
            
            // --- Middle Section: Word Display ---
            VStack {
                // Status Message
                if viewModel.isWinner {
                    Text("🎉 You Won! 🎉")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .transition(.scale)
                } else if viewModel.isLoser {
                    Text("💀 Game Over! 💀")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .transition(.scale)
                } else {
                    Text("Guess the Word")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                WordDisplayView(word: viewModel.currentWord, 
                               guessedLetters: viewModel.guessedLetters)
                
                if viewModel.isLoser {
                    Text("The word was: \(viewModel.currentWord)")
                        .font(.title3)
                        .foregroundColor(.orange)
                        .padding(.top, 5)
                }
            }
            
            Spacer()
            
            // --- Bottom Section: QWERTY Keyboard ---
            VStack(spacing: 12) {
                // Row 1
                keyboardRow(row1)
                
                // Row 2
                keyboardRow(row2)
                
                // Row 3 (Includes New Game button for convenience)
                HStack(spacing: 8) {
                    keyboardRow(row3)
                    
                    // New Game Button
                    Button(action: {
                        viewModel.startNewGame()
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    .help("Start New Game")
                }
            }
            .padding(.bottom, 30)
            
            // Session Stats (Moved to bottom small text to keep main UI clean)
            HStack {
                Text("Wins: \(viewModel.totalWins)")
                Spacer()
                Text("Losses: \(viewModel.totalLosses)")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
        }
        .padding(30) // Main layout padding
        .frame(minWidth: 800, minHeight: 700)
    }
    
    // MARK: - Helper Views
    
    /// Creates a row of keyboard buttons
    func keyboardRow(_ characters: [Character]) -> some View {
        HStack(spacing: 8) {
            ForEach(characters, id: \.self) { letter in
                Button(action: {
                    viewModel.submitGuess(letter)
                }) {
                    Text(String(letter))
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 44, height: 50)
                        .background(buttonColor(for: letter))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                }
                .disabled(viewModel.guessedLetters.contains(letter) || viewModel.isWinner || viewModel.isLoser)
                .buttonStyle(.plain)
            }
        }
    }
    
    // MARK: - Functions
    
    /// Determines the color of a keyboard button based on its guess status.
    func buttonColor(for letter: Character) -> Color {
        // If the letter hasn't been guessed yet
        if viewModel.guessedLetters.contains(letter) == false {
            return .blue
        }
        
        // If it was guessed and is in the word (Correct)
        if viewModel.currentWord.contains(letter) {
            return .green
        }
        
        // If it was guessed but is NOT in the word (Incorrect)
        return .gray.opacity(0.4)
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
