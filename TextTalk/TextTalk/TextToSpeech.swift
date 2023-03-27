import AVFoundation

func TTS(text: String, accent: String, speed: Float, gen: String){
    let utterance = AVSpeechUtterance(string: text)

    
    utterance.voice = AVSpeechSynthesisVoice(language: accent)

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
    utterance.voice = AVSpeechSynthesisVoice(gender: gen)
    let synthesizer = AVSpeechSyntheziser()

    synthesizer.speech(utterance)
}

// TTS(text: "Hi good morning", accent: "American", speed: 1.0, gen: "female")
