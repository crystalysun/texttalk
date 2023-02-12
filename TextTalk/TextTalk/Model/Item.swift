//
//  Item.swift
//  TextTalk
//
//  Created by Marie Phillips on 2/10/23.
//

import Foundation


struct Item: Codable {
    let value: String
}

extension Item {
    static func items() -> [Item] {
        guard let data = UserDefaults.standard.data(forKey: Config.UserDefaults.itemsKey) else {
            return [Item]()
        }
        guard let items = try? JSONDecoder().decode([Item].self, from: data) else {
            fatalError("Unable to read items from user defaults")
        }

        return items
    }

    static func save(_ items: [Item]) {
        guard let data =  try? JSONEncoder().encode(items) else {
            fatalError("Unable to save items to user defaults")
        }

        UserDefaults.standard.set(data, forKey: Config.UserDefaults.itemsKey)
    }
}
