//
//  ContentView.swift
//  PracticeProject
//
//  Created by T0204ZL on 01/08/25.
//

import SwiftUI

//struct GetBarButtonModifier: ViewModifier {
//    @Binding var isToggled: Bool
//    var action: () -> Void
//    var placement: ToolbarItemPlacement
//    var imageName: String
//    
//    func body(content: Content) -> some View {
//        content
//            .toolbar {
//                ToolbarItem(placement: placement) {
//                    Button {
//                        withAnimation {
//                            isToggled.toggle()
//                        }
//                        action()
//                    } label: {
//                        Image(systemName: imageName)
//                            .foregroundStyle(isToggled ? .yellow : .gray)
//                            .rotationEffect(.degrees(isToggled ? 360 : 0))
//                    }
//                }
//            }
//    }
//}
//
//extension View {
//    func getBarButton(isToggled: Binding<Bool>, placement: ToolbarItemPlacement, imageName: String, action: @escaping () -> Void) -> some View {
//        modifier(GetBarButtonModifier(isToggled: isToggled, action: action, placement: placement, imageName: imageName))
//    }
//}
//
//struct ContentView: View {
//    @State private var isToggled = false
//    @State private var isToggledPlus = false
//    var body: some View {
//        NavigationStack{
//            ////            .navigationTitle("Welcome")
//            ////            .navigationBarTitleDisplayMode(.inline)
//            VStack(alignment: .leading, spacing: 8) {
//                Text("course.title")
//                    .font(.title2)
//                    .frame(maxWidth: 170, alignment: .leading)
//                    .layoutPriority(1)
//                Text("course.subtitle")
//                    .opacity(0.7)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                Text("course.caption".uppercased())
//                    .font(.caption)
//                    .opacity(0.7)
//                Spacer()
//            }
//            .foregroundColor(.white)
//            .padding(30)
//            .frame(width: .infinity, height: 200)
//            .background(.linearGradient(colors: [Color.red.opacity(1), Color.orange.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
//            .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
////            .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 12)
//            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
//            .padding(10)
//
//            VStack(alignment: .leading, spacing: 8) {
//                Text("course.title")
//                    .font(.title2)
//                    .frame(maxWidth: 170, alignment: .leading)
//                    .layoutPriority(1)
//                Text("course.subtitle")
//                    .opacity(0.7)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                Text("course.caption".uppercased())
//                    .font(.caption)
//                    .opacity(0.7)
//                Spacer()
//            }
//            .foregroundColor(.white)
//            .padding(30)
//            .frame(width: .infinity, height: 200)
//            .background(.linearGradient(colors: [Color.red.opacity(1), Color.orange.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
//            .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
//            .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 12)
//            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
//            .padding(10)
//            VStack(alignment: .leading, spacing: 8) {
//                Text("course.title")
//                    .font(.title2)
//                    .frame(maxWidth: 170, alignment: .leading)
//                    .layoutPriority(1)
//                Text("course.subtitle")
//                    .opacity(0.7)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                Text("course.caption".uppercased())
//                    .font(.caption)
//                    .opacity(0.7)
//                Spacer()
//            }
//            .foregroundColor(.white)
//            .padding(30)
//            .frame(width: .infinity, height: 200)
//            .background(.linearGradient(colors: [Color.red.opacity(1), Color.orange.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
//            .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
//            .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 12)
//            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
//            .padding(10)
//            
//            Spacer()
//            
//                .navigationTitle("")
//                .navigationBarTitleDisplayMode(.inline)
//            
//            
//        }
//    }
//}

//struct ContentView: View {
//    @State private var showSheet = false
//
//    var body: some View {
//        VStack {
//            Button("Open Sheet") {
//                showSheet = true
//            }
//        }
//        .sheet(isPresented: $showSheet) {
//            SheetRootView()
//        }
//    }
//}
//
//struct SheetRootView: View {
//    @State private var showSheet = false
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Sheet Root View")
//                    .font(.title)
//
//                NavigationLink("Go to Next Screen") {
//                    NextSheetView()
//                }
//                .padding()
//                Button("Open Sheet") {
//                    showSheet = true
//                }
//            }
//            .sheet(isPresented: $showSheet) {
//                NextSheetView()
//                    .interactiveDismissDisabled(true)
//            }
//            .navigationTitle("Sheet Navigation")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//struct NextSheetView: View {
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        Text("Next Screen Inside Sheet")
//            .font(.headline)
//
//        Button("Close") {
//            dismiss()
//        }
//        
//            .navigationTitle("nex Sheet Navigation")
//    }
//}
//
//
//#Preview {
//    ContentView()
//}


//
//  ContentView.swift
//  PracticeProject
//
//  Created by T0204ZL on 01/08/25.
//

import SwiftUI

struct GetBarButtonModifier: ViewModifier {
    @Binding var isToggled: Bool
    var action: () -> Void
    var placement: ToolbarItemPlacement
    var imageName: String

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    Button {
                        withAnimation {
                            isToggled.toggle()
                        }
                        action()
                    } label: {
                        Image(systemName: imageName)
                            .foregroundStyle(isToggled ? .yellow : .gray)
                            .rotationEffect(.degrees(isToggled ? 360 : 0))
                    }
                }
            }
    }
}

extension View {
    func getBarButton(isToggled: Binding<Bool>, placement: ToolbarItemPlacement, imageName: String, action: @escaping () -> Void) -> some View {
        modifier(GetBarButtonModifier(isToggled: isToggled, action: action, placement: placement, imageName: imageName))
    }
}

struct ContentView: View {
    @State private var isToggled = false
    @State private var isToggledPlus = false
    var body: some View {
//        NavigationStack{
////            .navigationTitle("Welcome")
////            .navigationBarTitleDisplayMode(.inline)
//        }
        ZStack {
                Color("Background").ignoresSafeArea()

                ScrollView {
                    content
                }

            }



    }
}



import SwiftUI

struct CircleButtonGameView: View {
    var letters: String
    
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
                        print("User sequence: \(selectedOrder.map { String(letters[letters.index(letters.startIndex, offsetBy: $0)]) }.joined())")
                        
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

struct NContentView: View {
    var body: some View {
        CircleButtonGameView(letters: "SWIFTUI")
            .frame(width: 300, height: 300)
            .padding()
    }
}



var content: some View {
    // VStack
    VStack(alignment: .leading, spacing: 0) {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 200, height: 100)
            .background(Color.red)
        VStack(alignment: .leading, spacing: 0) {
            Text("Courses")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(courses) { course in
                    VCard(course: course)
                }
            }
            .padding(20)
            .padding(.bottom, 10)
        }

        VStack {
            Text("Recent")
                .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 20) {
                ForEach(courseSections) { section in
                    HCard(section: section)
                }
            }
        }
        .padding(2)
    }
}

#Preview {
    NContentView()
}
