//
//  ContactDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI
import WAL

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
                HStack {
                    Text("\(number.type): \(number.number)")
                    Button("Tap for call") {
                        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                            print("initiating call")
                            CallManager.shared.initiate(call: Call(handle: "\(number.number)", partnerId: "\(contact.firstName)"))
                            
                        })
                    }
                    Button("Recieve Call") {
                        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                            print("receiving call")
                            CallManager.shared.reportIncomingCall(Call(handle: "\(number.number)", partnerId: "\(contact.firstName)"))
                        })
                    }
                }
            }
        }
    }
}

struct ContactDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetails(contact: contacts[1])
    }
}