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
    @ObservedObject var messages = Messages()
    @StateObject var recognizer = SpeechRecognizer()
    @State private var isTts: Bool = false
    @State private var isRecording = false
    @State var input: String = ""
    @State var idCount = 2
    @State private var callActive: Bool = true
    
    var body: some View {
        if !callActive {
            Text("Call not active. No messages to display.")
        }
        
        ScrollView {
            ForEach(self.messages.data, id: \.self) { message in
                MessageBubble(message: message)
            }
        }
        
        VStack {
            Text(isTts ? "Text to Speech" : "Speech to Text")
            
            HStack {
                if isTts {
                    Button("Send"){
                        print("Sent!")
                        messages.append(id: idCount, content: input)
                        idCount = idCount + 1
                        print(messages.data)
                        
                        let utterance = AVSpeechUtterance(string: input)
                        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")

                        let synth = AVSpeechSynthesizer()
                        synth.speak(utterance)
                    }
                }
                else {
                    if isRecording == false {
                        Button("Start") {
                            print("Starting")
                            isRecording = true
                            recognizer.transcribe()
                            
                        }
                    }
                    else {
                        Button("Stop") {
                            print("Stopping")
                            recognizer.stopTranscribing()
                            isRecording = false
                            print(recognizer.transcript)
                            messages.append(id: idCount, content: recognizer.transcript)
                            idCount = idCount + 1
                            recognizer.reset()
                        }
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
