//
//  ContractViewModel.swift
//  CallMandu
//
//  Created by mandu on 2023/04/17.
//

import Foundation
import Contacts

class ContactViewModel: ObservableObject {
    @Published var data: [ContactDatable] = []

    func fetchContract() {
        data.removeAll()
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let store = CNContactStore()
            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactDatesKey, CNContactTypeKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    DispatchQueue.main.async {
                        self.data.append(
                            ContactDatable(
                                familyName: contact.familyName,
                                givenName: contact.givenName,
                                phoneNumber: contact.phoneNumbers.map({ $0.value.stringValue })
                            ))
                    }
                }
            } catch {
                debugPrint("Error fetching contacts: \(error.localizedDescription)")
            }
        }
    }
}
