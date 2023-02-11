//
//  Contact.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import Foundation
import SwiftUI

struct Number: Hashable, Codable {
    let type: String
    let number: String
}

struct Contact: Hashable, Codable, Identifiable {
    var id: Int
    var firstName: String
    var lastName: String
    var numbers: [Number] = []
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
