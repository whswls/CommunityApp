//
//  SignUpView.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("회원 가입")
                    .font(.system(size: 27, weight: .bold))
                    .padding()
                Spacer()
                InputFieldView(title: "이메일", text: $viewModel.email)
                PasswordInputFieldView(title: "비밀번호", password: $viewModel.password, showPassword: $viewModel.showPassword)
                    .onChange(of: viewModel.password) { viewModel.validatePassword() }
                PasswordInputFieldView(title: "비밀번호 재확인", password: $viewModel.rePassword, showPassword: $viewModel.showRePassword)
                    .onChange(of: viewModel.rePassword) { viewModel.validatePassword() }
                InputFieldView(title: "닉네임", text: $viewModel.nickname)
                
                Section {
                    Text("생년월일")
                    DatePicker("",
                               selection: $viewModel.selectedDate,
                               in: viewModel.dateRange,
                               displayedComponents: [.date]
                    )
                    .frame(width: 95)
                    .environment(\.locale, .init(identifier: "ko_KR"))
                }
                .frame(width: 270, height: 35, alignment: .leading)
                
                Spacer()
                
                Button (action: {
                    Task{
                        await viewModel.addMember()
                    }
                }, label: {
                    Text("회원 가입")
                })
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 270, height: 40)
                .background(!viewModel.isValid() ? Color.mint.opacity(0.4) : Color.mint.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .disabled(!viewModel.validPassword)
                Spacer()
            }
            .ignoresSafeArea(.keyboard) // 키보드가 화면을 밀어내지 않도록 설정
            .autocorrectionDisabled(true) // 자동완성 비활성화
            .textInputAutocapitalization(.never) // 대문자 자동 변환 방지
        }
        .navigationDestination(isPresented: $viewModel.isSignedUp) {
            ContentView()
        }
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
