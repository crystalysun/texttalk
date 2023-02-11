//
//  ContactsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI

struct ContactsView: View {
    var body: some View {
        NavigationView {
            List(contacts) { contact in
                NavigationLink {
                    ContactDetails(contact: contact)
                } label: {
                    ContactRow(contact: contact)
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
