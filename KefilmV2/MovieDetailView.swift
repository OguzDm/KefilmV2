//
//  MovieDetailView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI

struct MovieDetailView: View {
    var body: some View {
        VStack {
            HStack(spacing:0) {
                VStack {
                    Text("90")
                        .foregroundColor(.green)
                        .padding(.all, 3)
                        .overlay(
                      RoundedRectangle(cornerRadius: 6)
                        .stroke()
                        .fill(.green)
                        )
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("2019")
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("1h 46m")
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("1000000")
                }
                .frame(width:UIScreen.main.bounds.width - 300,height: 450)
                VStack {
                    Image("wick")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .cornerRadius(96, corners: .bottomLeft)
                        .ignoresSafeArea()
                }
                .frame(width: 300, height: 450)
            }.frame(width: UIScreen.main.bounds.width, height: 450, alignment: .top)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
