//
//  ContentView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/6/23.
//

import SwiftUI

var phraseGlobal = Phrases()
var idNum = 19
var voiceName: String = "Samantha"
var selectedLocale: String = "en-US"

struct ContentView: View {
    @State private var selection: Tab = .phone
    @State var unLocked = false
    
    public init() {
        self.selection = selection
    }

    enum Tab {
        case contacts
        case phone
        case activeCall
        case settings
    }

    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        
        if currentPage < totalPages
        {
            Walkthrough()
        }

        else if !unLocked{
            LockScreen(unLocked: $unLocked)
        }
        else{
            TabView(selection: $selection) {
                
                ContactsView()
                    .tabItem {
                        Label("Contacts", systemImage: "person.circle.fill")
                    }
                    .tag(Tab.contacts)
                
                PhoneView()
                    .tabItem {
                        Label("Phone", systemImage: "phone")
                    }
                    .tag(Tab.phone)
                
                ActiveCallView()
                    .tabItem {
                        Label("Active Call", systemImage: "teletype")
                    }
                    .tag(Tab.activeCall)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .tag(Tab.settings)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}


struct Walkthrough: View {
    
    @AppStorage("currentPage") var currentPage = 1
    var body: some View{
        
        ZStack{
            
            // Changing Between Views....
            
            if currentPage == 1{
                ScreenView(image: "preview0")
                    .transition(.scale)
            }
            else if currentPage == 2{
            
                ScreenView(image: "preview1")
                    .transition(.scale)
            }
            
            else if currentPage == 3{
                
                ScreenView(image: "preview2")
                    .transition(.scale)
            }
            else if currentPage == 4{
                ScreenView(image: "preview3")
                    .transition(.scale)
            }
            else if currentPage == 5{
            
                ScreenView(image: "preview4")
                    .transition(.scale)
            }
            
            else if currentPage == 6{
                
                ScreenView(image: "preview5")
                    .transition(.scale)
            }
            else if currentPage == 7{
                ScreenView(image: "preview6")
                    .transition(.scale)
            }
            else if currentPage == 8{
            
                ScreenView(image: "preview7")
                    .transition(.scale)
            }
            
            else if currentPage == 9{
                
                ScreenView(image: "preview8")
                    .transition(.scale)
            }
            else if currentPage == 10{
                ScreenView(image: "preview9")
                    .transition(.scale)
            }
            else if currentPage == 11{
            
                ScreenView(image: "preview10")
                    .transition(.scale)
            }
            
            else if currentPage == 12{
                
                ScreenView(image: "preview11")
                    .transition(.scale)
            }
            else if currentPage == 13{
                ScreenView(image: "preview12")
                    .transition(.scale)
            }
            else if currentPage == 14{
            
                ScreenView(image: "preview13")
                    .transition(.scale)
            }
            
        }
//        .overlay(
//
//            // Button...
//            Button(action: {
//                // changing views...
//                withAnimation(.easeInOut){
//
//                    // checking....
//                    if currentPage <= totalPages{
//                        currentPage += 1
//                    }
//                }
//            }, label: {
//
//
//                Image(systemName: "chevron.right")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(.black)
//                    .frame(width: 60, height: 60)
//                    .background(Color.white)
//                    .clipShape(Circle())
                // Circlular Slider...
//                    .overlay(
//
//                        ZStack{
//
//                            Circle()
//                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
//
//
//                            Circle()
//                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
//                                .stroke(Color.white,lineWidth: 4)
//                                .rotationEffect(.init(degrees: -90))
//                        }
//                        .padding(-15)
//                    )
//            })
//            .padding(.bottom,20)
//
//            .alignment: .bottom
//        )
    }
}

struct ScreenView: View {
    
    var image: String
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                
                // Back Button...
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage -= 1
                    }
                }, label: {
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(10)
                })
                
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 15
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
                
                Spacer()
                
                //next button
                Button(action: {
                    withAnimation(.easeInOut) {
                        currentPage += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(10)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)

            
            
            
            // Minimum Spacing When Phone is reducing...
            
            Spacer(minLength: 120)
        }
    }
}

var totalPages = 15
