//
//  MovieCardView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import SwiftUI

struct MovieCardView: View {
    
    var imageURL: String
    var backgroundImageURL: String
    var name: String
    var id : Int
    var proxy: GeometryProxy
    @State private var showingSheet = false
    
    var body: some View {
        
        ZStack {
            AsyncImage(url: URL(string: backgroundImageURL)) { image in
                image
                    .resizable()
                    .blur(radius: 16)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height * 1.25)
                    .clipped()
                    .brightness(-0.15)
                
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.7))
                    .frame(width: proxy.size.width, height: proxy.size.height * 1.25)
                    .clipped()
                    .brightness(-0.15)
            }
            
            VStack {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: proxy.size.width - 80, height: proxy.size.height - 240)
                            .clipped()
                            .cornerRadius(24)
                            .shadow(color: .black, radius: 10, x: 1, y: 5)
                            .onTapGesture {
                                showingSheet.toggle()
                            }
                        
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.ultraThinMaterial)
                            .frame(width: proxy.size.width - 80, height: proxy.size.height - 240)
                            .overlay(
                                ProgressView()
                                    .foregroundColor(.black)
                                    .scaleEffect(1.5)
                            )
                        
                    }
                    
                    Text(name)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .textSelection(.enabled)
                        .padding(.top,8)
            }
            .fullScreenCover(isPresented: $showingSheet) {
                MovieDetailView(movieID: id)
            }
            
        }
        .frame(width: proxy.size.width, height: proxy.size.height)
        
    }
}
