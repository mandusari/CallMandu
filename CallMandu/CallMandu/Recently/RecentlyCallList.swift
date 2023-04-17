//
//  RecentlyCallList.swift
//  CallMandu
//
//  Created by mandu on 2023/04/17.
//

import SwiftUI

struct RecentlyCallList: View {
    @State var phoneNumber: [RecentlyCallDatable] = []
    
    var body: some View {
            List(phoneNumber, id:\.self) { data in
                RecentlyCallListCell(data: data)
            }
            .onAppear {
                DispatchQueue.global(qos: .background).async {
                    phoneNumber = ContactFetcher().fetchPhoneNumbers()
                }
            }
    }
}

struct RecentlyCallList_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyCallList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
