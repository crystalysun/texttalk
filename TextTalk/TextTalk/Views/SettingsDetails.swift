//
//  SettingsDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import SwiftUI
import AVFoundation
import Speech

// Update Languages
var SV = AVSpeechSynthesisVoice.speechVoices()
var ttscodes = Set(SV.map { $0.language })
var ttsdict : Dictionary<String,[String]> = Dictionary(uniqueKeysWithValues: ttscodes.map {($0, [])})
var ttslanguages = Languages(dict: ttsdict)


//var sttlanguages : [String] = supportedstt.map { $0.languageCode!.replacingOccurrences(of: " (fixed)", with: "") }


struct SettingsDetails: View {
    var pageName: String
    @Binding var passwordSet : Bool
    @Binding var key : String
    @State private var createPass: Bool = false
    @State private var wrongPass = false
    @State private var helpSheet = false
    
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
                ttsdict = Dictionary(uniqueKeysWithValues: ttscodes.map {($0, [])})
                for entry in SV {
                    ttsdict[entry.language]?.append(entry.name)
                }
                print(ttsdict)
            }
            
            
        }
        
        if(pageName == "Text-to-Speech") {
            VoiceSettingsView(languages: ttslanguages)
        }
        else if(pageName == "Speech-to-Text") {
            SpeechSettingsView()
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



struct SettingsDetails_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetails(pageName: "Saved Phrases")
    }
}
