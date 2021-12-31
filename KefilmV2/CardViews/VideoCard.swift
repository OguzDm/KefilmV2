//
//  VideoCard.swift
//  VideoCard
//
//  Created by Oguz Demırhan on 13.09.2021.
//

import SwiftUI
import AVKit

struct VideoCard: View {
    var videoID: String
    var proxy: GeometryProxy
    @State private var showingSheet = false
    var body: some View {
        
        ZStack {
            AsyncImage(url: URL(string: "https://i.ytimg.com/vi/\(videoID)/maxresdefault.jpg")) { image in
                image
                    .resizable()
                    .frame(width: proxy.size.width, height: 250)
                    .scaledToFit()
                    .cornerRadius(16)
                
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray.opacity(0.5))
                    .frame(width: proxy.size.width, height: 250)
                    .overlay(ProgressView())
            }

            Image(systemName: "play.rectangle.fill")
                .resizable()
                .scaleEffect(0.25)
                .foregroundColor(.red)
                .onTapGesture {
                    showingSheet.toggle()
                }
        }
        .fullScreenCover(isPresented: $showingSheet) {
            SafariView(url: URL(string: Constants.baseYoutubeURL + videoID)!)
        }
    }
}

//struct VideoCard_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoCard(videoID: "V_zwalcR8DU")
//    }
//}
