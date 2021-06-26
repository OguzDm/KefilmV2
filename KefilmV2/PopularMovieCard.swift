//
//  PopularMovieCard.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI
import SwiftUIVisualEffects

struct PopularMovieCard: View {
    
    struct Constants {
        static let cardSize: CGFloat = 225
        static let nameViewSize: CGFloat = 50
    }
    var name: String
    var imageURL: String
    var popularity: String
    var body: some View {
        
        ZStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 32, height: Constants.cardSize, alignment: .center)
                    .clipped()
                    .cornerRadius(16)
                
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray.opacity(0.7))
            }

            ZStack {
                RoundedRectangle(cornerRadius: 8)
                       .frame(width: 75, height: 35)
                       .vibrancyEffect()
                       .vibrancyEffectStyle(.quaternaryLabel)
                       .background(.black .opacity(0.5))
                       .cornerRadius(8)
                HStack(spacing: 4){
                    Image("trending")
                        .resizable()
                        .frame(width:25,height: 25)
                        .foregroundColor(.orange)
                    Text(popularity)
                        .font(.caption)
                        .foregroundColor(.white)
                }
            
            }
            .padding(.bottom, Constants.cardSize - 50)
            .padding(.leading,UIScreen.main.bounds.width - 125)
            ZStack {
                Rectangle()
                    .cornerRadius(16, corners: [.bottomLeft,.bottomRight])
                    .vibrancyEffect()
                    .vibrancyEffectStyle(.quaternaryLabel)
                    .background(.black .opacity(0.5))
                    .cornerRadius(16)
                Text(name)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 70,alignment: .leading)
                    .textSelection(.enabled)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: Constants.nameViewSize)
            .padding(.top,Constants.cardSize - Constants.nameViewSize)
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: Constants.cardSize, alignment: .center)
    }
}

struct PopularMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieCard(name: "Raya and Last Dragon",imageURL: "",popularity: "5423")
    }
}
