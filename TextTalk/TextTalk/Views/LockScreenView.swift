//
//  LockScreenView.swift
//  TextTalk
//
//  Created by Crystal Sun on 4/15/23.
//

import SwiftUI

struct LockScreenView : View {
    
    @State var password = ""
    @Binding var unLocked : Bool
    @Binding var passwordSet : Bool
    @Binding var key : String
    @State private var createPass: Bool = false
    @State private var helpSheet: Bool = false
    @State var wrongPass = false
    let height = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Spacer(minLength: 0)
                    .onAppear() {
                        createPass = !passwordSet
                    }
                
                Button("") {
                    
                }
                    .sheet(isPresented: $createPass) {
                        CreatePassSheet(passwordSet: $passwordSet, key: $key, createPass: $createPass, wrongPass: $wrongPass)
                    }
                
                Button("") {
                    
                }
                    .sheet(isPresented: $helpSheet) {
                        HelpSheet()
                    }
                
                Menu(content: {
                    Button(action: {
                            createPass = true
                            passwordSet = false
                        }) {
                            HStack {
                                Text("Reset Password")
                                Image(systemName: "key.fill")
                            }
                        }
                    
                    Button(action: {
                            helpSheet = true
                        }) {
                            HStack {
                                Text("Help")
                                Image(systemName: "info.circle.fill")
                            }
                        }
                    
                }) {
                    
                    Image(systemName: "questionmark.app")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                }
            }
            .padding(.leading)
            
            Image("logo")
                .resizable()
                .frame(width: 95, height: 95)
                .padding(.top,20)
            
            Text("Enter Passcode")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.top,20)
            
            Text(password)
                .font(.system(size: 20, weight: .heavy, design: .serif))
                .padding(.top, 20)
                .padding(.bottom, 20)
    
            // for smaller size iphones...
            .padding(.top,height < 750 ? 20 : 30)
            
            // KeyPad....
            
            Spacer(minLength: 0)
            
            Text(wrongPass ? "Incorrect Pin" : "")
                .foregroundColor(.red)
                .fontWeight(.heavy)
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: height < 750 ? 5 : 15){
                
                // Password Button ....
                
                ForEach(1...9,id: \.self){value in
                    
                    PasswordButton(value: "\(value)",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPass)
                }
                
                PasswordButton(value: "delete.fill",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPass)
                
                PasswordButton(value: "0", password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPass)
            }
            .padding(.bottom)

        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}



struct PasswordButton : View {
    
    var value : String
    @Binding var password : String
    @Binding var key : String
    @Binding var unlocked : Bool
    @Binding var wrongPass : Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            VStack{
                if value.count > 1 {
                    // Image...
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                else {
                    Text(value)
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding()

        })
        .buttonStyle(PasswordButtonStyle())
    }
    
    func setPassword() {
        // checking if backspace pressed...
        withAnimation {
            if value.count > 1 {
                if password.count != 0 {
                    password.removeLast()
                }
            }
            else{
                if password.count != 4{
                    password.append(value)
                    
                    // Delay Animation...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation{
                            if password.count == 4 {
                                if password == key{
                                    unlocked = true
                                }
                                else{
                                    wrongPass = true
                                    password.removeAll()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct LockScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LockScreenView()
//    }
//}

struct CreatePasswordButton : View {
    
    var value : String
    @Binding var password : String
    @Binding var setPass : Bool
    @Binding var key : String
    @Binding var createPass : Bool
    @Binding var wrongPass : Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            VStack{
                if value.count > 1 {
                    // Image...
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                else {
                    Text(value)
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding()

        })
        .buttonStyle(PasswordButtonStyle())
    }
    
    func setPassword() {
        // checking if backspace pressed...
        withAnimation {
            if value.count > 1 {
                if password.count != 0 {
                    password.removeLast()
                }
            }
            else{
                if password.count != 4{
                    password.append(value)
                    
                    // Delay Animation...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation{
                            if password.count == 4 {
                                key = password
                                setPass = true
                                createPass = false
                                wrongPass = false
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PasswordButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .fill(
                    configuration.isPressed ? Color.gray : Color.white
                )
            )
            .overlay {

                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .stroke(.gray, lineWidth: 2)
            }
    }
}

struct HelpSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let height = UIScreen.main.bounds.width
    
    var body: some View {
        Text("Password Help")
            .font(.title)
            .padding()
        
        Text("Passcode Login Page: Click on the question mark at the top right hand corner, then select the \"Reset Password\" option")
            .padding()
        
        Text("Settings: Go to the \"Password Settings\" page, then click on the \"Reset Password\" button")
            .padding()
        
        Button("Dismiss") {
            dismiss()
        }
            .padding()
            .buttonStyle(.borderedProminent)
    }
}

struct CreatePassSheet: View {
    @State var password = ""
    @Binding var passwordSet : Bool
    @Binding var key : String
    @Binding var createPass : Bool
    @Binding var wrongPass : Bool
    @Environment(\.dismiss) private var dismiss
    
    let height = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            HStack{
                
                Spacer(minLength: 0)
                
                Button("Dismiss") {
                    dismiss()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding(.top)
            
            Image("logo")
                .resizable()
                .frame(width: 95, height: 95)
                .padding(.top,20)
            
            Text("Create a Passcode")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.top,20)
            
            Text(password)
                .font(.system(size: 20, weight: .heavy, design: .serif))
                .padding(.top, 20)
                .padding(.bottom, 20)
    
            // for smaller size iphones...
            .padding(.top,height < 750 ? 20 : 30)
            
            // KeyPad....
            
            Spacer(minLength: 0)
            
            Text("")
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: height < 750 ? 5 : 15){
                
                // Password Button ....
                
                ForEach(1...9,id: \.self){value in
                    
                    CreatePasswordButton(value: "\(value)",password: $password, setPass: $passwordSet, key: $key, createPass: $createPass, wrongPass: $wrongPass)
                }
                
                CreatePasswordButton(value: "0", password: $password, setPass: $passwordSet, key: $key, createPass: $createPass, wrongPass: $wrongPass)
                
                CreatePasswordButton(value: "delete.fill",password: $password, setPass: $passwordSet, key: $key, createPass: $createPass, wrongPass: $wrongPass)
                
            }
            .padding(.top, 30)
            .padding(.bottom)

        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
