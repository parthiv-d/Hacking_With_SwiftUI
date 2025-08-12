//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by T0204ZL on 25/07/25.
//

import SwiftUI

struct customModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue.gradient)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let column: Int
    let content:(Int, Int) -> Content
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                ForEach(0..<rows, id: \.self) { row in
                    HStack {
                        ForEach(0..<column, id: \.self) { column in
                            content(row, column)
                        }
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

extension View {
    func custom() -> some View {
        modifier(customModifier())
    }
}

struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View{
        ZStack(alignment: .bottomTrailing){
            content
                Text(text)
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
    }
}

extension View {
    func watermarked(text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

//struct ContentView: View {
//    
//    let viewProperty1 = Text("Hello, SwiftUI!")
//        .font(.system(size: 32, weight: .bold, design: .rounded))
//        .foregroundColor(.purple)
//
//    @ViewBuilder var viewProperty2: some View {
//        Text("Hello, World!")
//            .font(.system(size: 24, weight: .bold, design: .serif))
//            .foregroundColor(.blue)
//            .padding()
//            .background(Color.yellow)
//            .cornerRadius(10)
//            .shadow(radius: 5)
//        Text("This is a custom view modifier example.")
//            .font(.system(size: 18, weight: .regular, design: .default))
//            .foregroundColor(.gray)
//            .padding()
//            .background(Color.white)
//            .cornerRadius(8)
//            .shadow(radius: 3)
//    }
//    
//    struct ViewCompositionText: View {
//        var text: String = "This is a composed view"
//        var body: some View {
//            Text(text)
//                .padding()
//                .background(Color.green.opacity(0.1))
//                .cornerRadius(12)
//                .shadow(radius: 4)
//        }
//    }
//    
//    var body: some View {
//        VStack {
//            ScrollView {
//                viewProperty1
//                viewProperty2
//                ViewCompositionText(text: "Using a custom view modifier")
//                ViewCompositionText(text: "Another instance of the composed view")
//                    .background(Color.red.gradient)
//                ViewCompositionText(text: "ViewCompositionText with Custom Modifier")
//                    .modifier(customModifier())
//                Text("This is a text view with a custom modifier")
//                    .modifier(customModifier())
//                
//                ViewCompositionText(text: "ViewCompositionText with Custom Modifier from Extension")
//                    .custom()
//                Text("This is a text view with a custom modifier from Extension")
//                    .custom()
//                
//                Color.blue
//                    .frame(height: 200)
//                    .watermarked(text: "Watermark Example")
//                
//                GridStack(rows: 5, column: 5) { row, column in
//                    Text("\(row), \(column)")
//                        .padding()
//                        .frame(width: 100, height: 60)
//                        .background(Color.orange.opacity(0.3))
//                        .cornerRadius(8)
//                        .shadow(radius: 2)
//                }
//                
//            }
//        }
//        .padding()
//        .scrollIndicators(.hidden)
//    }
//}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct HeightReporter: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ViewHeightKey.self, value: geometry.size.height)
                }
            )
    }
}

extension View {
    func reportHeight() -> some View {
        self.modifier(HeightReporter())
    }
}

struct ContentView: View {
    @State private var childHeight: CGFloat = 0

    var body: some View {
        VStack {
            Text("Child height: \(Int(childHeight)) pts")
                .font(.headline)
                .padding()

            Text("This is a dynamic text block that resizes based on aljsdhakjshdkahdskjhakjsdhkjahsdkjhakjsdhkjahsdkjahskdjhakjshdkjahsdkjahsd content.")
                .padding()
                .background(Color.blue.opacity(0.3))
                .reportHeight() // 👈 Apply the modifier
        }
        .onPreferenceChange(ViewHeightKey.self) { height in
            self.childHeight = height
        }
        .padding()
    }
}



#Preview {
    ContentView()
}
