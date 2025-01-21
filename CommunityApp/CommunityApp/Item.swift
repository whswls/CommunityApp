//
//  Item.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
