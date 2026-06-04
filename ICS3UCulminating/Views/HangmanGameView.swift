//
//  HangmanGameView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import SwiftUI

// MARK: - View

struct HangmanGameView: View {
    
    // MARK: - Stored properties
    
    // The shared view model
    var viewModel: HangmanViewModel
    
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
                keyboardRow(row1)
                keyboardRow(row2)
                
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
            .padding(.bottom, 20)
            
            // Quick Session Stats
            HStack {
                Text("Wins: \(viewModel.totalWins)")
                Spacer()
                Text("Losses: \(viewModel.totalLosses)")
            }
            .font(.caption2)
            .foregroundColor(.secondary)
            .padding(.horizontal, 40)
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - Helper Views
    
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
    
    func buttonColor(for letter: Character) -> Color {
        if viewModel.guessedLetters.contains(letter) == false {
            return Color.secondary.opacity(0.15)
        }
        if viewModel.currentWord.contains(letter) {
            return .green
        }
        return .gray.opacity(0.3)
    }
}
