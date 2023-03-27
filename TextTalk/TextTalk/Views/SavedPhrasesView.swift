//
//  SavedPhrasesView.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/23/23.
//

import SwiftUI

struct SavedPhrasesView: View {
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
        List(phrases.data.sorted(by: { $0 < $1 })) { phrase in
            Text(phrase.content)
        }
        .navigationTitle("Saved Phrases")
        
        Button("Add New Phrase") {
            addPhrase = true
        }
        .sheet(isPresented: $addPhrase) {
            AddPhraseSheet()
        }
    }
}

struct SavedPhrasesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPhrasesView()
    }
}
