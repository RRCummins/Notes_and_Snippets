//
//  Boxing.swift
//  TRFramework
//
//  Created by Ryan Cummins on 10/20/21.
//

import UIKit


//MARK: - Class + Struct + Box
final class Box<Type> {
    var value: Type
    
    init(_ value: Type) {
        self.value = value
    }
}

extension Box: CustomStringConvertible where Type: CustomStringConvertible {
    var description: String {
        value.description
    }
}

extension Box: Equatable where Type: Equatable {
    static func ==(lhs: Box, rhs: Box) -> Bool {
        lhs.value == rhs.value
    }
}

extension Box: Comparable where Type: Comparable {
    static func <(lhs: Box, rhs: Box) -> Bool {
        lhs.value < rhs.value
    }
}

extension Box: Hashable where Type: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension Box: Identifiable where Type: Identifiable {
    var id: Type.ID { value.id }
}

extension Box {
    func map<Other>(_ function: (Type) throws -> Other) rethrows -> Box<Other> {
        Box<Other>(try function(value))
    }
}

extension Box: Encodable where Type: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}

extension Box: Decodable where Type: Decodable {
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Type.self)
        self.init(value)
    }
}

/*
struct Store {
    var name: String
    var address: String
    var isOpen: Bool
}

struct HomeScreen {Probably a scan
    var store: Box<Store>
}

struct HomeScreen {
    var store: Box<Store>
}
 
 let score = 20
 let boxedScore = Box(20)
 let secondBox = boxedScore
 
 print(boxedScore == secondBox)
*/
