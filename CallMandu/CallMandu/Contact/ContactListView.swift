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
                    return true
//                    return findContact(input: searchText, data: fullName)
                }
                List(filteredData, id:\.self) { data in
                    ContactListCell(data: data)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            debugPrint(data.givenName)
                        }
                }
                .listStyle(.plain)
            } else {
                List(vm.data, id:\.self) { data in
                    ContactListCell(data: data)
                        .listRowSeparator(.hidden)
                        .background(
                            NavigationLink(destination: ContactDetailView(), label: {EmptyView()})
                                .buttonStyle(.plain)
                        )
                }
                .listStyle(.plain)
            }
        }
        .onAppear(perform: {
            vm.fetchContract()
        })
    }
    
//    private func findContact(input: String, data: String) -> Bool {
//        let initialSound = makeInitialSound(input)
//        let regexPattern = ".*\(initialSound).*"
//        let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
//        let range = NSRange(location: 0, length: data.utf16.count)
//        return regex?.firstMatch(in: data, options: [], range: range) != nil
//    }
//
//    private func makeInitialSound(_ input: String) -> NSRegularExpression? {
//        let pattern = input.reduce("") { (result, char) -> String in
//            let (cho, _, _) = separateKoreanChar(char)
//            guard let cho = cho else {
//                return result + String(char)
//            }
//
//            return result + cho
//        }
//
//        return try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
//    }

//    private func separateKoreanChar(_ char: Character) -> (cho: String?, jung: String?, jong: String?) {
//        guard let scalar = char.unicodeScalars.first, scalar.isHangul else {
//            return (nil, nil, nil)
//        }
//
//        let firstValue = scalar.value - 0xac00
//        let jong = Int(firstValue % 28)
//        let jung = Int((Int(firstValue) - jong) / 28 % 21)
//        let cho = Int(((firstValue - jong) / 28 - jung) / 21)
//
//        let choChar = cho > 0 ? String(UnicodeScalar(cho + 0x1100)!) : nil
//        let jungChar = String(UnicodeScalar(jung + 0x1161)!)
//        let jongChar = jong > 0 ? String(UnicodeScalar(jong + 0x11a7)!) : nil
//
//        return (choChar, jungChar, jongChar)
//    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
