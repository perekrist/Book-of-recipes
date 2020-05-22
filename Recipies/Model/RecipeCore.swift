//
//  RecipeCore.swift
//  Recipies
//
//  Created by Перегудова Кристина on 27.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftUI

class RecipeCore: Object {
    @objc var id: Int = 0
    @objc var label: String = ""
    @objc var image: String = ""
    @objc var calories: Int = 0
}
