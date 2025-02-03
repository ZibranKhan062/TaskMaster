//
//  TodoTask.swift
//  first_project
//
//  Created by Zibran Khan on 03/02/25.
//

import Foundation

struct TodoTask: Codable, Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
