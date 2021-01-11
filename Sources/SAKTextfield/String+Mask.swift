//
//  String+Mask.swift
//  
//
//  Created by Antoine Barrault on 10/01/21.
//

import Foundation

extension String {

    func apply(mask: String) -> String {
        var maskElements = mask.split(separator: "#", omittingEmptySubsequences: false)
        let lastPart = maskElements.removeLast()
        return zip(self, maskElements).map {
            return String("\($0.1)\($0.0)")
        }.joined().appending(lastPart)
    }

    func unmask(mask: String) -> String {
        var chara = mask

        var result: String = ""
        self.forEach { current in
            if chara.count == 0 {
                result.append(current)
                return
            }
            let letter = chara.removeFirst()
            if letter == "#" {
                result.append(current)
            } else if letter != current {
                result.append(current)
                chara.insert(letter, at: chara.startIndex)
            }

        }

        return result

    }

}
