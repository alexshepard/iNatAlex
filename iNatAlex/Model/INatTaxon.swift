//
//  INatTaxon.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/14/25.
//

import Foundation

struct INatTaxon: Codable, Identifiable {
    var id: Int
    var name: String
    var preferredCommonName: String?
}
