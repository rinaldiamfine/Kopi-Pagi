//
//  NavBarView.swift
//  Kopi Pagi
//
//  Created by Rinaldi LNU on 03/10/21.
//

import SwiftUI

struct NavBarView: View {
    
    @State var showBackButton: Bool = true
    @State var showAddButton: Bool = false
    private var navTitle = "Profile"
    
    
    var body: some View {
        VStack {
            GeometryReader(content: { geometry in
                let topEdge = geometry.safeAreaInsets.top
                NavBarTemplate(navTitle: navTitle, topEdge: topEdge, showBackButton: $showBackButton, showAddButton: $showAddButton)
                    .ignoresSafeArea()
            })
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}

struct NavBarTemplate: View {
    @State var navTitle: String
    @State var offset: CGFloat = 0
    var topEdge: CGFloat
    let maxHeight = UIScreen.screenHeight/4.3
    
    @Binding var showBackButton: Bool
    @Binding var showAddButton: Bool
    
    @State var setIndex: Int = 0
    @State var scrolled: Int = 0
    
    func getOpacityNavBarSmallTitle() -> CGFloat {
        let progress = -offset / UIScreen.radiusSize
        return progress < 1 ? progress : 1
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader(content: { geometry in
                    VStack(alignment: .leading, spacing: 15) {
                        NavBarTitle(navTitle: $navTitle, offset: $offset, topEdge: topEdge)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(), alignment: .bottom)
                    .background(
                        CustomCorner(corners: [], radius: getCornerRadius()).fill(
                            LinearGradient(
                                gradient: .init(colors: [
                                    ColorsManager().topBackground1,
                                    ColorsManager().topBackground2
                                ]),
                                startPoint: .init(x: 0, y: 0.5),
                                endPoint: .init(x: 1, y: 1)
                            )
                        )
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
                    )
                    .overlay(
                        HStack(spacing: 15) {
                            if showBackButton {
                                Button(action: {
                                    //Action
                                }, label: {
                                    Image(systemName: "chevron.backward")
                                        .imageScale(.large)
                                        .accentColor(.primary)
                                })
                            }
                            Spacer()
                            Text(navTitle)
                                .font(.system(size: 18, design: .rounded))
                                .bold()
                                .opacity(Double(getOpacityNavBarSmallTitle()))
                            Spacer()
                            if showAddButton {
                                Button(action: {
                                    //Action
                                }, label: {
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .accentColor(.primary)
                                })
                            }
                        }
                        .padding(.horizontal)
                        .frame(height: UIScreen.headerSize)
                        .padding(.top, topEdge)
                        , alignment: .top
                    )
                })
                .frame(height: maxHeight)
                .offset(y: -offset)
            }
            .zIndex(1)
            .modifier(OffsetModifier(offset: $offset))
            
            VStack {
//                ProfileListView()
            }
            .zIndex(0)
        }
        .coordinateSpace(name: "scroll")
    }
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.screenWidth - 30
        let width = screen - (2 * 30)
        return width
    }
    
    func getHeaderHeight() -> CGFloat {
        let topHeight = maxHeight + offset
        return topHeight > (UIScreen.headerSize + topEdge) ? topHeight : (UIScreen.headerSize + topEdge)
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = -offset / (maxHeight - (UIScreen.headerSize + topEdge))
        let value = 1 - progress
        let radius = value * UIScreen.radiusSize
        return offset < 0 ? radius : UIScreen.radiusSize
    }
}
