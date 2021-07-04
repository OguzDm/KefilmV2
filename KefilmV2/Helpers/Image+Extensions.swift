//
//  Image+Extensions.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 5.07.2021.
//

import Foundation
import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
