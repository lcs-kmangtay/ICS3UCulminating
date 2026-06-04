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
        VStack(alignment: .leading, spacing: 0) {
            Text("Match History")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if history.isEmpty {
                Spacer()
                VStack {
                    Image(systemName: "clock")
                        .font(.system(size: 50))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10)
                    Text("No games played yet.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else {
                List {
                    ForEach(history) { entry in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.word)
                                    .font(.system(.title3, design: .monospaced))
                                    .fontWeight(.bold)
                                
                                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            gameResultBadge(isWin: entry.isWin)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.inset)
            }
        }
    }
    
    // MARK: - Helper Views
    
    @ViewBuilder
    func gameResultBadge(isWin: Bool) -> some View {
        if isWin {
            Text("WIN")
                .font(.caption)
                .fontWeight(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.green.opacity(0.2))
                .foregroundColor(.green)
                .cornerRadius(6)
        } else {
            Text("LOSS")
                .font(.caption)
                .fontWeight(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.red.opacity(0.2))
                .foregroundColor(.red)
                .cornerRadius(6)
        }
    }
}
