//
//  Extension.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import Foundation

extension String {
    
    func capitalizerFirstLeter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
