//
//  Contact.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import Foundation
import SwiftUI

struct Number: Hashable, Codable {
    var type: String
    var number: String
}

class Contact: Identifiable/* Hashable, Codable*/ {
    var id: Int
    var firstName: String
    var lastName: String
    var numbers: [Number] = []
    
    private var imageName: String
    var image: Image
    
    init(id: Int, firstName: String, lastName: String, numbers: [Number], imageName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.numbers = numbers
        self.imageName = imageName
        self.image = Image(imageName)
    }

}
