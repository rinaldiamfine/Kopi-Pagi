//
//  GlobalConfiguration.swift
//  Kopi Pagi
//
//  Created by Rinaldi LNU on 03/10/21.
//

import Foundation
import SwiftUI

//STRUCT
//COLOR
struct ColorsManager {
    var topBackground1 = Color("TopBackground-1")
    var topBackground2 = Color("TopBackground-2")
}
//COLOR

//FOR NAVHEADER
struct NavBarTitle: View {
    @Binding var navTitle: String
    @Binding var offset: CGFloat
    var topEdge : CGFloat
    
    var body: some View {
        HStack {
            Text(navTitle)
                .font(.system(size: 36, design: .rounded))
                .bold()
            Spacer()
        }
        .padding()
        .padding(.bottom)
        .opacity(Double(getOpacity()))
    }
    
    func getOpacity() -> CGFloat {
        let progress = -offset / 50
        let opacity = 1 - progress
        return offset < 0 ? opacity : 1
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { geometry -> Color in
                let minY = geometry.frame(in: .named("scroll")).minY
                DispatchQueue.main.async {
                    self.offset = minY
                }
                return Color(.clear)
            }, alignment: .top
        )
    }
}
//FOR NAVHEADER
//STRUCT

//EXTENSION
//SCREEN
extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    static let sizePaddingHorizontal = CGFloat(30)
    static let sizeCardPaddingHorizontal = screenWidth-CGFloat(60)
    static let headerSize = CGFloat(80)
    static let radiusSize = CGFloat(50)
    static let sizeCardHeight = CGFloat(screenHeight/2)
}
//SCREEN
//EXTENSION
