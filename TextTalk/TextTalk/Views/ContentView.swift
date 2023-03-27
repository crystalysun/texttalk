//
//  ContentView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/6/23.
//

import SwiftUI

var phraseGlobal = Phrases()
var idNum = 7
var voiceName: String = "Samantha"

struct ContentView: View {
    @State private var selection: Tab = .phone
    @State var unLocked = false
    
    public init() {
        self.selection = selection
    }

    enum Tab {
        case contacts
        case phone
        case activeCall
        case settings
    }


    var body: some View {

        if !unLocked{
            LockScreen(unLocked: $unLocked)
        }
        else{
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
