//
//  Message.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import Foundation
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> ab999ff (Add local files)
import SwiftUI

=======
import SwiftUI


>>>>>>> f39e8d40395c80ea0efe4bd390c63cbb10e6a19c
struct Message: Hashable, Codable, Identifiable {
    var id: Int
    var sender: String
    var content: String
    var timeSent: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
<<<<<<< HEAD
}
<<<<<<< HEAD
=======
>>>>>>> fbb5205 (Contacts display with sample contacts, messages display with sample messages, toggle STT TTS setting)
=======
>>>>>>> ab999ff (Add local files)
=======
    
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

>>>>>>> f39e8d40395c80ea0efe4bd390c63cbb10e6a19c
