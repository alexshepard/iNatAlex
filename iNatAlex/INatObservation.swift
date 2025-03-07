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
    var taxon: INatTaxon?
    var timeObservedAt: Date?
    var placeGuess: String?

    var id: UUID { uuid }

    var taxonDisplayName: String {
        if let taxon = taxon {
            if let commonName = taxon.preferredCommonName {
                return commonName
            } else {
                return taxon.name
            }
        } else {
            return "Unknown Taxon"
        }
    }

    static var dateDisplayTextFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var dateDisplayText: String {
        if let timeObservedAt = self.timeObservedAt {
            return INatObservation.dateDisplayTextFormatter.string(from: timeObservedAt)
        } else {
            return "Unknown Date"
        }
    }

    var locationDisplayName: String {
        if let placeGuess = self.placeGuess {
            return placeGuess
        } else {
            // could show lat/lng here
            return "Unknown Location"
        }
    }
}

struct INatTaxon: Codable, Identifiable {
    var id: Int
    var name: String
    var preferredCommonName: String?
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
