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
                .foregroundColor(.white)
                .shadow(radius: 2)

            HStack {
                VStack(alignment: .leading) {
                    Text(data.familyName + data.givenName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                    Divider()
                        .padding(.zero)
                    ForEach(data.phoneNumber, id: \.self) { number in
                        Text(number)
                            .font(.system(size: 13, weight: .light))
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
    }
}

struct ContactListCell_Previews: PreviewProvider {
    static var previews: some View {
        let data = ContactDatable(familyName: "김", givenName: "용태", phoneNumber: ["010-3327-9431", "031-569-9430"])
        ContactListCell(data: data).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(height:20)
    }
}
