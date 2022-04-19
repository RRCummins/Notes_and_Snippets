//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Ryan Cummins on 4/19/22.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameStyle())
    }
}
