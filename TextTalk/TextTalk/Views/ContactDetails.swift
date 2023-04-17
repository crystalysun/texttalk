//
//  ContactDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/11/23.
//

import SwiftUI
import WAL
import UIKit
import WebRTC
import SIPKeyboardManager

struct ContactDetails: View {
    var contact: Contact
    
    var body: some View {
        VStack {
            contact.image
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.title)
            ForEach(contact.numbers, id:\.self) {
                number in
                PhoneNumber(contact: contact, number: number)
            }
        }
    }
}

struct ContactDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetails(contact: contacts[1])
    }
}

struct PhoneNumber: View {
    var contact: Contact
    var number: Number
    var body: some View {
        Button("\(number.type): \(number.number)") {
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                print("initiating call")
                CallManager.shared.initiate(call: Call(partnerID: "\(contact.firstName)",
                    handle: "\(number.number)", callMembers: [""],
                    lengthInMinutes: 0,
                    theme: Theme.bubblegum))
            })
        }
        .padding()
        .buttonStyle(.borderedProminent)
    }
}
