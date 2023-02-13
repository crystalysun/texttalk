//
//  CallInput.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI
import AVFoundation
import Speech

struct TtsSttButton: View {
    @Binding var isTts: Bool

    var body: some View {
        Button(isTts ? "Text to Speech" : "Speech to Text") {
            isTts.toggle()
        }
    }
}

func not(_ value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

struct CallInput: View {
    @State private var isTts: Bool = false
    @State private var isRecording = false
    @State var input: String = ""
    @State var idCount = 2
    
    
    var body: some View {
        VStack {
            Text(isTts ? "Text to Speech" : "Speech to Text")
            
            HStack {
                if isTts {
                    Button("Send"){
                        print("Sent!")
                        messages.append(Message(id: idCount, content: input))
                        idCount = idCount + 1
                        print(messages)
                        
                        let utterance = AVSpeechUtterance(string: input)
                        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")

                        let synth = AVSpeechSynthesizer()
                        synth.speak(utterance)
                    }
                }
                else {
                    let recognizer = SpeechRecognizer()

                    Button("Start") {
                        print("Starting")
                        isRecording = true
                        recognizer.transcribe()
                        
                    }
                    
                    Button("Stop") {
                        print("Stopping")
                        recognizer.stopTranscribing()
                        isRecording = false
                        print(recognizer.transcript)
                        messages.append(Message(id: idCount, content: recognizer.transcript))
                        idCount = idCount + 1
                        recognizer.reset()
                    }
                }
            }
        }
        VStack {
//            Text(isTts ? "Text to Speech" : "Speech to Text")
            
            HStack {
                Toggle(isOn: $isTts) {
                    Label("TTS", systemImage: "flag.fill")
                    
                }
                .toggleStyle(.button)
                
                Toggle(isOn: not($isTts)) {
                    Label("STT", systemImage: "flag.fill")
                }
                .toggleStyle(.button)
            }
            if isTts{
                TextField("message", text: $input)
            }
            
        }
        
        
        
            }
}

struct CallInput_Previews: PreviewProvider {
    static var previews: some View {
        CallInput()
    }
}
