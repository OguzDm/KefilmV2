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
    var body: some View {
        
        ZStack {
            Image("raya")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 32, height: Constants.cardSize, alignment: .center)
                .clipped()
                .cornerRadius(16)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                       .frame(width: 75, height: 35)
                       .background(.ultraThinMaterial,in: RoundedCorner(radius: 8, corners: .allCorners))
                HStack(spacing: 4){
                    Image("trending")
                        .resizable()
                        .frame(width:25,height: 25)
                        .foregroundColor(.orange)
                    Text("54232")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            
            }
            .padding(.bottom, Constants.cardSize - 50)
            .padding(.leading,UIScreen.main.bounds.width - 125)
            ZStack {
                Rectangle()
                    .cornerRadius(16, corners: [.bottomLeft,.bottomRight])
                    .background(.ultraThinMaterial,in: RoundedCorner(radius: 16, corners:[.bottomLeft,.bottomRight] ))
                Text("Raya and Last Dragon")
                    .font(.title3)
                    //.background(.red)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 70,alignment: .leading)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: Constants.nameViewSize)
            .padding(.top,Constants.cardSize - Constants.nameViewSize)
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: Constants.cardSize, alignment: .center)
    }
}

struct PopularMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieCard()
    }
}
