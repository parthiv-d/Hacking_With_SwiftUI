//
//  ContentView.swift
//  WordScramble
//
//  Created by T0204ZL on 11/08/25.
//

import SwiftUI

struct CircleButtonGameView: View {
    var letters: String
    var onEnded: ((String) -> Void)?
    
    @State private var selectedOrder: [Int] = []
    @State private var dragLocation: CGPoint = .zero
    @State private var animateLine: Bool = false
    @State private var showPath: Bool = true
    
    private var buttonCount: Int {
        letters.count
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Main circle boundary
                Circle()
                    .stroke(Color.gray.opacity(0.4), lineWidth: 4)
                
                // Path clipped to circle
                if showPath {
                    Path { path in
                        if let firstIndex = selectedOrder.first {
                            let firstPos = buttonPosition(index: firstIndex, size: geo.size)
                            path.move(to: firstPos)
                            
                            for index in selectedOrder.dropFirst() {
                                let pos = buttonPosition(index: index, size: geo.size)
                                path.addLine(to: pos)
                            }
                            
                            // Draw to drag location
                            path.addLine(to: dragLocation)
                        }
                    }
                    .trim(from: 0, to: animateLine ? 1 : 0)
                    .stroke(
                        LinearGradient(
                            colors: [.mint, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .clipShape(Circle())
                    .animation(.easeInOut(duration: 0.3), value: selectedOrder)
                }
                
                // Buttons
                ForEach(Array(letters.enumerated()), id: \.offset) { index, letter in
                    let pos = buttonPosition(index: index, size: geo.size)
                    
                    Circle()
                        .fill(selectedOrder.contains(index) ? Color.green : Color.orange)
                        .frame(width: 50, height: 50)
                        .overlay(Text(String(letter))
                            .foregroundColor(.white)
                            .font(.headline))
                        .scaleEffect(selectedOrder.contains(index) ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedOrder)
                        .position(pos)
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        dragLocation = value.location
                        animateLine = true
                        showPath = true
                        
                        if let hitIndex = hitTest(location: value.location, size: geo.size),
                           !selectedOrder.contains(hitIndex) {
                            selectedOrder.append(hitIndex)
                        }
                    }
                    .onEnded { _ in
                        
                        let sequence = selectedOrder.map {
                                                    String(letters[letters.index(letters.startIndex, offsetBy: $0)])
                                                }.joined()
                        
                        onEnded?(sequence)
                        
                        // Fade path out
                        withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
                            showPath = false
                        }
                        
                        // Reset after fade
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            selectedOrder.removeAll()
                            animateLine = false
                        }
                    }
            )
        }
    }
    
    // MARK: - Helpers
    func buttonPosition(index: Int, size: CGSize) -> CGPoint {
        let radius = min(size.width, size.height) / 2 - 25
        let angle = (Double(index) / Double(buttonCount)) * 2 * .pi - .pi/2
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        return CGPoint(
            x: center.x + CGFloat(Darwin.cos(angle)) * radius,
            y: center.y + CGFloat(Darwin.sin(angle)) * radius
        )
    }
    
    func hitTest(location: CGPoint, size: CGSize) -> Int? {
        for index in 0..<buttonCount {
            let pos = buttonPosition(index: index, size: size)
            let distance = hypot(location.x - pos.x, location.y - pos.y)
            if distance < 25 { return index }
        }
        return nil
    }
}


struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    @State private var score: Int = 0
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .padding()
            }
            .background(Color.yellow.opacity(0.2).gradient)
            
            CircleButtonGameView(letters: rootWord) { sequence in
                print("Sequence completed: \(sequence)")
                newWord = sequence
                AddNewWord()
                // Your custom logic here
            }
            .frame(width: .infinity, height: 300)
                .padding()
                .background(LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.5)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
            
            List {
                Section("Found Items :") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)

                        }
                    }
                }
                Section {
                    
                }
            }
            .navigationTitle(rootWord)
            .onAppear {
                startGame()
            }
            .alert(errorTitle, isPresented: $showError) {
                Button("OK") {
                }
            } message: {
                Text(errorMessage)
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Game") {
                        startGame()
                    }
                }
            }
        
        }
    }
    
    func AddNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 else {
            wordError(title: "Answer Too Short", message: "Words must be longer than 3 letters.")
            return }
        
        guard answer != rootWord else {
            wordError(title: "You Can't Say That", message: "Aren't you feeling clever?")
            return
        }
        
        guard isOriginalWord(answer) else {
            wordError(title: "Word Used Already", message: "Be More Original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Not a Possible Word", message: "You can't make that word form the letters in \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Not a Real Word", message: "\(answer) is not a real word!")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        score += answer.count
        newWord = ""
        
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func startGame() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            do {
                let startWords = try String(contentsOf: startWordURL)
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Test"
                score = 0
                usedWords.removeAll()
                return
            } catch {
                print("Could not load start words.")
            }
        } else {
            fatalError("Could not find start.txt")
        }
    }
    
    func isOriginalWord(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            guard let range = tempWord.firstIndex(of: letter) else {
                return false
            }
            tempWord.remove(at: range)
        }
        return true
    }
    
    func wordError(title:String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

#Preview {
    ContentView()
}
