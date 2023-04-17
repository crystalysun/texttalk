//
//  SignInView.swift
//  TextTalk
//
//  Created by Crystal Sun on 4/15/23.
//

import SwiftUI

struct SignInView: View {
    @State var input: String = ""
    
    var body: some View {
        VStack {
            Text("Sign in with SMS Verification")
                .font(.title)
                .padding()
            
            Text("Enter your phone number below and you will be sent a verification code.")
                .padding()
            
            TextField("e.g. 6505551234", text: $input)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onSubmit {
                    if tryAuth(phoneNumber: input) {
                        print("YES")
                    }
                    else {
                        print("NO")
                    }
                }
                .frame(width: 200, height: 25, alignment: .center)
                .border(.black)
                .padding()
        }
    }
    
    func tryAuth(phoneNumber: String) -> Bool {
        if phoneNumber != "" {
            let number = "+1\(phoneNumber)"
            AuthManager.shared.startAuth(phoneNumber: number) { success in
                guard success else { return }
            }
            return true
        }
        return false
    }
    
}



struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct SignInView2: View {
    @State var input: String = ""
    
    var body: some View {
        VStack {
            Text("Verify Phone Number")
                .font(.title)
                .padding()
            
            Text("Enter the 6 digit verification code sent to the phone number you entered")
                .padding()
            
            TextField("e.g. 111111", text: $input)
                .onSubmit {
                    print("HELLO2")
                }
                .frame(width: 200, height: 25, alignment: .center)
                .border(.black)
                .padding()
        }
    }
}
