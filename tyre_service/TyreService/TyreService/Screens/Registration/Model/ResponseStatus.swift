//
//  ResponseStatus.swift
//  TyreService
//
//  Created by Kirill Severin on 23.10.21.
//

import Foundation

struct ResponseStatus: Decodable {
    let success: Bool
    let errors: [String]?
}
