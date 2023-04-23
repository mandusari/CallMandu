//
//  ContractDatable.swift
//  CallMandu
//
//  Created by mandu on 2023/04/17.
//

import Foundation

struct ContactDatable: Hashable {
    var familyName: String
    var givenName: String
    var jobTitle: String
    var phoneNumber: [String]
}

var ContactMockupData = ContactDatable(familyName: "김", givenName: "용태", jobTitle: "포블", phoneNumber: ["010-3327-9431", "031-569-9430"])

