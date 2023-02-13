//
//  ActiveCallView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI


struct ActiveCallView: View {
    @State private var callActive: Bool = true
    
    var body: some View {
        VStack {
            Text("Active Call Page")
                .font(.title)
            if callActive {
                MessageList()
            }
            else {
                Text("Call not active. No messages to display.")
            }
            CallInput()
        }
    }
}

struct ActiveCallView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveCallView()
    }
}
