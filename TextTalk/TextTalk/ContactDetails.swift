//
//  ContactDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI

struct ContactDetails: View {
<<<<<<< HEAD
    var contact: Contact
    
    var body: some View {
        VStack {
            contact.image
                .resizable()
                .frame(width: 100, height: 100)
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.title)
            ForEach(contact.numbers, id:\.self) {
                number in
                Text("\(number.type): \(number.number)")
            }
        }
=======
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
>>>>>>> fbb5205 (Contacts display with sample contacts, messages display with sample messages, toggle STT TTS setting)
    }
}

struct ContactDetails_Previews: PreviewProvider {
    static var previews: some View {
<<<<<<< HEAD
        ContactDetails(contact: contacts[1])
=======
        ContactDetails()
>>>>>>> fbb5205 (Contacts display with sample contacts, messages display with sample messages, toggle STT TTS setting)
    }
}
