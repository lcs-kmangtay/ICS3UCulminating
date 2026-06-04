//
//  GallowsView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import SwiftUI

// MARK: - View

struct GallowsView: View {
    
    // MARK: - Stored properties
    
    // The number of incorrect guesses made
    var incorrectGuessesCount: Int
    
    // MARK: - Computed properties
    
    var body: some View {
        ZStack {
            // The Gallows (Drawn with Shapes)
            Group {
                // Base
                Rectangle()
                    .fill(.primary)
                    .frame(width: 150, height: 10)
                    .offset(y: 100)
                
                // Vertical Pole
                Rectangle()
                    .fill(.primary)
                    .frame(width: 10, height: 200)
                    .offset(x: -70)
                
                // Horizontal Pole
                Rectangle()
                    .fill(.primary)
                    .frame(width: 100, height: 10)
                    .offset(x: -25, y: -95)
                
                // Rope
                Rectangle()
                    .fill(.primary)
                    .frame(width: 4, height: 30)
                    .offset(x: 20, y: -80)
            }
            
            // The Hangman Parts (Conditional rendering)
            Group {
                // 1. Head
                if incorrectGuessesCount >= 1 {
                    Circle()
                        .stroke(.primary, lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .offset(x: 20, y: -45)
                }
                
                // 2. Body
                if incorrectGuessesCount >= 2 {
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 4, height: 60)
                        .offset(x: 20, y: 5)
                }
                
                // 3. Left Arm
                if incorrectGuessesCount >= 3 {
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 40, height: 4)
                        .rotationEffect(.degrees(30))
                        .offset(x: 0, y: -10)
                }
                
                // 4. Right Arm
                if incorrectGuessesCount >= 4 {
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 40, height: 4)
                        .rotationEffect(.degrees(-30))
                        .offset(x: 40, y: -10)
                }
                
                // 5. Left Leg
                if incorrectGuessesCount >= 5 {
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 4, height: 50)
                        .rotationEffect(.degrees(30))
                        .offset(x: 5, y: 55)
                }
                
                // 6. Right Leg
                if incorrectGuessesCount >= 6 {
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 4, height: 50)
                        .rotationEffect(.degrees(-30))
                        .offset(x: 35, y: 55)
                }
                
                // 7. Face (Optional/Final touch)
                if incorrectGuessesCount >= 7 {
                    Text("😵")
                        .font(.largeTitle)
                        .offset(x: 20, y: -45)
                }
            }
        }
        .frame(width: 200, height: 250)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        GallowsView(incorrectGuessesCount: 0)
        GallowsView(incorrectGuessesCount: 3)
        GallowsView(incorrectGuessesCount: 7)
    }
}
