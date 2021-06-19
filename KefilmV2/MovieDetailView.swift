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
                    Text("100")
                        .foregroundColor(.green)
                        .padding(.all, 4)
                        .overlay(
                      RoundedRectangle(cornerRadius: 4)
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
                    Text("10000000")
                }
                .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                VStack {
                    Image("wick")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / (3/2))
                        .cornerRadius(96, corners: .bottomLeft)
                        .ignoresSafeArea()
                }
                .frame(width: UIScreen.main.bounds.width / (3/2))
            }.frame(width: UIScreen.main.bounds.width)
            HStack {
                VStack{
                }
                .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                VStack(spacing:0) {
                    Text("John Wick 3: Parabellum")
                        .font(.system(size: 20))
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .padding(.bottom,8)
                        .padding(.top,16)
                    Text("Action Drama Mystery")
                        .font(.system(size: 12))
                        .foregroundColor(.gray).opacity(0.5)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .padding(.bottom,8)
                    Text("Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail. After killing a member of the shadowy international assassin’s guild, the High Table, John Wick is excommunicado, but the world’s most ruthless hit men and women await his every turn.")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14))
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width / (3/2))
            }
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
struct TextView: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.textAlignment = .justified
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
