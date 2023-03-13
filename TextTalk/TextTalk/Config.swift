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
            url: "turn:35.3.128.220:3478?transport=udp",
            username: "testuser",
            password: "testpass")
        static let config = WebRTCConnection.Config(
            signalingServerUrl: "ws://35.3.128.220",
            turnServer: turnServer,
            stunServerUrl: nil,
            formatConstraints: formatConstraints)
    }
}
