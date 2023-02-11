//
//  FetchContacts.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI
import Contacts

struct FetchContacts: View {
    var body: some View {
        Text("Insert Contacts Here")
            .onAppear {
                Task.init {
                    await fetchAllContacts()
                }
            }
    }
    
    func fetchAllContacts() async {
        // Run in the background async
        
        // Get access to the Contacts store
        let store = CNContactStore()
        
        // Specify which data keys to fetch
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        // Create fetch request
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        // Call method to fetch all contacts
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                
                print(contact.givenName)
                for number in contact.phoneNumbers {
                    
                    switch number.label {
                        case CNLabelPhoneNumberMobile:
                            print("- Mobile: \(number.value.stringValue)")
                        case CNLabelPhoneNumberMain:
                            print("- Main: \(number.value.stringValue)")
                        default:
                            print("- Other: \(number.value.stringValue)")
                    }
                    
                }
            })
        }
        catch {
            // Handle error
            print("No contacts to display. To import contacts, go to Settings and allow TextTalk to access Contacts.")
        }
    }
}

struct FetchContacts_Previews: PreviewProvider {
    static var previews: some View {
        FetchContacts()
    }
}
