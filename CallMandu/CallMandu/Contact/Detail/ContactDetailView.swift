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
    @State var data: ContactDatable
    
    var body: some View {
        LazyVStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width:100, height:100)
                .foregroundColor(.green)
            Text(data.familyName + data.givenName)
                .font(.system(size: 20))
                .foregroundColor(.white)
            Text(data.jobTitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            
            LazyHStack(spacing:10) {
                Button {
                    print("메시지")
                } label: {
                    vStack(icon: "message.fill", title: "메시지")
                }
                .frame(width: 80, height: 80)
                .background(Color.darkBg)
                .disabled(useMsg)
                .cornerRadius(5)
                
                Button {
                    guard let phoneNumber = data.phoneNumber.first else { return }
                    let telephone = "tel://"
                    let formattedString = telephone + phoneNumber
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    vStack(icon: "phone.fill", title: "휴대전화")
                }
                .frame(width: 80, height: 80)
                .background(Color.darkBg)
                .disabled(useCall)
                .cornerRadius(5)
                
                Button {
                    print("비디오")
                } label: {
                    vStack(icon: "video.fill", title: "비디오")
                }
                .frame(width: 80, height: 80)
                .background(Color.darkBg)
                .disabled(useVideo)
                .cornerRadius(5)
                
                Button {
                    print("Mail")
                } label: {
                    vStack(icon: "envelope.fill", title: "Mail")
                }
                .frame(width: 80, height: 80)
                .background(Color.darkBg)
                .disabled(useMail)
                .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            ScrollView {
                VStack {
                    LazyVStack(alignment:.leading) {
                        Text("전화번호")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 1, trailing: 0))
                        LazyVStack(alignment: .leading, spacing: 2) {
                            ForEach(data.phoneNumber, id:\.self) { number in
                                Text(number)
                                    .foregroundColor(.blue)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.darkBg)
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
                    .background(Color.darkBg)
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
                    .background(Color.darkBg)
                    .cornerRadius(5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    
                    onelineTextField("긴급 연락처에 추가")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(Color.darkBg)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    
                    onelineTextField("이 발신자 차단", color: .red)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(Color.darkBg)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    
                    onelineTextField("목록에 추가")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(Color.darkBg)
                        .cornerRadius(5)
                }
            }
            .frame(maxHeight: 300)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .background(.black)
            .gesture(DragGesture(coordinateSpace: .global).onChanged({ value in
                debugPrint(value)
            }))
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
                            .foregroundColor(Color.underLine)
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
        ContactDetailView(data: ContactMockupData).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
