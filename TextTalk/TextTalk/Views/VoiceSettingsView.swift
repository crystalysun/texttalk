//
//  VoiceSettingsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/23/23.
//

import SwiftUI

var voiceName: String = ""

let voicesUS: [Phrase] = [Phrase(id: 1, content: "Samantha")]
let voicesAU: [Phrase] = [Phrase(id: 1, content: "Karen")]
let voicesUK: [Phrase] = [Phrase(id: 1, content: "Daniel")]
let voicesIE: [Phrase] = [Phrase(id: 1, content: "Moira")]
let voicesIN: [Phrase] = [Phrase(id: 1, content: "Rishi")]
let voicesZA: [Phrase] = [Phrase(id: 1, content: "Tessa")]

struct VoiceSettingsView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("English (US)")
                ForEach(voicesUS) { voice in
                    VoiceOption(voice:voice.content)
                }
                Text("English (Australia)")
                ForEach(voicesAU) { voice in
                    VoiceOption(voice:voice.content)
                }
                Text("English (UK)")
                ForEach(voicesUK) { voice in
                    VoiceOption(voice:voice.content)
                }
                Text("English (Ireland)")
                ForEach(voicesIE) { voice in
                    VoiceOption(voice:voice.content)
                }
            }
            Text("English (India)")
            ForEach(voicesIN) { voice in
                VoiceOption(voice:voice.content)
            }
            Text("English (South Africa)")
            ForEach(voicesZA) { voice in
                VoiceOption(voice:voice.content)
            }
            
        }
        
//        VStack{
//            
//            List(voicesUS) { voice in
//                VoiceOption(voice:voice.content)
//            }
//            Text("English (Australia)")
//            List(voicesAU) { voice in
//                VoiceOption(voice:voice.content)
//            }
//            Text("English (India)")
//            List(voicesIN) { voice in
//                VoiceOption(voice:voice.content)
//           
//            }
//            Text("English (Ireland)")
//            List(voicesIE) { voice in
//                VoiceOption(voice:voice.content)
//            }
//            Text("English (South Africa)")
//            List(voicesZA) { voice in
//                VoiceOption(voice:voice.content)
//            }
//            Text("English (UK)")
//            List(voicesUK) { voice in
//                VoiceOption(voice:voice.content)
//            }
//        
//        }
            
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
                
                Spacer(minLength: 15)

            }.padding()
                .foregroundColor(Color.black)
        }
    }
}
