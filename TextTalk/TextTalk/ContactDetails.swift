//
//  ContactDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI

struct ContactDetails: View {
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
    }
}

struct ContactDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetails(contact: contacts[1])
    }
}
