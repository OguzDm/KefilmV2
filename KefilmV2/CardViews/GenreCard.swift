//
//  GenreCard.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 3.07.2021.
//

import SwiftUI

struct GenreCard: View {
    var color: Color
    var genre: String
    var body: some View {
                ZStack{
                    Image(genre)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .overlay( RoundedRectangle(cornerRadius: 8)
                                    .fill(color)
                                    .opacity(0.5))
                    Text(genre)
                        .font(.system(.title))
                        .foregroundColor(.white)
                }
                .padding(.all,8)
    }
}

struct GenreCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing:0){
            GenreCard(color: .blue, genre: "Action")
        }
        
    }
}
