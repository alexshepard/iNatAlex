//
//  ObsFetchResponse.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/14/25.
//


import Foundation

struct ObsFetchResponse: Codable {
    var results: [INatObservation]
    var totalResults: Int
}
