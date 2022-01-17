//
//  PopularMovieCard.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI

struct PopularMovieCard: View {
    struct Constants {
        static let cardSize: CGFloat = 225
        static let nameViewSize: CGFloat = 50
    }
    var name: String
    var imageURL: String
    var popularity: String
    var id : Int
    let proxy: GeometryProxy
    @State private var showingSheet = false
    var body: some View {
        
        ZStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width - 32, height: Constants.cardSize, alignment: .center)
                    .clipped()
                    .cornerRadius(16)
                    .onTapGesture {
                        showingSheet.toggle()
                    }
                
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray.opacity(0.7))
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 8,style: .continuous)
                    .fill(.ultraThinMaterial)
                    .frame(width: 75, height: 35)
                
                HStack(spacing: 4){
                    Image("trending")
                        .resizable()
                        .frame(width:25,height: 25)
                        .foregroundColor(.orange)
                    Text(popularity)
                        .font(.avenirNext(size: 14))
                        .foregroundColor(.primary.opacity(0.75))
                }
                
            }
            .padding(.bottom, Constants.cardSize - 50)
            .padding(.leading,proxy.size.width - 125)
            ZStack {
                
                Text(name)
                    .font(.avenirNext(size: 18))
                    .foregroundColor(.primary.opacity(0.75))
                    .frame(width: proxy.size.width - 70,alignment: .leading)
                    .textSelection(.enabled)
                
            }
            .frame(width: proxy.size.width - 32, height: Constants.nameViewSize)
            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 16,style: .continuous))
            .padding(.top,Constants.cardSize - Constants.nameViewSize)
        }
        .frame(width: proxy.size.width - 32, height: Constants.cardSize, alignment: .center)
        .fullScreenCover(isPresented: $showingSheet) {
            withAnimation {
                DetailPageView(movieID: id)
            }
        }
    }
}

//struct PopularMovieCard_Preview: PreviewProvider {
//    static var previews: some View {
//        PopularMovieCard(name: "blabla", imageURL: "https://www.themoviedb.org/t/p/original/ncEsesgOJDNrTUED89hYbA117wo.jpg", popularity: "5341", id: 1)
//            .preferredColorScheme(.dark)
//    }
//}
