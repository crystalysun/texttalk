//
//  VoiceSettingsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/23/23.
//

import SwiftUI
import AVFoundation


public enum OSSVoiceEnum: String, CaseIterable {
    /// Australian
    case Australian = "en-AU"
    /// Brazilian
    case Brazilian = "pt-BR"
    /// Bulgarian
    case Bulgarian = "bg-BG"
    /// CanadianFrench
    case CanadianFrench = "fr-CA"
    /// Chinese Traditional
    case Chinese = "zh-CH"
    /// Chinese Simplified
    case ChineseSimplified = "zh-CN"
    /// ChineseHongKong
    case ChineseHongKong = "zh-HK"
    /// Croatian
    case Croatian = "hr-HR"
    /// Czech
    case Czech = "cs-CZ"
    /// Danish
    case Danish = "da-DK"
    /// DutchBelgium
    case DutchBelgium = "nl-BE"
    /// DutchNetherlands
    case DutchNetherlands = "nl-NL"
    /// English
    case English = "en-GB"
    /// Finnish
    case Finnish = "fi-FI"
    /// French
    case French = "fr-FR"
    /// German
    case German = "de-DE"
    /// Greek
    case Greek = "el-GR"
    /// Hebrew
    case Hebrew = "he-IL"
    /// Hindi
    case Hindi = "hi-IN"
    /// Hungarian
    case Hungarian = "hu-HU"
    /// Indian English
    case IndianEnglish = "en-IN"
    /// Indonesian
    case Indonesian = "id-ID"
    /// IrishEnglish
    case IrishEnglish = "en-IE"
    /// Italian
    case Italian = "it-IT"
    /// Japanese
    case Japanese = "ja-JP"
    /// Korean
    case Korean = "ko-KR"
    /// Malaysian
    case Malay = "ms-MY"
    /// Mexican
    case Mexican = "es-MX"
    /// Norwegian
    case Norwegian = "no-NO"
    /// Norwegian Bokmal
    case NorwegianBokmal = "nb-NO"
    /// Polish
    case Polish = "pl-PL"
    /// Portuguese
    case Portuguese = "pt-PT"
    /// Romanian
    case Romanian = "ro-RO"
    /// Russian
    case Russian = "ru-RU"
    /// SaudiArabian
    case SaudiArabian = "ar-SA"
    /// Slovakian
    case Slovakian = "sk-SK"
    /// South African English
    case SouthAfricanEnglish = "en-ZA"
    /// Spanish
    case Spanish = "es-ES"
    /// Catalan
    case SpanishCatalan = "ca-ES"
    /// Swedish
    case Swedish = "sv-SE"
    /// Taiwanese
    case TaiwaneseChinese  = "zh-TW"
    /// Thai
    case Thai = "th-TH"
    /// Turkish
    case Turkish = "tr-TR"
    /// Ukranian
    case Ukranian = "uk-UA"
    /// USA English
    case UnitedStatesEnglish = "en-US"
    /// Vietnamese
    case Vietnamese = "vi-VN"
    /// Arabic World
    case ArabicWorld = "ar-001"
}

//let voicesUS: [Phrase] = [Phrase(id: 1, content: "Samantha")]
//let voicesAU: [Phrase] = [Phrase(id: 1, content: "Karen")]
//let voicesUK: [Phrase] = [Phrase(id: 1, content: "Daniel")]
//let voicesIE: [Phrase] = [Phrase(id: 1, content: "Moira")]
//let voicesIN: [Phrase] = [Phrase(id: 1, content: "Rishi")]
//let voicesZA: [Phrase] = [Phrase(id: 1, content: "Tessa")]
var currentVoices: [Phrase] = []
struct VoiceSettingsView: View {
    @ObservedObject var languages : Languages
    
    var body: some View {
        List {
            OutlineGroup(languages.data, children: \.voices) { lang in
                
                if(lang.isVoice){
                    Button("\(lang.language)"){
                        voiceName = lang.language
                    }
                } else{
                    Text("\(lang.language)")
                }
                
//                    .onAppear() {
//                        print("\(lang.language) \(lang.voices![0].language)")
//                    }
            }
        }
//        ScrollView {
//            VStack {
//                ForEach(Array(dict.keys.sorted(by: <)), id: \.self){ key in
//
//                    Button(key) {
//                        print(dict[key]!)
//                    }
//
//                }
//            }
//        }
    }
}

struct Voices: View {
    var body: some View {
        Text("hi")
    }
}

struct VoiceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceSettingsView(languages: languages)
    }
}

struct VoiceOption: View {
    var voice = ""
    var body: some View {
        Button(action: {
            voiceName = voice
        })  {
            HStack(spacing:15){
                
                Text(voice)
                
                Spacer(minLength: 0)

            }.padding()
                .foregroundColor(Color.black)
        }
    }
}
