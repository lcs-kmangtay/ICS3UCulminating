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
    
    // The shared view model to manage game state
    @State var viewModel = HangmanViewModel()
    
    // Tracking the currently selected tab
    @State private var selectedTab: Int = 0
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 0) {
            
            // --- Main Content Area: TabView ---
            TabView(selection: $selectedTab) {
                
                // Tab 1: The Game
                HangmanGameView(viewModel: viewModel)
                    .tabItem {
                        Label("Game", systemImage: "gamecontroller.fill")
                    }
                    .tag(0)
                
                // Tab 2: Match History
                MatchHistoryView(history: viewModel.gameHistory)
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(1)
            }
            // Applying padding to the tab bar area to keep it away from edges
        }
        .background(Color.primary.opacity(0.02))
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
