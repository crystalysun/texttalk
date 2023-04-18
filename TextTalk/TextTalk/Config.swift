//
//  Config.swift
//  TextTalk
//
//  Created by Christian Braun on 02.09.18.
//  Copyright © 2018 KURZ Digital Solutions GmbH & Co. KG. All rights reserved.
//

import Foundation
import WAL

struct Config {
    struct UserDefaults {
        static let itemsKey = "TextTalkItems"
    }

    struct WebRTC {
        fileprivate static let formatConstraints = WebRTCConnection.FormatConstraints(
            preferredWidth: 640,
            preferredHeight: 480)
        fileprivate static let turnServer = WebRTCConnection.TurnServer(
            url: "turn:3.218.156.7:3478?transport=udp",
            username: "username1",
            password: "key1")
        static let config = WebRTCConnection.Config(
            signalingServerUrl: "https://3.218.156.7:8443",
            turnServer: turnServer,
            stunServerUrl: nil,
            formatConstraints: formatConstraints)
    }
}
