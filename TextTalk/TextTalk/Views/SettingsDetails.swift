//
//  SettingsDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import SwiftUI

var phrases: [Phrase] = [Phrase(id: 1, content: "Hi"), Phrase(id: 2, content: "Hello"), Phrase(id: 3, content: "Good morning"), Phrase(id: 4, content: "Good night"), Phrase(id: 5, content: "Bye"), Phrase(id: 6, content: "Thank you")]

struct SettingsDetails: View {
    var pageName: String

    var body: some View {
        if (pageName == "Saved Phrases") {
            List(phrases) { phrase in
                Text(phrase.content)
            }
            .navigationTitle("Saved Phrases")
        }
        else {
            Text(pageName)
        }
    }
}

struct SettingsDetails_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetails(pageName: "Saved Phrases")
    }
}
