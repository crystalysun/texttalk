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
    let rows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["*", "0", "#"]
    ]
    
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
                VStack {
                    Spacer()
                    Text(inputNumber)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    VStack(spacing: 0) {
                        ForEach(rows, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { digit in
                                    Button(action: {
                                        inputNumber += digit
                                    }, label: {
                                        Text(digit)
                                            .font(.title2)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color.gray, lineWidth: 0.5)
                                            )
                                    })
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .frame(maxHeight: 200)
                    HStack {
                        Button(action: {
                            if inputNumber.count > 0 {
                                inputNumber.removeLast()
                            }
                        }, label: {
                            Image(systemName: "delete.left")
                                .foregroundColor(.red)
                        })
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        
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

                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    }
                }
            }
        }
        .padding()
    }
}
