//
//  MovieDetailView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    let movieID: Int
    var body: some View {
        VStack {
            HStack(spacing:0) {
                VStack {
                    Text("\(viewModel.rating)")
                        .font(.title3)
                        .foregroundColor(.green)
                        .padding(.all, 4)
                        .overlay(
                      RoundedRectangle(cornerRadius: 4)
                        .stroke()
                        .fill(.green)
                        )
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("\(viewModel.year)")
                        .font(.title3)
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("\(viewModel.runtime)")
                        .font(.title3)
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("$\(viewModel.budget)")
                        .font(.title3)
                }
                .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                VStack {
                    
                    AsyncImage(url: URL(string: Constants.baseImageURL + viewModel.poster)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / (3/2))
                            .cornerRadius(96, corners: .bottomLeft)
                            .ignoresSafeArea()
                    } placeholder: {
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width / (3/2))
                    }
                }
                .frame(width: UIScreen.main.bounds.width / (3/2))
            }.frame(width: UIScreen.main.bounds.width)
            HStack {
                VStack{
                }
                .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                VStack(spacing:0) {
                    Text(viewModel.title)
                        .font(.title2)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .padding(.bottom,8)
                        .padding(.top,16)
                    Text(viewModel.genres[0])
                        .font(.subheadline)
                        .foregroundColor(.gray).opacity(0.5)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .padding(.bottom,8)
                    Text(viewModel.overview)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width / (3/2))
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchMovieDetail(id: movieID)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailView(movieID: 615457)
                .preferredColorScheme(.dark)
        }
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
