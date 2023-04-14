//
//  SettingsDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import SwiftUI
import AVFoundation

// Update Languages
var SV = AVSpeechSynthesisVoice.speechVoices()
var codes = Set(SV.map { $0.language })
var dict : Dictionary<String,[String]> = Dictionary(uniqueKeysWithValues: codes.map {($0, [])})
var languages = Languages(dict: dict)

struct SettingsDetails: View {
    var pageName: String
    
    let langSettings: [Phrase] = [Phrase(id: 1, content: "Text-to-Speech"), Phrase(id: 2, content: "Speech-to-Text")]
    
    var body: some View {
        if (pageName == "Saved Phrases") {
            SavedPhrasesView()
        }
        else if(pageName == "Language & Accent") {
            
            NavigationView {
                List(langSettings) { langSetting in
                    NavigationLink {
                        SettingsDetails(pageName: langSetting.content)
                    } label: {
                        btnView(image: "customphrase", name: langSetting.content)
                    }
                }
            }
            .onAppear() {
                dict = Dictionary(uniqueKeysWithValues: codes.map {($0, [])})
                for entry in SV {
                    dict[entry.language]?.append(entry.name)
                }
                print(dict)
            }
            
            
        }
        
        if(pageName == "Text-to-Speech") {
            VoiceSettingsView(languages: languages)
//                .onAppear() {
//                    dict = Dictionary(uniqueKeysWithValues: codes.map {($0, [])})
//                    for entry in SV {
//                        dict[entry.language]?.append(entry.name)
//                    }
//                    print(dict)
//                }
        }
        else if(pageName == "Speech-to-Text"){
            
        }
        
        
    }
}

struct SettingsDetails_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetails(pageName: "Saved Phrases")
    }
}
