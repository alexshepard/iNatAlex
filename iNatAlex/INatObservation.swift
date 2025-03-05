//
//  InatObservation.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/5/25.
//

import Foundation

struct INatObservation: Identifiable, Codable {
    var uuid: UUID
    var observationPhotos: [INatObservationPhoto]

    var id: UUID { uuid }
}

struct INatObservationPhoto: Identifiable, Codable {
    var uuid: UUID
    var photo: INatPhoto
    var id: UUID { uuid }
}

struct INatPhoto: Identifiable, Codable {
    var url: URL
    var smallUrl: URL {
        URL(string: url.absoluteString.replacingOccurrences(of: "square", with: "small"))!
    }

    var id: Int
}

struct ObsFetchResponse: Codable {
    var results: [INatObservation]
    var totalResults: Int
}
