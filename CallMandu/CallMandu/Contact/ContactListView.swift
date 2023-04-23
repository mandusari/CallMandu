//
//  ContactListView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct ContactListView: View {
    
    @State private var searchText = ""
    @StateObject var vm = ContactViewModel()

    var body: some View {
        VStack {
            SearchBar(text:$searchText, placeholder: "검색")
            HStack(alignment: .top) {
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
            
            if searchText.isEmpty == false {
                let filteredData = vm.data.filter { data in
                    let fullName = data.givenName + data.familyName
                    let text = searchText.trimmingCharacters(in: .whitespaces)
                    return (fullName.contains(text) || chosungCheck(word: fullName).contains(text))
                }
                
                create(listData: filteredData)
            } else {
                create(listData: vm.data)
            }
        }
        .onAppear(perform: {
            vm.fetchContract()
        })
    }
    
    private func create(listData: [ContactDatable]) -> some View {
        return List(listData, id:\.self) { data in
            ContactListCell(data: data)
                .listRowSeparator(.hidden)
                .background(
                    NavigationLink(destination: ContactDetailView(data: data), label: {EmptyView()})
                        .buttonStyle(.plain)
                )
        }
        .listStyle(.plain)
        .gesture(DragGesture().onChanged({ _ in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }))
    }
    
    let hangeul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    func chosungCheck(word: String) -> String {
        var result = ""
        
        for char in word {
            let octal = char.unicodeScalars[char.unicodeScalars.startIndex].value
            if 44032...55203 ~= octal {
                let index = (octal - 0xac00) / 28 / 21
                result = result + hangeul[Int(index)]
            }
        }
        return result
    }

    /// 검색어에 한글 초성 말고, 전화번호나 이메일 검색도 추가하고 싶을경우 쓸지도..
    func isChosung(word: String) -> Bool {
        var isChosung = false
        for char in word {
            if 0 < hangeul.filter({ $0.contains(char)}).count {
                isChosung = true
            } else {
                isChosung = false
                break
            }
        }
        return isChosung
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
