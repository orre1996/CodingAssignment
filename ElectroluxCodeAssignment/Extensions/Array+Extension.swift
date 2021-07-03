//
//  Array+Extension.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import Foundation

extension Array {
    subscript(safely index: Int) -> Element? {
        if index < count && index >= 0 {
            return self[index]
        }
        return nil
    }
}
