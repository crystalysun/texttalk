//
//  Message.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import Foundation
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> ab999ff (Add local files)
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
}
<<<<<<< HEAD
=======
>>>>>>> fbb5205 (Contacts display with sample contacts, messages display with sample messages, toggle STT TTS setting)
=======
>>>>>>> ab999ff (Add local files)
