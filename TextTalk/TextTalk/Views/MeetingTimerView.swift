/*
 https://developer.apple.com/tutorials/app-dev-training/transcribing-speech-to-text
 */

// cgon


import SwiftUI

struct MeetingTimerView: View {
    let speakers: [Call.Callee]
    let isRecording: Bool
    let theme: Theme
    
//    private var currentSpeaker: String {
//        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
//    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
//                    Text(currentSpeaker)
//                        .font(.title)
//                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
//            .overlay  {
//                ForEach(speakers) { speaker in
//                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
//                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
//                            .rotation(Angle(degrees: -90))
//                            .stroke(theme.mainColor, lineWidth: 12)
//                    }
//                }
//            }
            .padding(.horizontal)
    }
}

//struct MeetingTimerView_Previews: PreviewProvider {
//    typealias Previews = <#type#>
//
//    static var speakers: [Call.Callee] {
//        [Call.Callee.init(), Call.Callee.init()]
////            ScrumTimer.Speaker(name: "Kim", isCompleted: true), ScrumTimer.Speaker(name: "Bill", isCompleted: false)]
//    }
//
////    static var previews: some View {
////        MeetingTimerView(speakers: speakers, isRecording: true, theme: .yellow)
////    }
//}
