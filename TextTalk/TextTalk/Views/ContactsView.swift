//
//  ContactsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI
import Contacts

struct ContactsView: View {
    var body: some View {
        FetchContacts()
    }
}


struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
