//
//  Language.swift
//  TextTalk
//
//  Created by Crystal Sun on 4/13/23.
//

import Foundation
import SwiftUI
import AVFoundation

class Language: Identifiable, Comparable {
    var id = UUID()
    public var language: String
    var voices: [Language]?
    var isVoice: Bool
    
    init(language: String, voices: [String]) {
        self.language = language
        
        if (!voices.isEmpty) {
            self.voices = []
            self.isVoice = false
            for voice in voices {
                print(voice)
                self.voices?.append(Language(language: voice, voices: []))
            }
        }else{
            self.isVoice = true
        }
    }

    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.language == rhs.language
    }
    
    static func < (lhs: Language, rhs: Language) -> Bool {
        return lhs.language < rhs.language
    }
}

class Languages: ObservableObject  {
    @Published var data: [Language] = []
    
    init(dict: Dictionary<String,[String]>) {
        for (key, val) in dict {
            self.data.append(Language(language: key, voices: val))
        }
    }
}
