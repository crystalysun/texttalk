//
//  ContentView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/6/23.
//

import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
struct ContentView: View {
    @State private var selection: Tab = .phone

    enum Tab {
        case contacts
        case phone
        case activeCall
        case settings
    }

    var body: some View {
        TabView(selection: $selection) {
            ContactsView()
                .tabItem {
                    Label("Contacts", systemImage: "person.circle.fill")
                }
                .tag(Tab.contacts)
            
            PhoneView()
                .tabItem {
                    Label("Phone", systemImage: "phone")
                }
                .tag(Tab.phone)

            ActiveCallView()
                .tabItem {
                    Label("Active Call", systemImage: "teletype")
                }
                .tag(Tab.activeCall)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Tab.settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
