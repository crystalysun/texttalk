//
//  Message.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import Foundation
import SwiftUI


struct Message: Hashable, Codable, Identifiable {
    var id: Int
    var sender: String
    var content: String
    var timeSent: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    init(id: Int, /*sender: String,*/ content: String /*, timeSent: String, imageName: String*/){
        self.id = id
        self.sender = "Claudia"
        self.content = content
        self.timeSent = "12:53"
        self.imageName = "user-f"
        
    }
}

class Messages: ObservableObject  {
    @Published var data: [Message] = []
    
    func append(id: Int, content: String) {
        self.data.append(Message(id: id, content: content))
    }
}

