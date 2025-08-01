//
//  ContentView.swift
//  Guess The Flag
//
//  Created by T0204ZL on 04/07/25.
//

import SwiftUI

struct LargeOrangeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.orange)
            .padding()
    }
}

extension View {
    func orangeTitle() -> some View {
        self.modifier(LargeOrangeTitle())
    }
}

struct FlagImage: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
    }
}

struct CustomLargeTextField: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct CustomHeadlineTextField: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .padding()

    }
}

struct ContentView: View {
    @State private var score: Int = 0
    @State private var flags: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
    @State private var gameCount: Int = 0
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 400)
                    .ignoresSafeArea()

                    LinearGradient(
                        gradient: Gradient(colors: [.yellow.opacity(0.7), .orange.opacity(0.3), .purple.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                
                VStack(spacing: 35) {
                    HStack{
                        Spacer()
                        CustomLargeTextField(text: "Score: \(score)")
                            .orangeTitle()

                    }
                    
                    VStack {
                        CustomHeadlineTextField(text: "Guess The Flag")
                            .padding()
                          
                        CustomLargeTextField(text: "Tap flag of \(flags[correctAnswer])")
                            .lineLimit(nil)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(50)
                    }
                    
                    ForEach(0..<3) { index in
                        Button {
                            checkAnswer(index)
                        } label: {
                            FlagImage(flag: flags[index])
                        }
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                resetGame()
            })
        }
    }
    
    func checkAnswer(_ userAnswer: Int) {
        if userAnswer == correctAnswer {
            score += 1
            flags.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            score -= 1
            showAlert = true
            alertTitle = "Opps!"
            alertMessage = "You choosed \(flags[userAnswer])."
        }
        gameCount += 1
        // Reset the game after each guess
        
        if gameCount >= 10 {
            showAlert = true
            alertTitle = "Game Over"
            alertMessage = "Your final score is \(score)."
        }
    }
    func resetGame() {
        if gameCount >= 10 {
            gameCount = 0
            score = 0
        }
        flags.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
