//
//  PhoneView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI



struct PhoneView: View {
    @State private var inputNumber = ""
    var body: some View {
        if activeCall {
            Text("Phone UI")
            Button("End Call") {
                // endCall()
            }
        }
        else {
            TextField("Some Number", text: $inputNumber)
                  .keyboardType(.numberPad)
            
        }
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView()
    }
}
