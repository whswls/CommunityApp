//
//  SignUpViewModel.swift
//  CommunityApp
//
//  Created by 존진 on 2/3/25.
//

import Foundation
//import Supabase
import Combine

class SignUpViewModel: ObservableObject {
    // 사용자 입력
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    @Published var showPassword: Bool = false
    @Published var showRePassword: Bool = false
    @Published var nickname: String = ""
    @Published var selectedDate: Date = Date()
    
    // UI 상태
    @Published var validPassword: Bool = false
    @Published var isSignedUp: Bool = false
    @Published var members: [Member] = []
    
    private let supabase = Supabase.shared.client
    
    // 날짜 범위 지정
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -110, to: selectedDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: selectedDate)!
        return min...max
    }
    
    // 비밀번호 유효성 검사
    func validatePassword() {
        if password != rePassword {
            validPassword = false
        } else {
            validPassword = true
        }
    }
    
    // 비밀번호 일치하는지, 필수 필드가 채워져있는지 검사
    func isValid() -> Bool {
        return validPassword && !id.isEmpty && !nickname.isEmpty
    }
    
    // 데이터 불러오기
    func loadData() async {
        do {
            let response = try await supabase
                .from("member")
                .select("id, nickname")
                .execute()

            // response 상태 코드 확인
            print("response status: \(response.status)")

            // JSON 데이터로 변환
            let data = response.data // response.data는 옵셔널이 아니므로, 직접 사용
            if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                // jsonData가 [[String: Any]] 형태로 변환되었을 경우 처리
                print("response JSON: \(jsonData)")

                // 데이터가 비어있는지 체크
                if jsonData.isEmpty {
                    print("데이터가 없습니다.")
                } else {
                    // 데이터를 출력하거나 처리하는 로직
                    for item in jsonData {
                        if let id = item["id"] as? Int, let nickname = item["nickname"] as? String {
                            print("ID: \(id), Nickname: \(nickname)")
                        }
                    }
                }
            } else {
                print("JSON 변환에 실패했습니다.")
            }

        } catch {
            print("데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // 회원 가입
    func addMember() async {
        let member = Member(id: id, nickname: nickname, password: password, date: selectedDate)
        do {
            try await supabase
                .from("member")
                .insert(member)
                .execute()
            isSignedUp = true
            print("회원 가입 성공!")
        } catch {
            print("회원 가입 실패: \(error.localizedDescription)")
        }
    }
    
    
}
