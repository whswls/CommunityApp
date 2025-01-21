//
//  SignUpView.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State var id: String = ""
    @State var password: String = ""
    @State var rePassword: String = ""
    @State var nickname: String = ""
    @State var showPassword: Bool = false
    @State var showRePassword: Bool = false
    @State var selectedDate: Date = Date()
    
    // 날짜 범위 지정
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -110, to: selectedDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: selectedDate)!
        
        return min...max
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("회원 가입")
                .font(.system(size: 27, weight: .bold))
                .padding()
            Spacer()
            Section {
                Text("아이디")
                TextField("", text: $id)
                    .padding(.leading, 13)
                    .frame(width: 270, height: 40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.mint, lineWidth: 1)
                    }
            }
            .frame(width: 270, height: 35, alignment: .leading)
            
            Section {
                Text("비밀번호")
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
            
            Section {
                Text("비밀번호 재확인")
                HStack {
                    Section {
                        if showPassword {
                            TextField("", text: $rePassword)
                        } else {
                            SecureField("", text: $rePassword)
                        }
                    }
                    .frame(width: 210, height: 40)
                    Button(action: {
                        self.showRePassword.toggle()
                    }, label: {
                        Image(systemName: showRePassword ? "eye" : "eye.slash")
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
            
            Section {
                Text("닉네임")
                TextField("", text: $nickname)
                    .padding(.leading, 13)
                    .frame(width: 270, height: 40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.mint, lineWidth: 1)
                    }
            }
            .frame(width: 270, height: 35, alignment: .leading)
            
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
                
            }, label: {
                Text("회원 가입")
            })
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 270, height: 40)
            .background(Color.mint.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            Spacer()
        }
    }
}

#Preview {
    SignUpView()
}
