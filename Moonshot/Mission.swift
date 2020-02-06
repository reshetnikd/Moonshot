//
//  Mission.swift
//  Moonshot
//
//  Created by Dmitry Reshetnik on 06.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
