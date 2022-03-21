//
//  SideMenu.swift
//  ClearNavigationBackground
//
//  Created by 민성홍 on 2022/03/21.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var clickedSideMenuButton: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                NavigationLink {
                    Text("SideMenu")
                } label: {
                    Text("SideMenu")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
