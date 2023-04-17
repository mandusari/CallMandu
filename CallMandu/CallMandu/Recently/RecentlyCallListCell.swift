//
//  RecentlyCallListCell.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct RecentlyCallListCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var isSent = false
    @State var isIncoming = false
    var data: RecentlyCallDatable
    
    var body: some View {
        HStack(alignment: .center){
            if isSent {
                Image(systemName: "phone.arrow.up.right.fill")
                    .frame(width: 35, height: 35)
            }
            else if isIncoming {
                Image(systemName: "phone.arrow.down.left.fill")
                    .frame(width: 35, height: 35)
            }
            else {
                ZStack {
                    Color.white
                }
                .frame(width: 35, height: 35)
            }
            
            VStack(alignment: .leading) {
                Text(data.phoneNumber)
                    .font(.system(size: 20,weight: .bold))
                Text(data.phoneType)
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            HStack {
                Text("금요일")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)

                Button {
                    debugPrint("GoTo Info")
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

struct MainListCell_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyCallListCell(data: RecentlyCallDatable(type: .incoming, name: "", phoneType: "", phoneNumber: "")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(width: UIScreen.main.bounds.width, height: 35)
    }
}
