//
//  SettingsDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import SwiftUI

struct SettingsDetails: View {
    var pageName: String
    @Binding var passwordSet : Bool
    @Binding var key : String
    @State private var createPass: Bool = false
    @State private var wrongPass = false
    @State private var helpSheet = false
    
    var body: some View {
        if (pageName == "Saved Phrases") {
            SavedPhrasesView()
        }
        else if(pageName == "Customize Voice") {
            VoiceSettingsView()
        }
        else if (pageName == "Password Settings") {
            VStack {
                Text("Password Settings")
                    .font(.title)
                    .padding()
                
                Button("Reset Password") {
                    createPass = true
                }
                    .sheet(isPresented: $createPass) {
                        CreatePassSheet(passwordSet: $passwordSet, key: $key, createPass: $createPass, wrongPass: $wrongPass)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                
                Button("Help") {
                    helpSheet = true
                }
                    .sheet(isPresented: $helpSheet) {
                        HelpSheet()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
            }
        }
        
    }
}

//struct SettingsDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsDetails(pageName: "Saved Phrases")
//    }
//}
