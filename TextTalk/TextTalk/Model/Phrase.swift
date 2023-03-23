//
//  Phrase.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import Foundation

class Phrase: Identifiable, Comparable {
    var id: Int
    var content: String
    var frequency: Int
    
    init(id: Int, content: String) {
        self.id = id
        self.content = content
        self.frequency = 0
    }

    static func == (lhs: Phrase, rhs: Phrase) -> Bool {
        return lhs.content == rhs.content
    }
    
    static func < (lhs: Phrase, rhs: Phrase) -> Bool {
        return lhs.content < rhs.content
    }
}

class Phrases: ObservableObject  {
    @Published var data: [Phrase] = [ Phrase(id: 1, content: "Hi"),
                                      Phrase(id: 2, content: "Hello"),
                                      Phrase(id: 3, content: "Good morning"),
                                      Phrase(id: 4, content: "Good night"),
                                      Phrase(id: 5, content: "Bye"),
                                      Phrase(id: 6, content: "Thank you") ]
    
    public func append(id: Int, content: String) {
        self.data.append(Phrase(id: id, content: content))
    }
}
