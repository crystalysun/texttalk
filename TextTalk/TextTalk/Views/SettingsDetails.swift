//
//  SettingsDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import SwiftUI

var phraseGlobal = Phrases()
var idNum = 7

struct SettingsDetails: View {
    var pageName: String
    @State private var addPhrase: Bool = false
    @ObservedObject var phrases = phraseGlobal

    private struct AddPhraseSheet: View {
        @State var input: String = ""
        @Environment(\.dismiss) private var dismiss
        @ObservedObject var phrases = phraseGlobal

        var body: some View {
            VStack {
                Text("Add a new custom phrase")
                TextField("Enter phrase here", text: $input)
                Button("Add") {
                    phrases.append(id: idNum, content: input)
                    idNum += 1
                    dismiss()
                    input = ""
                }
            }
        }
    }
    
    var body: some View {
        if (pageName == "Saved Phrases") {
            List(phrases.data.sorted(by: { $0 < $1 })) { phrase in
                Text(phrase.content)
            }
            .navigationTitle("Saved Phrases")
        }
        else {
            Text(pageName)
        }
        
        Button("Add New Phrase") {
            addPhrase = true
        }
        .sheet(isPresented: $addPhrase) {
            AddPhraseSheet()
        }
    }
}

struct SettingsDetails_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetails(pageName: "Saved Phrases")
    }
}
