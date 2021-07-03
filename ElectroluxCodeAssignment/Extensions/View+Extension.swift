//
//  View+Extension.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import Foundation
import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

