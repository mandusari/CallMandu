//
//  ContactDetailView.swift
//  CallMandu
//  ONLY DARK MODE

//  Created by mandu on 2023/04/17.
//
//

import SwiftUI

struct ContactDetailView: View {
    @State var useMsg: Bool = false
    @State var useCall: Bool = false
    @State var useVideo: Bool = false
    @State var useMail: Bool = true
    @State var fDeltaHeight: CGFloat = 0
    @State var data: ContactDatable
    @ScaledMetric private var fontSize: CGFloat = 20
    
    let profileAreaSize: Double = 150
    
    let centerPosition : (GeometryProxy) -> CGPoint = { proxy in
        return CGPoint(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY);
    }
    
    var body: some View {
        GeometryReader { geomentryReader in
            VStack(spacing:0) {
                GeometryReader { profileGeo in
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.green)
                                .frame(minWidth: 50, maxWidth: 100, minHeight: 50, maxHeight:100)

                                
                            Text(data.familyName + data.givenName)
                                .font(.system(size: fontSize))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            
                            Text(data.jobTitle)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .minimumScaleFactor(0.5)
                        }
                        .position(centerPosition(profileGeo))
                }
                .frame(maxWidth: profileAreaSize + fDeltaHeight, maxHeight:profileAreaSize + fDeltaHeight)

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
                .frame(maxHeight: 80)
                .padding()
                
                ScrollView {
                    LazyVStack {
                        GroupBox {
                            LazyVStack(alignment:.leading) {
                                Text("전화번호")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                                LazyVStack(alignment: .leading, spacing: 2) {
                                    ForEach(data.phoneNumber, id:\.self) { number in
                                        Text(number)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                        .background(
                            GeometryReader{ proxy in
                                Color.clear
                                    .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .named("phoneInfoLayer")).minY )
                            }
                        )
                        
                        GroupBox {
                            LazyVStack(alignment:.leading) {
                                Text("메모")
                                    .foregroundColor(.white)
                                Text("누구게?")
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        GroupBox {
                            LazyVStack {
                                onelineTextField("메시지 보내기", underLine: true)
                                onelineTextField("연락처 공유", underLine: true)
                                onelineTextField("즐겨찾기에 추가", underLine: true)
                            }
                        }
                        
                        GroupBox {
                            onelineTextField("긴급 연락처에 추가")
                        }
                        
                        GroupBox {
                            onelineTextField("이 발신자 차단", color: .red)
                        }
                        
                        GroupBox {
                            onelineTextField("목록에 추가")
                        }
                    }
                }
                .frame(minHeight:100, maxHeight: geomentryReader.size.height)
                .coordinateSpace(name: "phoneInfoLayer")
                .onPreferenceChange(OffsetPreferenceKey.self) { value in
                    if(value > -80 && value < 0) {
                        fDeltaHeight = value
                        debugPrint(fDeltaHeight)
                    }
                }
            }
        }
    }
    
    private struct OffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }
    
    func onelineTextField(_ title: String, underLine: Bool = false, color:Color = .blue) -> some View {
        return Button {
            debugPrint(title)
        } label: {
            LazyVStack(alignment:.leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(color)
                if underLine {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.underLine)
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
