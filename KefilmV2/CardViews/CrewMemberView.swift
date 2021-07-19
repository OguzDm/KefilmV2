//
//  CrewMemberView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.07.2021.
//

import SwiftUI

struct CrewMemberView: View {
    var name: String
    var character: String
    var image: String
    var body: some View {
        ZStack {
            VStack{
                AsyncImage(url: URL(string: Constants.baseLowResImageURL + image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                        .cornerRadius(50)
                } placeholder: {
                    Circle()
                        .fill(.gray)
                        .frame(width: 100, height: 100, alignment: .center)
                }
                Text(name)
                Text(character)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 150, height: 150)
    }
}
