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
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)

    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView()
    }
}

struct Home : View {
       
       var body: some View{
           
           ZStack{
               VStack {
                   Text("App Unlocked")
                       .font(.title2)
                       .fontWeight(.heavy)
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
                    .textFieldStyle(OvalTextFieldStyle())
                }.padding()
                
            }
        }
    }
}


struct LockScreen : View {
    
    @State var password = ""
    // you can change it when user clicks reset password....
    // AppStorage => UserDefaults....
    @AppStorage("lock_Password") var key = "1111"
    @Binding var unLocked : Bool
    @State var wrongPassword = false
    let height = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Label(
                        title: { Text("Help") },
                        icon: { Image(systemName: "info.circle.fill") })
                        .onTapGesture(perform: {
                            // perform actions...
                        })
                    
                    Label(
                        title: { Text("Reset Password") },
                        icon: { Image(systemName: "key.fill") })
                        .onTapGesture(perform: {
                            
                        })
                    
                }) {
                    
                    Image("menu")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 19, height: 19)
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .padding(.leading)
            
            Image("logo")
                .resizable()
                .frame(width: 95, height: 95)
                .padding(.top,20)
            
            Text("Enter Passcode")
                .font(.title2)
                .fontWeight(.heavy)
                .padding(.top,20)
    
            // for smaller size iphones...
            .padding(.top,height < 750 ? 20 : 30)
            
            // KeyPad....
            
            Spacer(minLength: 0)
            
            Text(wrongPassword ? "Incorrect Pin" : "")
                .foregroundColor(.red)
                .fontWeight(.heavy)
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: height < 750 ? 5 : 15){
                
                // Password Button ....
                
                ForEach(1...9,id: \.self){value in
                    
                    PasswordButton(value: "\(value)",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
                }
                
                PasswordButton(value: "delete.fill",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
                
                PasswordButton(value: "0", password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
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
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding()

        })
    }
    
    func setPassword(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                }
            }
            else{
                
                if password.count != 4{
                    
                    password.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation{
                            
                            if password.count == 4{
                                
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
