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

        ZStack {
                Color("Background").ignoresSafeArea()

                ScrollView {
                    content
                }

            }



    }
}




var content: some View {
    // VStack
    VStack(alignment: .leading, spacing: 0) {
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
    ContentView()
}
