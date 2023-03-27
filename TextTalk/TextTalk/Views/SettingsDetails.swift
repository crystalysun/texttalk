//
//  SettingsDetails.swift
//  TextTalk
//
//  Created by Crystal Sun on 3/14/23.
//

import SwiftUI

struct SettingsDetails: View {
    var pageName: String
    
    var body: some View {
        if (pageName == "Saved Phrases") {
            SavedPhrasesView()
        }
        else if(pageName == "Customize Voice") {
            VoiceSettingsView()
        }
        
        
    }
}

struct SettingsDetails_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetails(pageName: "Saved Phrases")
    }
}
