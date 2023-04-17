//
//  RecentlyCallDatable.swift
//  CallMandu
//
//  Created by mandu on 2023/04/17.
//

import Foundation
import Contacts
import CallKit

enum CallType {
    case incoming, sent, missing
}

struct RecentlyCallDatable: Hashable {
    var type: CallType
    var name: String
    var phoneType: String
    var phoneNumber: String
    
}

struct Call {
    var uuid: UUID
    var handle: String
    var type: CXHandle.HandleType
    var date: Date
}

class ContactFetcher {
    let callDirectoryManager = CXCallDirectoryManager.sharedInstance
    @Published var calls: [Call] = []

//    func fetchRecentlyList() {
//        let predicate = CXCallDirectoryExtensionContext()
//        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "com.example.myapp.CallDirectoryExtension", completionHandler: nil)
//        CXCallDirectoryManager.sharedInstance.getRecentCalls(with: predicate) { calls in
//            DispatchQueue.main.async {
//                self.calls = calls.map { call in
//                    let handle = call.handle.value
//                    let type = call.handle.type
//                    let date = call.date
//                    return Call(uuid: call.uuid, handle: handle, type: type, date: date)
//                }
//            }
//        }
//    }
    
    func fetchPhoneNumbers() -> [RecentlyCallDatable] {
        var phoneNumbers = [RecentlyCallDatable]()

        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactDatesKey, CNContactTypeKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                
                for phoneNumber in contact.phoneNumbers {
//                    let number = phoneNumber.value.stringValue
//                    phoneNumbers.append(number)
                }
            }
        } catch {
            debugPrint("Error fetching contacts: \(error.localizedDescription)")
        }
        
        return phoneNumbers
    }
}

