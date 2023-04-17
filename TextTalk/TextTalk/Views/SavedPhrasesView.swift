//
//  SavedPhrasesView.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/23/23.
//

import SwiftUI

struct SavedPhrasesView: View {
    @State private var addPhrase: Bool = false
    @State private var editPhrase: Bool = false
    @ObservedObject var phrases = phraseGlobal

    private struct AddPhraseSheet: View {
        @State var input: String = ""
        @Environment(\.dismiss) private var dismiss
        @ObservedObject var phrases = phraseGlobal

        var body: some View {
            VStack {
                Text("Add a new custom phrase")
                TextField("Enter phrase here", text: $input)
                HStack {
                    Button("Add") {
                        if(input != "") {
                            phrases.append(id: idNum, content: input)
                            idNum += 1
                        }
                        input = ""
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                    Button("Clear") {
                        input = ""
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
                
                Button("Dismiss") {
                    dismiss()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
    }

    var body: some View {
        List {
            ForEach(self.phrases.data) { phrase in
                if (phrase.isFav) {
                    FavPhraseButtonView(phrase: phrase, editPhrase: editPhrase)
                }
                else {
                    PhraseButtonView(phrase: phrase, editPhrase: editPhrase)
                }
            }
            .onDelete{ indexSet in
                self.phrases.data.remove(atOffsets: indexSet)
            }
            .onMove { indexSet, index in
                self.phrases.data.move(fromOffsets: indexSet, toOffset: index)
            }
        }
        .navigationTitle("Saved Phrases")
        .toolbar {
            EditButton()
        }
        
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

struct EditPhraseSheet: View {
    @State var input: String
    @State var phrase: Phrase
    
    @State var isHidden: Bool
    @State var isFav: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Phrase: \(phrase.content)")
                .font(.title)
                .onAppear() {
                    isHidden = phrase.isHidden
                    isFav = phrase.isFav
                }
            
            Spacer()
            
            Text("Edit phrase here:")
            TextField("Edit phrase here", text: $input)
                .border(Color.blue)
                .padding()
            
            HStack {
                Button("Update Phrase") {
                    phrase.content = input
                    phraseGlobal.updatePhrase(phrase: phrase)
                    input = ""
                    input = phrase.content
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button("Clear") {
                    input = ""
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
            Spacer()
            
            Button(isFav ? "Remove from Favorites" : "Add to Favorites") {
                isFav.toggle()
                phrase.isFav = isFav
                phraseGlobal.updatePhrase(phrase: phrase)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button(isHidden ? "Show on Active Call Page": "Hide From View") {
                isHidden.toggle()
                phrase.isHidden = isHidden
                phraseGlobal.updatePhrase(phrase: phrase)
            }
            .buttonStyle(.borderedProminent)
            
//                Spacer()
            
            Button("Dismiss") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct PhraseButtonView: View {
    var phrase: Phrase
    @State var editPhrase: Bool
    
    var body : some View {
        
        Button(action: {
            editPhrase = true
        })  {
            HStack(spacing:15){
                Text(phrase.content)
                
            }.padding()
        }
        .foregroundColor(.black)
        .sheet(isPresented: $editPhrase) {
            EditPhraseSheet(input: phrase.content, phrase: phrase, isHidden: phrase.isHidden, isFav: phrase.isFav)
        }
    }
}

struct FavPhraseButtonView: View {
    var phrase: Phrase
    @State var editPhrase: Bool
    
    var body : some View {
        
        Button(action: {
            editPhrase = true
        })  {
            HStack(spacing:15){
                Text(phrase.content)
                    .foregroundColor(Color(red:0, green:0, blue:1.0))
                
                Spacer()
            
                Label("", systemImage: "star.fill")
                    .foregroundColor(Color(red:0, green:0, blue:1.0))
                
            }.padding()
        }
        .foregroundColor(.black)
        .sheet(isPresented: $editPhrase) {
            EditPhraseSheet(input: phrase.content, phrase: phrase, isHidden: phrase.isHidden, isFav: phrase.isFav)
        }
    }
}
