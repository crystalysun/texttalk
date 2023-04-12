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
    @ObservedObject var phrases = phraseGlobal
    @StateObject var recognizer = SpeechRecognizer()
    @State private var isTts: Bool = false
    @State private var isRecording = false
    @State private var tempSTTid = -1
    @State var editMode : EditMode = .inactive
    @State var input: String = ""
    @State var idCount = 0
    @State var isEditing: Bool = false
    @State var editedMessage: Message = Message()
    @State private var callActive: Bool = true
    let synth = AVSpeechSynthesizer()
    
    var body: some View {
        if !callActive {
            Text("Call not active. No messages to display.")
        }
        
        NavigationView {
            List(self.messages.data) { message in
                MessageBubble(message: message)
                .onTapGesture {
                    print(message.content)
//                    isEditing = true
                    editedMessage = message
                    print(editedMessage.id)
                    input = editedMessage.content
//                    TextField("message", text: $input)
//                    editText = message.content
//                    TextField("editMessage", text: $editText)
//                    editText = message.content
                }
            }
            .toolbar {
                EditButton().simultaneousGesture(TapGesture().onEnded {
                    isEditing.toggle()
                    input = ""
                })
            }
            .disabled(isRecording)
            .environment(\.editMode, $editMode)

        }
        
        VStack {
            if isEditing {
                TextField("message", text: $input)
                Button("Send") {
                    editedMessage.content = input
                    if editedMessage.id != -1 {
                        messages.data[editedMessage.id].content = editedMessage.content
                    }
                    print(editedMessage.content)
                    editMode = .inactive
                    isEditing = false
                    input = ""
                }
                .disabled(input == "")
//                input = $editedMessage
//                print($input)
            }
            else {
                Text(isTts ? "Text to Speech" : "Speech to Text")
                
                if isTts{
                    if messages.data.count != 0 {
                        Button("Replay last message") {
                            print("Sent!")
                            print(messages.data)
                            
                            let tempMsg = messages.data.last
                            let utterance = AVSpeechUtterance(string: tempMsg!.content)
                            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle." + voiceName + "-compact")
                            

                            synth.speak(utterance)
                            input = ""
                        }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(phrases.data.sorted(by: { $0 < $1 })) { phrase in
                                Button(phrase.content){
                                    /*messages.append(id: idCount, content: phrase.content)
                                    idCount = idCount + 1
                                    print(messages.data)
                                    
                                    let utterance = AVSpeechUtterance(string: phrase.content)
                                    utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle." + voiceName + "-compact")
                                    print(AVSpeechSynthesisVoice.speechVoices())

                                    synth.speak(utterance)*/
                                    input = phrase.content
                                }
                                .foregroundColor(.white)
                                .controlSize(.large)
                                .padding(10)
                                .background(.blue)

                            }
                        }
                    }
                }
            
                    HStack {
                    if isTts {
                        TextField("message", text: $input)
                        
                        
                        Button("Send") {
                            print("Sent!")
                            messages.append(id: idCount, content: input)
                            idCount = idCount + 1
                            print(messages.data)
                            
                            let utterance = AVSpeechUtterance(string: input)
                            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle." + voiceName + "-compact")

                            synth.speak(utterance)
                            // NEW:
                            input = ""
                            print(AVSpeechSynthesisVoice.speechVoices())
                        }
                        .disabled(input == "")
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
                                let seconds = 0.5
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
                VStack {
                    HStack {
                        Toggle(isOn: $isTts) {
                            Label("TTS", systemImage: "flag.fill")
                            
                        }
                        .toggleStyle(.button)
                        
                        Spacer()
                            .frame(width: 50)

                        
                        Toggle(isOn: not($isTts)) {
                            Label("STT", systemImage: "flag.fill")
                        }
                        .toggleStyle(.button)
                    }
                }
            }
        }
        
    }
    func edit(at message: Message) {
        print(message.id, message.content)
    }
}

struct CallInput_Previews: PreviewProvider {
    static var previews: some View {
        CallInput()
    }
}
