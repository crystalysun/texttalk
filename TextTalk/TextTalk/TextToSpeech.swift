import AVFoundation

func TTS(text: String, accent: String, language: String, speed: Float, gen: String){
    let utterance = AVSpeechUtterance(text)

    
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
    }

    utterance.rate = speed
    utterance.gender = gen
    let synthesizer = AVSpeechSyntheziser()
    
    synthesizer.speech(utterance)
}