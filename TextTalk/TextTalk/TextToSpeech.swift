import AVFoundation

func TTS(text: String, accent: String, speed: Float){
    let utterance = AVSpeechUtterance(string: text)
    
    switch accent {
        case "American":
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        case "British":
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        case "Australian":
            utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        case "Irish":
            utterance.voice = AVSpeechSynthesisVoice(language: "en-IE")
        case "South African":
            utterance.voice = AVSpeechSynthesisVoice(language: "en-ZA")
        default:
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
    utterance.rate = speed

    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
}

TTS(text: "Hello", accent: "American", speed: 1.0)