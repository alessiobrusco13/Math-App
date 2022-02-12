//
//  Bundle-Decodable.swift
//  Bundle-Decodable
//
//  Created by Alessio Garzia Marotta Brusco on 24/08/2021.
//

import Foundation

extension Bundle {
    /// Decodes and parses to a Swift Decodable type, a JSON file from the Bundle.
    /// - Parameters:
    ///   - type: A generic Decodable type the data is going to be converted to.
    ///   - file: The name of the file in our Bundle as a String.
    ///   - dateDecodingStrategy: The DateDecodingStrategy used by the JSONDecoder.
    ///   - keyDecodingStrategy: The KeyDecodingStrategy used by the JSONDecoder.
    /// - Returns: Returns the parsed JSON Data in the chosen Swift type.
    func decode<D: Decodable>(
        _ type: D.Type, from file: String,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> D {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(D.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(_, context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

