//
//  ContactListCell.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct ContactListCell: View {
    
    var data: ContactDatable
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.underLine)
                .shadow(radius: 2)

            HStack {
                VStack(alignment: .leading) {
                    Text(data.familyName + data.givenName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                    Divider()
                        .foregroundColor(Color.underLine)
                        .padding(.zero)
                    ForEach(data.phoneNumber, id: \.self) { number in
                        Text(number)
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color.darkBg)
    }
}

struct ContactListCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactListCell(data: ContactMockupData).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(height:20)
    }
}
