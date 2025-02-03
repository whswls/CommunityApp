//
//  SignUpView.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    @State private var nickname: String = ""
    @State private var showPassword: Bool = false
    @State private var showRePassword: Bool = false
    @State private var selectedDate: Date = Date()
    @State private var isSignedUp: Bool = false
    @State private var validPassword: Bool = false
    @State private var validate: Bool = false
    
    @State var members: [Member] = []
    let supabase = Supabase.shared.client
    
    // 날짜 범위 지정
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -110, to: selectedDate)!
        let max = Calendar.current.date(byAdding: .year, value: -1, to: selectedDate)!
        
        return min...max
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("회원 가입")
                    .font(.system(size: 27, weight: .bold))
                    .padding()
                Spacer()
                InputFieldView(title: "아이디", text: $id)
                PasswordInputFieldView(title: "비밀번호", password: $password, showPassword: $showPassword)
                    .onChange(of: password) { validatePassword() }
                PasswordInputFieldView(title: "비밀번호 재확인", password: $rePassword, showPassword: $showRePassword)
                    .onChange(of: rePassword) { validatePassword() }
                InputFieldView(title: "닉네임", text: $nickname)
                
                Section {
                    Text("생년월일")
                    DatePicker("",
                               selection: $selectedDate,
                               in: dateRange,
                               displayedComponents: [.date]
                    )
                    .frame(width: 95)
                    .environment(\.locale, .init(identifier: "ko_KR"))
                }
                .frame(width: 270, height: 35, alignment: .leading)
                
                Spacer()
                
                Button (action: {
                    Task{
                        await addMember()
                        isSignedUp = true
                    }
                }, label: {
                    Text("회원 가입")
                })
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 270, height: 40)
                .background(!isValid() ? Color.mint.opacity(0.4) : Color.mint.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .disabled(!validPassword)
                Spacer()
            }
            .ignoresSafeArea(.keyboard) // 키보드가 화면을 밀어내지 않도록 설정
            .autocorrectionDisabled(true) // 자동완성 비활성화
            .textInputAutocapitalization(.never) // 대문자 자동 변환 방지
        }
        .navigationDestination(isPresented: $isSignedUp) {
            ContentView()
        }
    }
    
    // 회원 가입
    private func addMember() async {
        let member = Member(id: id, nickname: nickname, password: password, date: selectedDate)
        do {
            try await supabase
                .from("member")
                .insert(member)
                .execute()
            print("회원 가입 성공!")
        } catch {
            print("회원 가입 실패: \(error.localizedDescription)")
        }
    }
    
    // 비밀번호 유효성 검사
    private func validatePassword() {
        if password != rePassword {
            validPassword = false
        } else {
            validPassword = true
        }
    }
    
    // 비밀번호 일치하는지, 필수 필드가 채워져있는지 검사
    private func isValid() -> Bool {
        return validPassword && !id.isEmpty && !nickname.isEmpty
    }
}

#Preview {
    SignUpView()
}

struct InputFieldView: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        Section {
            HStack {
                Text(title)
                Text("*")
                    .font(.system(size: 24))
                    .foregroundStyle(.red)
                    .offset(x: -7)
            }
            TextField("", text: $text)
                .padding(.leading, 13)
                .frame(width: 270, height: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(Color.mint, lineWidth: 1)
                }
        }
        .frame(width: 270, height: 35, alignment: .leading)
    }
}

struct PasswordInputFieldView: View {
    let title: String
    @Binding var password: String
    @Binding var showPassword: Bool
    
    var body: some View {
        Section {
            HStack {
                Text(title)
                Text("*")
                    .font(.system(size: 24))
                    .foregroundStyle(.red)
                    .offset(x: -7)
            }
            HStack {
                Section {
                    if showPassword {
                        TextField("", text: $password)
                    } else {
                        SecureField("", text: $password)
                    }
                }
                .frame(width: 210, height: 40)
                
                
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .padding(.trailing, 8)
                        .foregroundStyle(.gray)
                })
            }
            .frame(width: 270, height: 40)
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Color.mint, lineWidth: 1)
            }
        }
        .frame(width: 275, height: 40, alignment: .leading)
    }
}
