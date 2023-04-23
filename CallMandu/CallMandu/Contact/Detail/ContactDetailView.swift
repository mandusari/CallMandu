//
//  ContactDetailView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/17.
//

import SwiftUI

struct ContactDetailView: View {
    @State var useMsg: Bool = false
    @State var useCall: Bool = false
    @State var useVideo: Bool = false
    @State var useMail: Bool = true
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width:100, height:100)
                    .foregroundColor(.green)
                Text("저장된 이름")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Text("직장명")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                
                LazyHStack(spacing:10) {
                    Button {
                        print("메시지")
                    } label: {
                        vStack(icon: "message.fill", title: "메시지")
                    }
                    .frame(width: 80, height: 80)
                    .background(.gray)
                    .disabled(useMsg)
                    .cornerRadius(5)
                    
                    Button {
                        print("휴대전화")
                    } label: {
                        vStack(icon: "phone.fill", title: "휴대전화")
                    }
                    .frame(width: 80, height: 80)
                    .background(.gray)
                    .disabled(useCall)
                    .cornerRadius(5)
                    
                    Button {
                        print("비디오")
                    } label: {
                        vStack(icon: "video.fill", title: "비디오")
                    }
                    .frame(width: 80, height: 80)
                    .background(.gray)
                    .disabled(useVideo)
                    .cornerRadius(5)
                    
                    Button {
                        print("Mail")
                    } label: {
                        vStack(icon: "envelope.fill", title: "Mail")
                    }
                    .frame(width: 80, height: 80)
                    .background(.gray)
                    .disabled(useMail)
                    .cornerRadius(5)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                LazyVStack(alignment:.leading) {
                    Text("휴대전화")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 1, trailing: 0))
                    Text("010-3327-0000")
                        .foregroundColor(.blue)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
                .cornerRadius(5)
                .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 0))
                
                LazyVStack(alignment:.leading) {
                    Text("집전화")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 1, trailing: 0))
                    Text("031-569-9431")
                        .foregroundColor(.blue)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
                .cornerRadius(5)
                .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 0))
                
                
                LazyVStack(alignment:.leading) {
                    Text("메모")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 1, trailing: 0))
                    Text("누구게?")
                        .foregroundColor(.blue)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
                .cornerRadius(5)
                .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 0))
                
                
                LazyVStack {
                    onelineTextField("메시지 보내기", underLine: true)
                    Spacer()
                    onelineTextField("연락처 공유", underLine: true)
                    Spacer()
                    onelineTextField("즐겨찾기에 추가", underLine: true)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(.gray)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                
                onelineTextField("긴급 연락처에 추가")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(.gray)
                    .cornerRadius(5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                
                onelineTextField("이 발신자 차단", color: .red)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(.gray)
                    .cornerRadius(5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                
                
                // 이거 대체 왜 에러나는거임..?
//                onelineTextField("목록에 추가")
//                    .frame(height: 50)
//                    .frame(maxWidth: .infinity,alignment: .leading)
//                    .background(.gray)
//                    .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .background(.black)
        }
    }
    
    func onelineTextField(_ title: String, underLine: Bool = false, color:Color = .blue) -> some View {
        return Button {
                debugPrint(title)
            } label: {
                VStack(alignment:.leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 18))
                        .foregroundColor(color)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    if underLine {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    }
                }
            }
    }
    
    func vStack(icon: String = "", title: String = "") -> some View {
        return LazyVStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 10, maxWidth: 30)
            Text(title)
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))

    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
