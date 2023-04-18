//
//  VoiceSettingsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/23/23.
//

import SwiftUI
import AVFoundation


public enum OSSVoiceEnum: String, CaseIterable {
    // Australian
    case Australian = "en-AU"
    // Brazilian
    case Brazilian = "pt-BR"
    // Bulgarian
    case Bulgarian = "bg-BG"
    // CanadianFrench
    case CanadianFrench = "fr-CA"
    // Chinese Traditional
    case Chinese = "zh-CH"
    // Chinese Simplified
    case ChineseSimplified = "zh-CN"
    // ChineseHongKong
    case ChineseHongKong = "zh-HK"
    // Croatian
    case Croatian = "hr-HR"
    // Czech
    case Czech = "cs-CZ"
    // Danish
    case Danish = "da-DK"
    // DutchBelgium
    case DutchBelgium = "nl-BE"
    // DutchNetherlands
    case DutchNetherlands = "nl-NL"
    // English
    case English = "en-GB"
    // Finnish
    case Finnish = "fi-FI"
    // French
    case French = "fr-FR"
    // German
    case German = "de-DE"
    // Greek
    case Greek = "el-GR"
    // Hebrew
    case Hebrew = "he-IL"
    // Hindi
    case Hindi = "hi-IN"
    // Hungarian
    case Hungarian = "hu-HU"
    // Indian English
    case IndianEnglish = "en-IN"
    // Indonesian
    case Indonesian = "id-ID"
    // IrishEnglish
    case IrishEnglish = "en-IE"
    // Italian
    case Italian = "it-IT"
    // Japanese
    case Japanese = "ja-JP"
    // Korean
    case Korean = "ko-KR"
    // Malaysian
    case Malay = "ms-MY"
    // Mexican
    case Mexican = "es-MX"
    // Norwegian
    case Norwegian = "no-NO"
    // Norwegian Bokmal
    case NorwegianBokmal = "nb-NO"
    // Polish
    case Polish = "pl-PL"
    // Portuguese
    case Portuguese = "pt-PT"
    // Romanian
    case Romanian = "ro-RO"
    // Russian
    case Russian = "ru-RU"
    // SaudiArabian
    case SaudiArabian = "ar-SA"
    // Slovakian
    case Slovakian = "sk-SK"
    // South African English
    case SouthAfricanEnglish = "en-ZA"
    // Spanish
    case Spanish = "es-ES"
    // Catalan
    case SpanishCatalan = "ca-ES"
    // Swedish
    case Swedish = "sv-SE"
    // Taiwanese
    case TaiwaneseChinese  = "zh-TW"
    // Thai
    case Thai = "th-TH"
    // Turkish
    case Turkish = "tr-TR"
    // Ukranian
    case Ukranian = "uk-UA"
    // USA English
    case UnitedStatesEnglish = "en-US"
    // Vietnamese
    case Vietnamese = "vi-VN"
    // Arabic World
    case ArabicWorld = "ar-001"
    
    static func withLabel(_ label: String) -> OSSVoiceEnum? {
        return self.allCases.first{ "\($0)" == label }
        }
}

func codeToStr(code: String) -> String {
    if code == "en-AU" {
        return "Australian"
    }
    else if code == "pt-BR" {
        return "Brazilian"
    }
    else if code == "bg-BG" {
        return "Bulgarian"
    }
    else if code == "fr-CA" {
        return "French (Canadian)"
    }
    else if code == "zh-CH" {
        return "Chinese (Traditional)"
    }
    else if code == "zh-CN" {
        return "Chinese (Simplified)"
    }
    else if code == "zh-HK" {
        return "Chinese (Hong Kong)"
    }
    else if code == "hr-HR" {
        return "Croatian"
    }
    else if code == "cs-CZ" {
        return "Czech"
    }
    else if code == "da-DK" {
        return "Danish"
    }
    else if code == "nl-BE" {
        return "Dutch (Belgium)"
    }
    else if code == "nl-NL" {
        return "Dutch (Netherlands)"
    }
    else if code == "en-GB" {
        return "English (UK)"
    }
    else if code == "fi-FI" {
        return "Finnish"
    }
    else if code == "fr-FR" {
        return "French"
    }
    else if code == "de-DE" {
        return "German"
    }
    else if code == "el-GR" {
        return "Greek"
    }
    else if code == "he-IL" {
        return "Hebrew"
    }
    else if code == "hi-IN" {
        return "Hindi"
    }
    else if code == "hu-HU" {
        return "Hungarian"
    }
    else if code == "en-IN" {
        return "English (Indian)"
    }
    else if code == "id-ID" {
        return "Indonesian"
    }
    else if code == "en-IE" {
        return "English (Irish)"
    }
    else if code == "it-IT" {
        return "Italian"
    }
    else if code == "ja-JP" {
        return "Japanese"
    }
    else if code == "ko-KR" {
        return "Korean"
    }
    else if code == "ms-MY" {
        return "Malaysian"
    }
    else if code == "es-MX" {
        return "Spanish (Mexican)"
    }
    else if code == "no-NO" {
        return "Norwegian"
    }
    else if code == "nb-NO" {
        return "Norwegian (Bokmal)"
    }
    else if code == "pl-PL" {
        return "Polish"
    }
    else if code == "pt-PT" {
        return "Portuguese"
    }
    else if code == "ro-RO" {
        return "Romanian"
    }
    else if code == "ru-RU" {
        return "Russian"
    }
    else if code == "ar-SA" {
        return "Saudi Arabian"
    }
    else if code == "sk-SK" {
        return "Slovakian"
    }
    else if code == "en-ZA" {
        return "English (South African)"
    }
    else if code == "es-ES" {
        return "Spanish (Spain)"
    }
    else if code == "ca-ES" {
        return "Catalan"
    }
    else if code == "sv-SE" {
        return "Swedish"
    }
    else if code == "zh-TW" {
        return "Chinese (Taiwanese)"
    }
    else if code == "th-TH" {
        return "Thai"
    }
    else if code == "tr-TR" {
        return "Turkish"
    }
    else if code == "uk-UA" {
        return "Ukranian"
    }
    else if code == "en-US" {
        return "English (United States)"
    }
    else if code == "vi-VN" {
        return "Vietnamese"
    }
    else if code == "ar-001" {
        return "Arabic World"
    }
    else {
        return code
    }
}

var currentVoices: [Phrase] = []
struct VoiceSettingsView: View {
    @ObservedObject var languages : Languages
    
    var body: some View {
//        NavigationView {
//            VStack(spacing: 30) {
//                Text("Customize Voices")
//                    .font(.title)
//                    .fontWeight(.bold)
//                VStack(spacing: 10) {
//                    Text("Current Voice:")
//                        .font(.title)
//                        .fontWeight(.bold)
//                    Text("\(voiceName)")
//                        .font(.headline)
//                }
//                List {
//                    Section(header: Text("English (US)")) {
//                        ForEach(voicesUS) { voice in
//                            VoiceOption(voice:voice.content)
//                        }
//                    }
//                    Section(header: Text("English (Australia)")) {
//                        ForEach(voicesAU) { voice in
//                            VoiceOption(voice:voice.content)
//                        }
//                    }
//                    Section(header: Text("English (UK)")) {
//                        ForEach(voicesUK) { voice in
//                            VoiceOption(voice:voice.content)
//                        }
//                    }
//                    Section(header: Text("English (Ireland)")) {
//                        ForEach(voicesIE) { voice in
//                            VoiceOption(voice:voice.content)
//                        }
//                    }
//                    Section(header: Text("English (India)")) {
//                        ForEach(voicesIN) { voice in
//                            VoiceOption(voice:voice.content)
//                        }
//                    }
//                    Section(header: Text("English (South Africa)")) {
//                        ForEach(voicesZA) { voice in
//                            VoiceOption(voice:voice.content)
//                        }
//                    }
//                }
//                .listStyle(GroupedListStyle())
//            }
//            .padding()
//            .navigationBarTitle("Voices", displayMode: .large)

        List {
            OutlineGroup(languages.data, children: \.voices) { lang in
                
                if(lang.isVoice) {
                    Button("\(lang.language)"){
                        voiceName = lang.language
                    }
                } else {
                    let langString = codeToStr(code: lang.language)
                    Text("\(langString)")
                }
            }
        }
    }
}

struct Voices: View {
    var body: some View {
        Text("hi")
    }
}

struct VoiceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceSettingsView(languages: ttslanguages)
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
                
                Spacer()
                if voiceName == voice {
                    Image(systemName: "checkmark")
                    .foregroundColor(.blue)
                }

            }
            .padding(.vertical, 10)
            .foregroundColor(Color.black)
        }
    }
}
