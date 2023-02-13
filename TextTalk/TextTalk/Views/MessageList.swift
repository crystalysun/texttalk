//
//  MessageList.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import SwiftUI

var messages: [Message] = [Message(id: 0, content: "I want to die"), Message(id: 1, content: "noooo commit a murder instead")]//load("sampleMessages.json")

struct MessageList: View {

    var body: some View {
        List(messages) { message in
            MessageBubble(message: message)
        }
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        MessageList()
    }
}
