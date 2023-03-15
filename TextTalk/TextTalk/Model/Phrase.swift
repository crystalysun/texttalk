//
//  Phrase.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import Foundation

class Phrase: Identifiable {
    var id: Int
    var content: String
    var frequency: Int
    
    init(id: Int, content: String) {
        self.id = id
        self.content = content
        self.frequency = 0
    }

}
