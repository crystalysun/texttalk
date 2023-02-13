//
//  Call.swift
//  TextTalk
//
//  Created by Marie Phillips & Claudia Gonciulea on 2/12/23.
//
/*
 https://developer.apple.com/tutorials/app-dev-training/transcribing-speech-to-text
 */

import Foundation

struct Call: Identifiable, Codable {
    let id: UUID
    let partnerId: String
    var handle: String
    var callMembers: [Callee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), handle: String, callMembers: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.partnerId = handle
        self.handle = handle
        self.callMembers = callMembers.map { Callee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

// TODO - add other person's name to be displayed
// id will likely help with on-hold stuff
extension Call {
    struct Callee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var handle: String = ""
        var callMembers: [Callee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(handle: handle, callMembers: callMembers, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
    
    mutating func update(from data: Data) {
        handle = data.handle
        callMembers = data.callMembers
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        partnerId = data.handle
        handle = data.handle
        callMembers = data.callMembers
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }
}

extension Call {
    static let sampleData: [Call] =
    [
        Call(handle: "Design", callMembers: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
        Call(handle: "App Dev", callMembers: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
        Call(handle: "Web Dev", callMembers: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
    ]
}
