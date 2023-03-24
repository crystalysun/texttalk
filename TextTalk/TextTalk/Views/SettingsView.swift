//
//  SettingsView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI

let settings: [Phrase] = [Phrase(id: 1, content: "Account"), Phrase(id: 2, content: "Saved Phrases"), Phrase(id: 3, content: "Notifications"), Phrase(id: 4, content: "Privacy"), Phrase(id: 5, content: "Help Center"), Phrase(id: 6, content: "General"), Phrase(id: 7, content: "About Us"), Phrase(id: 8, content: "Voices")]

struct SettingsView: View {
    var body: some View {
        Settings()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct Settings : View {
    
    var body : some View {
        VStack(spacing:15) {
            
            ZStack {
                
                HStack {
                    /*
                    Image("circle").resizable().frame(width: 250, height:150)
                    */
                    Spacer()
                }
            
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 45, content: {
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chevron.left").font(.title)
                        }
                        Text("Settings").font(.title)
                    }).foregroundColor(Color.black.opacity(0.5))
                    
                    Spacer()
                    
                }.padding()
                    .padding(.top,10)
                
                VStack {
                    Image("name").overlay(Text("K").foregroundColor(.black).font(.title))
                
                    Spacer()
                    
                }.padding(.top,30)
                
            }.frame(height: 175)
            
            NavigationView {
                List(settings) { setting in
                    NavigationLink {
                        SettingsDetails(pageName: setting.content)
                    } label: {
                        btnView(image: "circle", name: setting.content)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct btnView : View {
    
    var image = ""
    var name = ""
    var body : some View {
        
        Button(action: {
        })  {
            HStack(spacing:15){
                Image(image).renderingMode(.original).resizable().frame(width:40, height:40)
                
                Text(name)
                
                Spacer(minLength: 15)
                
//                Image(systemName: "chevron.right")
            }.padding()
                .foregroundColor(Color.black.opacity(0.5))
        }
    }
}
