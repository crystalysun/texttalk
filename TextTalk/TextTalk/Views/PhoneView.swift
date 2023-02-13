//
//  PhoneView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI



struct PhoneView: View {
    @StateObject private var isActiveCall = CallManager.shared.isActiveCall
    @State private var inputNumber = ""
    var body: some View {
        VStack {
            if isActiveCall.isActive {
                Text("Phone UI")
                Button(action: {
                    CallManager.shared.end()
                }) {
                    Text("End Current Call")
                        .background(Color.pink)
                        .cornerRadius(40)
                        .tint(Color.white)
                        .font(.title)
                        .padding()
                }
            }
            else {
                let numInputTF = TextField(
                    "Enter number...",
                    text: $inputNumber,
                    onCommit: {
                        print(inputNumber)
                    })
                    .keyboardType(.numberPad)
                
                VStack(alignment: .leading) {
                    Text("Enter number here!").font(.title2)
                    HStack {
                        numInputTF
                        Button("Done") {
                            CallManager.shared.initiate(call: Call(
                                handle: inputNumber, callMembers: [""],
                                lengthInMinutes: 0,
                                theme: Theme.bubblegum))
                        }
                    }
                    .textFieldStyle(OvalTextFieldStyle())
                }.padding()
                
            }
        }
    }
}



struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView()
    }
}
