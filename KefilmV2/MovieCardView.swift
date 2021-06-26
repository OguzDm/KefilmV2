//
//  MovieCardView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import SwiftUI

struct MovieCardView: View {
    var imageURL: String
    var name: String
    var id : Int
    @State private var showingSheet = false
    var body: some View {
            VStack {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .centerCropped()
                            .cornerRadius(24)
                            .onTapGesture {
                                showingSheet.toggle()
                            }
                    } placeholder: {
                        Rectangle()
                            .fill(.gray.opacity(0.7))
                    }
                    
                    Text(name)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom,16)
                        .textSelection(.enabled)
            }
            .sheet(isPresented: $showingSheet) {
                MovieDetailView(movieID: id)
            }
            .padding(.leading,24)
            .padding(.trailing,24)
            .padding(.top,8)
            .background(AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaleEffect(1.4)
                    .blur(radius: 20)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.7))
            })
            .frame(width: UIScreen.main.bounds.width)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
