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
    @State private var tempSTTid = -1
    @State var input: String = ""
    @State var idCount = 0
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
                    TextField("message", text: $input)
                    
                    Button("Send"){
                        print("Sent!")
                        messages.append(id: idCount, content: input)
                        idCount = idCount + 1
                        print(messages.data)
                        
                        let utterance = AVSpeechUtterance(string: input)
                        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")

                        let synth = AVSpeechSynthesizer()
                        synth.speak(utterance)
                        // NEW:
                        input = ""
                    }
                }
                else {
                    if isRecording == false {
                        Button("Start") {
                            print("Starting")
                            //CLAUDIA:
                            tempSTTid = idCount
                            messages.append(id: idCount, content: "...")
                            recognizer.reset()
                            recognizer.transcribe()
                            isRecording = true
                            
                        }
                    }
                    else {
                        Button("Stop") {
                            print("Stopping")
                            //CLAUDIA:
                            let seconds = 0.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                // Put your code which should be executed with a delay here
                            
                                recognizer.stopTranscribing()
                                print(recognizer.transcript)
                                messages.data[tempSTTid].content = recognizer.transcript
    //                            messages.append(id: idCount, content: recognizer.transcript)
                                idCount = idCount + 1
                                isRecording = false
                            }
                            
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
                
            }
            
        }
        
        
        
    }
}

struct CallInput_Previews: PreviewProvider {
    static var previews: some View {
        CallInput()
    }
}
