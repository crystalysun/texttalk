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
    
    init(id: Int = -1, /*sender: String,*/ content: String = "", timeSent: String = ""/*, imageName: String*/){
        self.id = id
        self.sender = "Claudia"
        self.content = content
        self.timeSent = timeSent
        self.imageName = "user-f"
        
    }
    
}

class Messages: ObservableObject  {
    @Published var data: [Message] = []
    
    func append(id: Int, content: String) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        var timeSent = ""

        if (hour == 0) {
            timeSent += "12:" + String(minutes) + " AM"
        }
        else if (hour < 13) {
            timeSent += String(hour) + ":" + String(minutes) + " AM"
        }
        else {
            let newHour = hour - 12
            timeSent += String(newHour) + ":" + String(minutes) + " PM"
        }
        self.data.append(Message(id: id, content: content, timeSent: timeSent))
    }
}

