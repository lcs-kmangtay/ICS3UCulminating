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
            .padding(.top, 10)
            
            Spacer()
            
            // --- Middle Section: Word Display ---
            VStack(spacing: 15) {
                // Status Message
                if viewModel.isWinner {
                    Text("🎉 You Won! 🎉")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                } else if viewModel.isLoser {
                    Text("💀 Game Over! 💀")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                } else {
                    Text("Guess the Word")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                WordDisplayView(word: viewModel.currentWord, 
                               guessedLetters: viewModel.guessedLetters)
                
                if viewModel.isLoser {
                    Text("The word was: \(viewModel.currentWord)")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            // --- Bottom Section: Compact QWERTY Keyboard ---
            VStack(spacing: 8) {
                // Row 1
                keyboardRow(row1)
                
                // Row 2
                keyboardRow(row2)
                
                // Row 3 (Includes New Game button)
                HStack(spacing: 6) {
                    keyboardRow(row3)
                    
                    Button(action: {
                        viewModel.startNewGame()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.blue.opacity(0.15))
                                .frame(width: 40, height: 42)
                            
                            Image(systemName: "arrow.clockwise")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
            
            // Session Stats
            HStack {
                Label("Wins: \(viewModel.totalWins)", systemImage: "trophy.fill")
                Spacer()
                Label("Losses: \(viewModel.totalLosses)", systemImage: "xmark.circle.fill")
            }
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.secondary)
            .padding(.horizontal, 50)
            .padding(.bottom, 15)
        }
        .padding(20)
        .frame(minWidth: 700, minHeight: 650)
        .background(Color.primary.opacity(0.05))
    }
    
    // MARK: - Helper Views
    
    /// Creates a row of compact keyboard buttons
    func keyboardRow(_ characters: [Character]) -> some View {
        HStack(spacing: 6) {
            ForEach(characters, id: \.self) { letter in
                Button(action: {
                    viewModel.submitGuess(letter)
                }) {
                    Text(String(letter))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 36, height: 42)
                        .background(buttonColor(for: letter))
                        .foregroundColor(viewModel.guessedLetters.contains(letter) ? .white : .primary.opacity(0.8))
                        .cornerRadius(6)
                        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
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
            return Color.secondary.opacity(0.15)
        }
        
        // If it was guessed and is in the word (Correct)
        if viewModel.currentWord.contains(letter) {
            return .green
        }
        
        // If it was guessed but is NOT in the word (Incorrect)
        return .gray.opacity(0.3)
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
