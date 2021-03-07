//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Anthony You on 02/03/2021.
//

import SwiftUI

//MARK: - View composition and custom modifiers

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleProminent() -> some View {
        self.modifier(ProminentTitle())
    }
}

//MARK: - Custom containers

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { (column) in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

//MARK: - MainView rendering

struct ContentView: View {
    var motto1: some View {
        Text("Draco dormiens")
    }
    let motto2 = Text("Nunquam titillandus")
    
    @State private var useRedText = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello, world!")
                .padding()
                .foregroundColor(useRedText ? .red : .blue)
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
            
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
            
            Text("Example with modifier stuct")
                .modifier(Title())
            Text("Example 2 with extension")
                .titleStyle()
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
            
//            GridStack(rows: 4, columns: 4) { row, col in
//                HStack {
//                    Image(systemName: "\(row * 4 + col).circle")
//                    Text("R\(row) C\(col)")
//                }
//            }
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
        VStack {
            Text("Hello title")
                .titleProminent()
            Text("Hello, world!")
                .foregroundColor(.blue) // local modifier overrides parent environment modifier
            Text("Hello, world!")
        }
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
