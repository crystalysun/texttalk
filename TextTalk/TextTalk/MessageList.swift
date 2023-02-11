//
//  MessageList.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import SwiftUI

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
