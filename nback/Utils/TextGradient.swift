//
//  TextGradient.swift
//  nback
//
//  Created by Denis Gradoboev on 28.07.2022.
//

import Foundation
import SwiftUI

extension Text {
    public func gradient(
        colors: [Color] = [.white, .yellow],
        startPoint: UnitPoint = .leading,
        endPoint: UnitPoint = .trailing
    ) -> some View
    {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
            )
        }
    }
}
