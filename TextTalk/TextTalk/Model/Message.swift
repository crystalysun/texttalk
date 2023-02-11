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
}
