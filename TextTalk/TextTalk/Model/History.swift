/*
 https://developer.apple.com/tutorials/app-dev-training/transcribing-speech-to-text
 */

// cgon


import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var lengthInMinutes: Int
    var transcript: String?

    init(id: UUID = UUID(), date: Date = Date(), lengthInMinutes: Int = 5, transcript: String? = nil) {
        self.id = id
        self.date = date
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
