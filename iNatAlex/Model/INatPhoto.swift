//
//  INatPhoto.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/14/25.
//


import Foundation

struct INatPhoto: Identifiable, Codable {
    var url: URL
    var smallUrl: URL {
        URL(string: url.absoluteString.replacingOccurrences(of: "square", with: "small"))!
    }

    var id: Int
}
