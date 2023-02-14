//
//  MessageBubble.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/10/23.
//

import SwiftUI

struct MessageBubble: View {
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
    }
}

//struct MessageBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MessageBubble(message: messages[0])
//            MessageBubble(message: messages[1])
//        }
//        .previewLayout(.fixed(width: 300, height: 120))
//    }
//}
