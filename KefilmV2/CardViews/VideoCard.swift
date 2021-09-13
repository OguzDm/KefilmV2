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
    @State private var showingSheet = false
    var body: some View {
        
        ZStack {
            AsyncImage(url: URL(string: "https://i.ytimg.com/vi/\(videoID)/maxresdefault.jpg")) { image in
                image
                    .resizable()
                
            } placeholder: {
                Rectangle()
                    .fill(.gray)
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
        .frame(width: width, height: 250)
    }
}

struct VideoCard_Previews: PreviewProvider {
    static var previews: some View {
        VideoCard(videoID: "V_zwalcR8DU")
    }
}
