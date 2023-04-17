//
//  Phrase.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import Foundation

class Phrase: Identifiable, Comparable {
    public var id: Int
    var content: String
    public var isHidden: Bool
    public var isFav: Bool
    
    init(id: Int, content: String) {
        self.id = id
        self.content = content
        self.isHidden = false
        self.isFav = false
    }

    static func == (lhs: Phrase, rhs: Phrase) -> Bool {
        return lhs.content == rhs.content
    }
    
    static func < (lhs: Phrase, rhs: Phrase) -> Bool {
        return lhs.content < rhs.content
    }
}

class Phrases: ObservableObject  {
    @Published var data: [Phrase] = [ Phrase(id: 1, content: "Hello!"),
                                      Phrase(id: 2, content: "How are you?"),
                                      Phrase(id: 3, content: "What's up?"),
                                      Phrase(id: 4, content: "Good morning!"),
                                      Phrase(id: 5, content: "Good afternoon!"),
                                      Phrase(id: 6, content: "Good night!"),
                                      Phrase(id: 7, content: "May I ask who is calling, please?"),
                                      Phrase(id: 8, content: "How can I help?"),
                                      Phrase(id: 9, content: "What can I do for you?"),
                                      Phrase(id: 10, content: "One moment please."),
                                      Phrase(id: 11, content: "Could you please repeat that?"),
                                      Phrase(id: 12, content: "Would you like to leave a message?"),
                                      Phrase(id: 13, content: "Could I leave a message?"),
                                      Phrase(id: 14, content: "Nice to hear from you!"),
                                      Phrase(id: 15, content: "I have to let you go now."),
                                      Phrase(id: 16, content: "Talk again soon!"),
                                      Phrase(id: 17, content: "Bye!"),
                                      Phrase(id: 18, content: "Thank you!") ]
    
    public func sortedPhrases() -> [Phrase] {
        return self.data.sorted(by: { $0 < $1 })
    }
    
    public func updatePhrase(phrase: Phrase) {
        if (phrase.isFav) {
            if let index = self.data.firstIndex(where: { $0.id == phrase.id }) {
                self.data.remove(at: index)
                self.data.insert(phrase, at: 0)
            }
            else {
                print("ERROR: could not find original phrase to update")
            }
        }
        else {
            self.data = self.data.map { $0.id == phrase.id ? phrase : $0 }
        }
    }
    
    public func removePhrase(phrase: Phrase) {
        self.data = self.data.filter { $0 != phrase }
    }
    
    public func append(id: Int, content: String) {
        self.data.append(Phrase(id: id, content: content))
    }
    
    public func remove(indexSet: IndexSet) {
        self.data.remove(atOffsets: indexSet);
    }
}
