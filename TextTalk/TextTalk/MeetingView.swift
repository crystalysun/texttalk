/*
 https://developer.apple.com/tutorials/app-dev-training/transcribing-speech-to-text
 */

// cgon


import SwiftUI
import AVFoundation

struct MeetingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @Binding var call: Call

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.black)
            VStack {
                MeetingTimerView(speakers: call.callMembers, isRecording: isRecording, theme: .buttercup)
            }
        }
        .padding()
//        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
//            scrumTimer.reset(lengthInMinutes: call.lengthInMinutes, callMembers: scrum.attendees)
//            scrumTimer.speakerChangedAction = {
//                player.seek(to: .zero)
//                player.play()
//            }
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            isRecording = true
//            scrumTimer.startScrum()
        }
        .onDisappear {
//            scrumTimer.stopScrum()
            speechRecognizer.stopTranscribing()
            isRecording = false
            let newHistory = History(lengthInMinutes: call.lengthInMinutes, transcript: speechRecognizer.transcript)
            call.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct MeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetingView(call: .constant(call.sampleData[0]))
//    }
//}
