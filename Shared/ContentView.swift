//
//  ContentView.swift
//  Shared
//
//  Created by Porter McGary on 8/15/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navMemory = NavigationMemory()
    @StateObject var tabMemory = TabViewMemory()
    
    var body: some View {
        NavigationEntry($navMemory.background, $navMemory.foreground)
            // Changing the ID will require that the view is built anew
            .id(navMemory.id)
            .environmentObject(navMemory)
            .environmentObject(tabMemory)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationMemory())
    }
}

class NavigationMemory: ObservableObject, Identifiable {
    @Published var id = UUID()
    @Published var background: Color = .clear
    @Published var accent: Color = .blue
    @Published var foreground: Color = .black
    
    func update() {
        id = UUID()
    }
}
