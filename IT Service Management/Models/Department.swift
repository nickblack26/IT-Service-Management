//
//  DepartmentModel.swift
//  IT Service Management
//
//  Created by Nick Black on 8/21/24.
//

import Foundation

struct Department: Identifiable, Codable {
    var id: Int
    var identifier: String
    var name: String
}
