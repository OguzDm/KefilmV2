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
    var id: Int
    @State private var showingSheet = false
    var body: some View {
                ZStack{
                    Image(genre)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .overlay( RoundedRectangle(cornerRadius: 8)
                                    .fill(color)
                                    .opacity(0.5).brightness(-0.5))
                        .onTapGesture {
                            showingSheet.toggle()
                        }
                    Text(genre)
                        .font(.system(.title))
                        .foregroundColor(.white)
                }
                .padding(.all,8)
                .fullScreenCover(isPresented: $showingSheet) {
                    GenresView(id: id)
                }
    }
}

struct GenreCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing:0){
            GenreCard(color: .blue, genre: "Action", id: 28)
        }
    }
}
