//
//  Supabase.swift
//  CommunityApp
//
//  Created by 존진 on 2/2/25.
//

import Foundation
import Supabase

class Supabase {
    static let shared = Supabase()  // 싱글톤 인스턴스

    let client: SupabaseClient

    private init() {
        guard let supabaseURL = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
              let supabaseKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as? String else {
            fatalError("Supabase credentials not found")
        }

        self.client = SupabaseClient(supabaseURL: URL(string: supabaseURL)!,
                                     supabaseKey: supabaseKey)
    }
}
