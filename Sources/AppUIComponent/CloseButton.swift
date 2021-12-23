//
//  CloseButton.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/11/12.
//

import SwiftUI

public struct CloseButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Circle()
                .fill(Color(.secondarySystemBackground))
                .frame(width: 30, height: 30)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .heavy, design: .rounded))
                        .foregroundColor(.secondary)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Close"))
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton {}
    }
}
