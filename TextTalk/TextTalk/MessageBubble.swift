//
//  MessageBubble.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import SwiftUI

struct MessageBubble: View {
<<<<<<< HEAD
    var message: Message
    
    var body: some View {
        VStack {
            HStack {
                message.image
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(message.content)

                Spacer()
            }
            Text(message.sender)
            Text(message.timeSent)
        }
=======
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
>>>>>>> fbb5205 (Contacts display with sample contacts, messages display with sample messages, toggle STT TTS setting)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
<<<<<<< HEAD
        Group {
            MessageBubble(message: messages[0])
            MessageBubble(message: messages[1])
        }
        .previewLayout(.fixed(width: 300, height: 120))
=======
        MessageBubble()
>>>>>>> fbb5205 (Contacts display with sample contacts, messages display with sample messages, toggle STT TTS setting)
    }
}
