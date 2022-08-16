//
//  TabBarExample.swift
//  SwiftUIComponents (iOS)
//
//  Created by Porter McGary on 8/16/22.
//

import SwiftUI

struct TabBarExample: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var memory: TabViewMemory
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(content: {
                NavigationLink(destination: TabBar($memory.background, $memory.unselectedText), label: { Text("TabView Embedded in NavigationView")})
                Button(
                    action: { isPresented.toggle() },
                    label: { Text("NavigationView Embedded in TabView") })
            }, header: { Text("") }, footer: {
                VStack {
                    Text("Best practice is to embed the NavigationView inside of TabView's Views. When this is done the developer will be able to successfully hide the NavigationBar if they so choose. This does how ever require multiple NavigationViews.")
                } })
            .sheet(isPresented: $isPresented, content: { TabBar($memory.background, $memory.unselectedText) })
            
            Section(content: {
                ColorPicker(selection: $memory.accent, label: "TabBar Text")
                ColorPicker(selection: $memory.background, label: "TabBar Background")
                ColorPicker(selection: $memory.unselectedText, label: "TabBar Unselected Text")
            }, header: { Text("Customized TabView") })
        }
        .navigationTitle("Tab Bars")
    }
}

struct TabBarExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabBarExample()
        }
        .environmentObject(TabViewMemory())
    }
}

struct TabBar: View {
    @EnvironmentObject var memory: TabViewMemory
    @Binding var background: Color
    @Binding var unselectedText: Color
    
    init(_ background: Binding<Color>, _ unselectedText: Binding<Color>) {
        self._background = background
        self._unselectedText = unselectedText
        UITabBar.appearance().barTintColor = UIColor(background.wrappedValue)
        UITabBar.appearance().unselectedItemTintColor = UIColor(unselectedText.wrappedValue)
    }
    
    var body: some View {
        TabView {
            Color.blue
                .tabItem {
                    Label("Blue", systemImage: "snowflake")
                        .foregroundColor(.blue)
                }
            Color.red
                .tabItem {
                    Label("Red", systemImage: "flame.fill")
                        .foregroundColor(.red)
                }
            Color.yellow
                .tabItem {
                    Label("Yellow", systemImage: "sun.max.fill")
                        .foregroundColor(.yellow)
                }
        }
        .accentColor(memory.accent)
        .navigationTitle("Tab Bar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

class TabViewMemory: ObservableObject, Identifiable {
    @Published var accent: Color = .blue
    @Published var unselectedText: Color = .gray
    @Published var background: Color = .white
    @Published var id = UUID()
    
    func update() {
        id = UUID()
    }
}
