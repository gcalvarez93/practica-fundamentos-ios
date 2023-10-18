//
//  Hero.swift
//  DragonBallSuperHeroes
//
//  Created by Gabriel Castro on 28/9/23.
//

import Foundation

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}
