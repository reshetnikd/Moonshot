//
//  Astronaut.swift
//  Moonshot
//
//  Created by Dmitry Reshetnik on 06.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
