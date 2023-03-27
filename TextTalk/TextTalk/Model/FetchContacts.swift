//
//  FetchContacts.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI
import Contacts

var contacts: [Contact] = []

func setNoContact() {
    var numbers1: Number = Number(type: "Mobile", number: "111-111-111")
    numbers1.type = "Mobile"
    numbers1.number = "111-111-1111"

    let contact1 = Contact(id: 0, firstName: "No contacts to display", lastName: "", numbers: [numbers1])
    contacts.append(contact1)
    print(contacts[0].firstName)
}

func setContacts(tempContacts: [CNContact]) {
    var idNum = 0
    for contact in tempContacts {
        var tempNum: Number
        var tempNumArray: [Number] = []

        for number in contact.phoneNumbers {

            switch number.label {
                case CNLabelPhoneNumberMobile:
                    tempNum = Number(type: "Mobile", number: number.value.stringValue)
                case CNLabelPhoneNumberMain:
                    tempNum = Number(type: "Main", number: number.value.stringValue)
                default:
                    tempNum = Number(type: "Other", number: number.value.stringValue)
            }
            tempNumArray.append(tempNum)

        }
        
        let tempContact: Contact = Contact(id: idNum, firstName: contact.givenName, lastName: contact.familyName, numbers: tempNumArray)
        
        if contact.imageDataAvailable {
            // there is an image for this contact
            guard let image = UIImage(data: contact.imageData!) else { return }
            tempContact.setImage(imageData: Image(uiImage: image))
        }
        
        contacts.append(tempContact)
        idNum += 1
    }
}

private struct SheetContents: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Text("No contacts to display. To import contacts, go to Settings and allow TextTalk to access Contacts.")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct FetchContacts: View {
    @State private var isSheetPresented: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .hidden()
                .onAppear {
                    Task.init {
                        var tempContacts: [CNContact] = []
                        do {
                            tempContacts = try await fetchAllContacts()
                            errorMessage = "Contacts retrieved"
                            setContacts(tempContacts: tempContacts)
                        }
                        catch {
                            errorMessage = "No contacts to display."
                        }
                        
                    }
                }
            NavigationView {
                List(contacts.sorted(by: { $0 <
                    $1 })) { contact in
                    NavigationLink {
                        ContactDetails(contact: contact)
                    } label: {
                        ContactRow(contact: contact)
                    }
                }
                .navigationTitle("Contacts")
            }
            Button("Get Contacts") {
                isSheetPresented = true
            }
            .hidden()
            .sheet(isPresented: $isSheetPresented) {
                SheetContents()
            }
        }
    }

    
    func fetchAllContacts() async throws -> [CNContact] {
        // Run in the background async
        
        // Get access to the Contacts store
        let store = CNContactStore()
        
        // Specify which data keys to fetch
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,
                    CNContactPhoneNumbersKey, CNContactImageDataKey,
                    CNContactImageDataAvailableKey] as [CNKeyDescriptor]
        
        // Create fetch request
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

        var tempCon: [CNContact] = []
        
        // Call method to fetch all contacts
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                
                tempCon.append(contact)
            })

            isSheetPresented = false
        }
        catch {
            // Handle error
            isSheetPresented = true
            setNoContact()
        }
        return tempCon
    }
    
}

struct FetchContacts_Previews: PreviewProvider {
    static var previews: some View {
        FetchContacts()
    }
}
