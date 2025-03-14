//
//  InatObservation.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/5/25.
//

import Foundation
import CoreLocation

struct INatObservation: Identifiable, Codable {
    var uuid: UUID
    var observationPhotos: [INatObservationPhoto]
    var taxon: INatTaxon?
    var user: INatUser
    var timeObservedAt: Date?
    var placeGuess: String?
    var location: String?

    var id: UUID { uuid }

    var taxonDisplayText: String {
        if let taxon = taxon {
            return taxon.preferredCommonName ?? taxon.name
        } else {
            return "Unknown Taxon"
        }
    }

    var observerDisplayText: String {
        user.name ?? user.login
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
        } else if CLLocationCoordinate2DIsValid(self.locationCoordinate) {
            return "\(self.locationCoordinate.latitude),\(self.locationCoordinate.longitude)"
        } else {
            return "Unknown Location"
        }
    }

    var locationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

    var latitude: Double {
        if let location = self.location {
            let parts = location.split(separator: ",")
            if parts.count == 2, let lat = Double(parts[0].trimmingCharacters(in: .whitespaces)) {
                return lat
            }
        }
        return kCLLocationCoordinate2DInvalid.latitude
    }

    var longitude: Double {
        if let location = self.location {
            let parts = location.split(separator: ",")
            if parts.count == 2, let lng = Double(parts[1].trimmingCharacters(in: .whitespaces)) {
                return lng
            }
        }
        return kCLLocationCoordinate2DInvalid.longitude
    }
}

extension INatObservation {
    static let sample: INatObservation = {
        let jsonFile = Bundle.main.url(forResource: "264725630", withExtension: "json")!
        let data = try! Data(contentsOf: jsonFile)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(ObsFetchResponse.self, from: data).results.first!
    }()
}
