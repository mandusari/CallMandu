//
//  ContactListCell.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct ContactListCell: View {
    
    var data: String = ""
    
    var body: some View {
        HStack {
            Text(data)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}

struct ContactListCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactListCell().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(height:20)
    }
}
