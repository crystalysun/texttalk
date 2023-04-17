//
//  SettingsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI
//import AVFoundation

let settings: [Phrase] = [Phrase(id: 1, content: "Language & Accent"), Phrase(id: 2, content: "Saved Phrases"), Phrase(id: 3, content: "Password Settings")]

//let settings: [Phrase] = [Phrase(id: 1, content: "Customize Voice"), Phrase(id: 2, content: "Saved Phrases"), Phrase(id: 3, content: "Account"), Phrase(id: 4, content: "Notifications"), Phrase(id: 5, content: "Privacy"), Phrase(id: 6, content: "Help Center"), Phrase(id: 7, content: "About Us")]

struct SettingsView : View {
    @Binding var passwordSet : Bool
    @Binding var key : String
    
    var body : some View {
        VStack {
            ZStack {
                VStack(spacing: 20) {
                    Text("Settings")
                        .font(.system(size: 34, weight: .bold))
                }
            }

            NavigationView {
                List(settings) { setting in
                    NavigationLink {
                        SettingsDetails(pageName: setting.content, passwordSet: $passwordSet, key: $key)
                    } label: {
                        btnView(image: "customphrase", name: setting.content)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct btnView : View {
    
    var image = ""
    var name = ""
    var body : some View {
        
        Button(action: {
        })  {
            HStack(spacing:15){
                Image(image).renderingMode(.original).resizable().frame(width:40, height:40)
                
                Text(name)
                
                Spacer(minLength: 15)
                
            }.padding()
        }
    }
}
