//
//  SpeechSettingsView.swift
//  TextTalk
//
//  Created by Claudia Gonciulea on 4/16/23.
//

import Foundation
import SwiftUI
import AVFoundation
import Speech

struct STTLang: Identifiable {
    let id = UUID()
    let code: String
    
    init(code: String) {
        self.code = code
    }
}

var supportedstt = SFSpeechRecognizer.supportedLocales()
var sttlanguages = supportedstt.map { STTLang(code: $0.identifier.replacingOccurrences(of: " (fixed)", with: "")) }


struct SpeechSettingsView: View {
    var body: some View {
        List(sttlanguages) { sttlanguage in
            Button(sttlanguage.code){
                    selectedLocale = sttlanguage.code
                    print(selectedLocale)
                }
            }
        }
    }
