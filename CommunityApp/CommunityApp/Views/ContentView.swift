//
//  ContentView.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            Spacer()
            Text("안녕하세요!")
                .font(.system(size: 24))
                .fontWeight(.bold)
            Spacer()
            Spacer()
            
            // 입력창
            Section {
                TextField("ID", text: $id)
                    .frame(width: 260, height: 40)
                // 첫 글자 대문자로 표출 방지
                    .textInputAutocapitalization(.never)
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: {
                        self.showPassword.toggle()
                    }, label: {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundStyle(.gray)
                    })
                }
                .frame(width: 260, height: 40)
            }
            .frame(width: 290, height: 40)
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Color.mint, lineWidth: 1)
            }
            // 로그인 버튼
            Button(action: {
                
            }, label: {
                Text("로그인")
            })
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 290, height: 40)
            .background(Color.mint.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Button(action: {}, label: {
                Text("아직 회원이 아니신가요?")
            })
            .font(.system(size: 17, weight: .bold))
            .foregroundStyle(.mint)
            .padding(.trailing, 120)
            .frame(width: 290, height: 43)
            
            Divider()
                .frame(width: 290)
            Spacer()
            
            Text("간편 로그인 하기")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.gray)
            
            HStack {
                Image("NaverIcon")
                    .resizable()
                    .frame(width: 50, height: 50)
                Image("GoogleIcon")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
