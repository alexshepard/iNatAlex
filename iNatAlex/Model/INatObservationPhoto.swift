//
//  INatObservationPhoto.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/14/25.
//


import Foundation

struct INatObservationPhoto: Identifiable, Codable {
    var uuid: UUID
    var photo: INatPhoto
    var id: UUID { uuid }
}
