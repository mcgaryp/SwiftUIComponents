//
//  NavigationExample.swift
//  SwiftUIComponents (iOS)
//
//  Created by Porter McGary on 8/15/22.
//

import SwiftUI

struct NavigationExample: View {
    @EnvironmentObject var memory: NavigationMemory
    @State var modes = NavigationBarItem.TitleDisplayMode.allCases
    
    var body: some View {
        List {
            Section(content: {
                ForEach(modes, id: \.self) { mode in
                    NavigationLink(
                        destination: { navigationMode(mode) },
                        label: { Text(mode.description) })
                }
                NavigationLink(
                    destination: {
                        HiddenTitleView()
                            .navigationTitle("Hidden Title")
                            .navigationBarHidden(true)
                    },
                    label: { Text("Hidden Title") })
                NavigationLink(
                    destination: {
                        HiddenTitleView()
                            .navigationTitle("Back Button Hidden")
                            .navigationBarBackButtonHidden(true)
                    },
                    label: { Text("Hidden Back Button") })
            }, header: {
                Text("Navigation Title Display Modes")
            })
            
            Section(content: {
                NavigationLink(
                    destination: {
                        Color.blue
                            .navigationTitle(Text(StackNavigationViewStyle.description))
                            .navigationViewStyle(.stack)
                    },
                    label: { Text("Stacked") })
                NavigationLink(
                    destination: {
                        Color.blue
                            .navigationTitle(Text(ColumnNavigationViewStyle.description))
                            .navigationViewStyle(.columns)
                    },
                    label: { Text("Column") })
            }, header: { Text("Navigation View Styles") })
            
// TODO: Create Version 2.0 which enables the Navigation to update without starting the app over. Hint: This will include managing the state of the UINavigationBar and it's Appearance
            Section(
                content: {
                    ColorPicker(selection: $memory.background, label: "Background Color")
                    
                    ColorPicker(selection: $memory.accent, label: "Back Button Color")
                    
                    ColorPicker(selection: $memory.foreground, label: "Title Text Color")
                    
                    Button(action: memory.update) {
                        Text("Update Navigation")
                    }
                },
                header: { Text("Customized Navigation") },
                footer: {
                    VStack {
                        Text("Updating the Navigation will require the application to restart. This version of the navigation still uses basic SwiftUI Components")
                        Text("Customized Navigation Version 1.0")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                })
            .accentColor(.blue)
        }
        .navigationTitle("Navigation")
    }
    
    private func navigationMode(_ mode: NavigationBarItem.TitleDisplayMode) -> some View {
        Color.blue.navigationBarTitleDisplayMode(mode)
            .navigationTitle(mode.description)
    }
}

struct NavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationExample()
        }
        .environmentObject(NavigationMemory())
    }
}

struct HiddenTitleView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            Color.blue
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ColorPicker: View {
    @Binding var selection: Color
    let label: String
    
    var body: some View {
        Picker(selection: $selection, label: Text(label)) {
           ForEach(Color.allCases, id: \.self) { color in
               color
           }
        }
    }
}

extension NavigationBarItem.TitleDisplayMode {
    public static var allCases: [NavigationBarItem.TitleDisplayMode] {
        [.large, .inline]
    }
    
    public var description: String {
        switch self {
        case .inline: return "Inline Display Title"
        case .large: return "Large Display Title"
        case .automatic: return "Automatic Display Title"
        @unknown default: return "Unknown Display Mode"
        }
    }
}

extension ColumnNavigationViewStyle {
   public static var description: String { "Column Style" }
}

extension StackNavigationViewStyle {
    public static var description: String { "Stacked Style" }
}

extension Color {
    public static var allCases: [Color] {
        [.pink, .red, .orange, .yellow, .green, .mint, .cyan, .teal, .blue, .indigo, .purple, .white, .clear, .brown, .gray, .black]
    }
}
