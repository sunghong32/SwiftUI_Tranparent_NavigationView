//
//  OffsetModifier.swift
//  ClearNavigationBackground
//
//  Created by 민성홍 on 2022/03/21.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .named("SCROLL")).minY

                    //print(minY)
                    DispatchQueue.main.async {
                        self.offset = minY
                    }

                    return Color.clear
                }
                ,alignment: .top
            )
    }
}
