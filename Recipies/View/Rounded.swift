//
//  Rounded.swift
//  Recipies
//
//  Created by Перегудова Кристина on 21.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI

struct Rounded: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 30, height: 30))
        return Path(path.cgPath)
    }
}

struct Rounded2: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 30, height: 60))
        return Path(path.cgPath)
    }
}
