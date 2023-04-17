//
//  VoiceSettingsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/23/23.
//

import SwiftUI

let voicesUS: [Phrase] = [Phrase(id: 1, content: "Samantha")]
let voicesAU: [Phrase] = [Phrase(id: 1, content: "Karen")]
let voicesUK: [Phrase] = [Phrase(id: 1, content: "Daniel")]
let voicesIE: [Phrase] = [Phrase(id: 1, content: "Moira")]
let voicesIN: [Phrase] = [Phrase(id: 1, content: "Rishi")]
let voicesZA: [Phrase] = [Phrase(id: 1, content: "Tessa")]

struct VoiceSettingsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Customize Voices")
                    .font(.title)
                    .fontWeight(.bold)
                VStack(spacing: 10) {
                    Text("Current Voice:")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(voiceName)")
                        .font(.headline)
                }
                List {
                    Section(header: Text("English (US)")) {
                        ForEach(voicesUS) { voice in
                            VoiceOption(voice:voice.content)
                        }
                    }
                    Section(header: Text("English (Australia)")) {
                        ForEach(voicesAU) { voice in
                            VoiceOption(voice:voice.content)
                        }
                    }
                    Section(header: Text("English (UK)")) {
                        ForEach(voicesUK) { voice in
                            VoiceOption(voice:voice.content)
                        }
                    }
                    Section(header: Text("English (Ireland)")) {
                        ForEach(voicesIE) { voice in
                            VoiceOption(voice:voice.content)
                        }
                    }
                    Section(header: Text("English (India)")) {
                        ForEach(voicesIN) { voice in
                            VoiceOption(voice:voice.content)
                        }
                    }
                    Section(header: Text("English (South Africa)")) {
                        ForEach(voicesZA) { voice in
                            VoiceOption(voice:voice.content)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .padding()
            //.navigationBarTitle("Voices", displayMode: .large)
        }
    }
}

struct VoiceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceSettingsView()
    }
}

struct VoiceOption: View {
    var voice = ""
    var body: some View {
        Button(action: {
            voiceName = voice
        })  {
            HStack(spacing:15){
                
                Text(voice)
                
                Spacer()
                if voiceName == voice {
                    Image(systemName: "checkmark")
                    .foregroundColor(.blue)
                }

            }
            .padding(.vertical, 10)
            .foregroundColor(Color.black)
        }
    }
}
