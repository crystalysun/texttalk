//
//  SoundManager.swift
//  TextTalk
//
//  Created by Marie Phillips on 2/10/23.
//


import AVFoundation

struct SoundManager {
    static func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.playAndRecord, mode: .videoChat)
            try session.setPreferredIOBufferDuration(0.005)
            try session.setPreferredSampleRate(4_410)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static func routeAudioToSpeaker() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(
            .playAndRecord,
            mode: .videoChat,
            options: [.defaultToSpeaker, .allowBluetooth])
    }
}
