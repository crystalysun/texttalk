//
//  EditPhrasesView.swift
//  TextTalk
//
//  Created by Crystal Sun on 4/13/23.
//

import SwiftUI

struct EditPhrasesView: View {
    @State var input: String
    @State var phrase: Phrase
    
    var body: some View {
        VStack {
            Text("Phrase: \(phrase.content)")
                .font(.title)
            
            Spacer()
            
            Text("Edit phrase here:")
            TextField("Edit phrase here", text: $input)
                .border(Color.blue)
                .padding()
            Button("Update Phrase") {
                phrase.content = input
                phraseGlobal.updatePhrase(phrase: phrase)
                input = ""
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
            
            Button(phrase.isFav ? "Remove from Favorites" : "Add to Favorites") {
                phrase.isFav = !phrase.isFav
                phraseGlobal.updatePhrase(phrase: phrase)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        VStack {
            Button(phrase.isHidden ? "Show on Active Call Page": "Hide From View") {
                phrase.isHidden = !phrase.isHidden
                phraseGlobal.updatePhrase(phrase: phrase)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button("Delete Phrase") {
                phraseGlobal.removePhrase(phrase: phrase)
            }
            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0))
            .padding()
        }
    }
}

struct EditPhrasesView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhrasesView(input: phraseGlobal.data[0].content, phrase: phraseGlobal.data[0])
    }
}
