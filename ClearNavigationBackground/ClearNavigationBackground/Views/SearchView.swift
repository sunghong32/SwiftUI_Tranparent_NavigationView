//
//  SearchView.swift
//  ClearNavigationBackground
//
//  Created by 민성홍 on 2022/03/21.
//
import SwiftUI

struct SearchView: View {
    var numbers = [Int](0..<100)

    var body: some View {
        ZStack {
            Image("bg_gradient")
                .resizable()
                .ignoresSafeArea(.all)

            VStack {
                Text("SearchView")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("검색")
            }
        }
    }
}
