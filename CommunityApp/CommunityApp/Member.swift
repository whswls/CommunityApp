//
//  Item.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import Foundation
import SwiftData

@Model
final class Member {
    @Attribute(.unique)
    var id: String = ""
    var password: String = ""
    @Attribute(.unique)
    var nickname: String = ""
    var selectedDate: Date = Date()
    
    init(id: String, password: String, nickname: String, selectedDate: Date) {
        self.id = id
        self.password = password
        self.nickname = nickname
        self.selectedDate = selectedDate
    }
}
