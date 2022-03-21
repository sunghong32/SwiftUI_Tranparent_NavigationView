//
//  ContentView.swift
//  ClearNavigationBackground
//
//  Created by 민성홍 on 2022/03/15.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var clickedButton: Bool = false
    @State var clickedSideMenuButton: Bool = false
    @State var offset: CGFloat = 0
    let topHeaderHeight = UIScreen.main.bounds.height / 8

    @State var sideOffset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0

    @State var openSideMenu: Bool = false
    @GestureState var gestureOffset: CGFloat = 0
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundImage = .init(named: "mainViewHeader")
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    func topBarTitleOpacity() -> CGFloat {
        let progress = -(offset - 80) / (topHeaderHeight - (120 + 80))

        //print(progress)

        return -progress
    }
    
    var body: some View {
        let sideBarWidth = getRect().width - 90
        ZStack {
            NavigationView {
                HStack(spacing: 0) {
                    SideMenuView(clickedSideMenuButton: $clickedSideMenuButton)

                    ZStack {
                        Image("bg_gradient")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.all)

                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .center) {
                                Text("Hello, world!")

                                Text("Hello, world!")

                                Text("Hello, world!")

                                Button {
                                    clickedButton.toggle()
                                } label: {
                                    Text("Click")
                                }

                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 300, height: 300)

                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 300, height: 300)

//                                Rectangle()
//                                    .fill(Color.white)
//                                    .frame(width: 300, height: 300)
                            }
                            .modifier(OffsetModifier(offset: $offset))
                            .padding(.vertical, 30)
                        }
                    }
                    .frame(width: getRect().width)
                    .overlay(
                        Rectangle()
                            .fill(
                                Color.primary
                                    .opacity(Double((sideOffset / sideBarWidth) / 5))
                            )
                            .ignoresSafeArea(.container, edges: .vertical)
                            .onTapGesture {
                                withAnimation {
                                    clickedSideMenuButton.toggle()
                                }
                            }
                    )
                }
                .frame(width: getRect().width + sideBarWidth)
                .offset(x: -sideBarWidth / 2)
                .offset(x: sideOffset > 0 ? sideOffset : 0)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded(onEnd(value:))
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if openSideMenu == false {
                            Button {
                                withAnimation {
                                    clickedSideMenuButton.toggle()
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(.black)
                            }
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Button {

                        } label: {
                            Text("2022년 3월")
                                .foregroundColor(.black)
                        }
                        .opacity(Double(topBarTitleOpacity()))
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SearchView()) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .animation(.easeInOut, value: sideOffset == 0)
            .onChange(of: clickedSideMenuButton) { newValue in
                print(sideOffset)
                print(clickedSideMenuButton)

                if clickedSideMenuButton && sideOffset == 0 {
                    sideOffset = sideBarWidth
                    lastStoredOffset = sideOffset
                    print(sideOffset)
                    print(clickedSideMenuButton)

                    withAnimation {
                        openSideMenu = true
                    }
                }

                if !clickedSideMenuButton && sideOffset == sideBarWidth {
                    sideOffset = 0
                    lastStoredOffset = 0

                    print(sideOffset)
                    print(clickedSideMenuButton)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            openSideMenu = false
                        }
                    }
                }
            }
            .onChange(of: gestureOffset) { newValue in
                onChange()
            }
        }
    }

    func onChange() {
        let sideBarWidth = getRect().width - 90

        sideOffset = (gestureOffset != 0) ? (gestureOffset < sideBarWidth ? gestureOffset + lastStoredOffset : sideOffset) : sideOffset

        if sideOffset <= 0 {
            openSideMenu = false
        } else if sideOffset <= sideBarWidth {
            openSideMenu = true
        }
    }

    func onEnd(value: DragGesture.Value) {
        let sideBarWidth = getRect().width - 90

        let translation = value.translation.width

        withAnimation {
            if translation > 0 {
                if translation > (sideBarWidth / 2) {
                    sideOffset = sideBarWidth
                    clickedSideMenuButton = true
                } else {
                    if sideOffset == sideBarWidth {
                        return
                    }

                    sideOffset = 0
                    clickedSideMenuButton = false
                }
            } else {
                if -translation > (sideBarWidth / 2) {
                    sideOffset = 0
                    clickedSideMenuButton = false
                } else {
                    if sideOffset == 0 || clickedSideMenuButton == false {
                        return
                    }

                    sideOffset = sideBarWidth
                    clickedSideMenuButton = true
                }
            }
        }

        lastStoredOffset = sideOffset
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
