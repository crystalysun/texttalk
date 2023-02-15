//
//  ActiveCallView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI


struct ActiveCallView: View {
    var body: some View {
        VStack {
            Text("Active Call Page")
                .font(.title)
            CallInput()
        }
    }
}

struct ActiveCallView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveCallView()
    }
}
