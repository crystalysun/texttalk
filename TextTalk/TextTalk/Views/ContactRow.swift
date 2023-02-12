//
//  ContactRow.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI

struct ContactRow: View {
    var contact: Contact
    
    var body: some View {
        Text("\(contact.firstName) \(contact.lastName)")
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: contacts[0])
    }
}
