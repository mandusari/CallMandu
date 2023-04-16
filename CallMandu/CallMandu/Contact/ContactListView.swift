//
//  ContactListView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct ContactListView: View {
    
    @State private var searchText = ""
    @State private var datas: [String] = [
    "테스트 계정",
    "테스트 계정",
    "테스트 계정",
    "테스트 계정",
    "테스트 계정",
    "테스트 계정",
    "테스트 계정",
    "테스트 계정",
    "테스트 계정","테스트 계정","테스트 계정","테스트 계정","테스트 계정",]

    var body: some View {
        VStack{
            SearchBar(text:$searchText, placeholder: "검색")
            HStack {
                Image(systemName: "rosette")
                VStack(alignment: .leading) {
                    Text("김용태")
                        .font(.system(size: 20, weight: .bold))
                    Text("내 카드")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 15))
            
            List(datas, id:\.self) { data in
                ContactListCell(data: data)
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
