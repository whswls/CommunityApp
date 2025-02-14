//
//  Item.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import Foundation
import Supabase

struct Member: Codable, Identifiable {
    var id: String
    var nickname: String
    var password: String
    var date: Date?
    
    init(id: String, nickname: String, password: String, date: Date?) {
        self.id = id
        self.nickname = nickname
        self.password = password
        self.date = date
    }
}
