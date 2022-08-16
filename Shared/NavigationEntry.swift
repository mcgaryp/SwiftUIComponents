//
//  NavigationEntry.swift
//  SwiftUIComponents (iOS)
//
//  Created by Porter McGary on 8/15/22.
//

import SwiftUI

struct NavigationEntry: View {
    @EnvironmentObject var memory: NavigationMemory
    @EnvironmentObject var tabMemory: TabViewMemory
    @Binding var background: Color
    @Binding var text: Color
    
    // UINavigationBar is built only once and can only be initialized in the view it is created in. Any attempts to update the UINavigationBar outside of the view's initializer it is constructed in will prevent the view from ever changing.
    init(_ background: Binding<Color>, _ text: Binding<Color>) {
        self._background = background
        self._text = text
        let navbarAppearance = UINavigationBarAppearance()
        navbarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(text.wrappedValue)]
        navbarAppearance.titleTextAttributes = [.foregroundColor: UIColor(text.wrappedValue)]
        navbarAppearance.backgroundColor = UIColor(background.wrappedValue)
        UINavigationBar.appearance().standardAppearance = navbarAppearance
        UINavigationBar.appearance().compactAppearance = navbarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navbarAppearance
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    NavigationLink(
                        destination: NavigationExample(),
                        label: { Text("Navigation Views") })
                    NavigationLink(
                        destination: TabBarExample().id(tabMemory.id),
                        label: { Text("Tab Bars") })
                }, header: {
                    Text("Forms of Navigation")
                })
                
                Section(content: {
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: {  Text("ScrollView") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("ListView") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("Picker") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("Form") })
                    .disabled(true)
                }, header: { Text("Scrolling Views") })
                
                Section(content: {
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("Text") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("Button") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("Toggle") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("TextBox") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("VStack") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("HStack") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("ZStack") })
                    .disabled(true)
                    NavigationLink(
                        destination: Text("Tab Bar"),
                        label: { Text("Image") })
                    .disabled(true)
                }, header: { Text("Basic Views") })
            }
            .listStyle(.insetGrouped)
            .navigationTitle("SwiftUI Components")
        }
        .accentColor(memory.accent)
    }
}
