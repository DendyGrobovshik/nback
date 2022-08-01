//
//  ArrayRawRepresentable.swift
//  nback
//
//  Created by Denis Gradoboev on 31.07.2022.
//

import Foundation

// Extension that available to use array with @AppStoage
// SEE: https://stackoverflow.com/questions/62562534/swiftui-what-is-appstorage-property-wrapper/62563773#62563773
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
