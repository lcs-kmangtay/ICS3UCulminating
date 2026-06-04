//
//  MatchHistoryView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import SwiftUI

// MARK: - View

struct MatchHistoryView: View {
    
    // MARK: - Stored properties
    
    let history: [GameHistory]
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            // Header
            Text("Match History")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            if history.isEmpty {
                Spacer()
                VStack {
                    Image(systemName: "clock")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    Text("No games played yet.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else {
                // Using a ScrollView for more control over centering and padding
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(history) { entry in
                            // The "Data Block"
                            HStack {
                                // Word and Date info
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(entry.word)
                                        .font(.system(.headline, design: .monospaced))
                                        .fontWeight(.bold)
                                    
                                    Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                // Result Badge
                                gameResultBadge(isWin: entry.isWin)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.primary.opacity(0.04)) // Block background
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 60) // Left and right padding to center the blocks
                    .padding(.vertical, 10)
                }
            }
        }
    }
    
    // MARK: - Helper Views
    
    @ViewBuilder
    func gameResultBadge(isWin: Bool) -> some View {
        if isWin {
            Text("WIN")
                .font(.system(size: 10, weight: .black))
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(Color.green.opacity(0.15))
                .foregroundColor(.green)
                .cornerRadius(4)
        } else {
            Text("LOSS")
                .font(.system(size: 10, weight: .black))
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(Color.red.opacity(0.15))
                .foregroundColor(.red)
                .cornerRadius(4)
        }
    }
}

// MARK: - Preview

#Preview {
    MatchHistoryView(history: [
        GameHistory(word: "SWIFT", isWin: true),
        GameHistory(word: "APPLE", isWin: false),
        GameHistory(word: "XCODE", isWin: true)
    ])
}
