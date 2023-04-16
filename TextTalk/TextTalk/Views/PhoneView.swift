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
        NavigationView{
            Home()
        }
    }
}



struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .cornerRadius(20)
            .border(Color.blue, width: 2)
            .shadow(color: .gray, radius: 10)

    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView()
    }
}

struct Home : View {
    @State var presentUnlockedNotif = true
       
       var body: some View{
           
           ZStack{
               VStack {
                   if presentUnlockedNotif {
                       Text("App Unlocked!")
                           .font(.title2)
                           .fontWeight(.heavy)
                           .onAppear() {
                               Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                                   withAnimation(.easeInOut(duration: 2)) {
                                       self.presentUnlockedNotif.toggle()
                                   }
                               }
                           }
                   }
                   
                   DialPad()
               }
           }
           //.preferredColorScheme(unLocked ? .light : .dark)
       }
}

struct DialPad : View {
    @StateObject private var isActiveCall = CallManager.shared.isActiveCall
    @State private var inputNumber = ""
    
    var body: some View {
        VStack {
            if isActiveCall.isActive {
                Button(action: {
                    CallManager.shared.end()
                }) {
                    Image(systemName: "phone.down")
                }
            }
            else {
                let numInputTF = TextField(
                 "Enter number...",
                 text: $inputNumber,
                 onCommit: {
                     print(inputNumber)
                 })
                    .keyboardType(.phonePad)
                    .textFieldStyle(OvalTextFieldStyle())
                
                VStack(alignment: .leading) {
                    Text("Enter number...").font(.title2)
                    HStack {
                        numInputTF
                        Button(action: {
                            CallManager.shared.initiate(call: Call(
                                partnerID: "Unknown",
                                handle: inputNumber,
                                callMembers: [""],
                             lengthInMinutes: 0,
                             theme: Theme.bubblegum))
                        }) {
                            Image(systemName: "phone.arrow.up.right")
                        }
                    }
                }.padding()
                
            }
        }
    }
}
