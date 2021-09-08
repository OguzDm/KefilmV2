//
//  SimilarMovieView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 31.08.2021.
//

import SwiftUI

var width = UIScreen.main.bounds.width
var similarHeight: CGFloat = 375

struct SimilarMovieView: View {
    @StateObject var model = SimilarMovieViewModel()
    var movieID: Int
    var body: some View {
        
        VStack{
            ZStack {
                ForEach(model.movies.indices.reversed(),id: \.self){index in
                    HStack {
                        
                        AsyncImage(url: URL(string: Constants.baseLowResImageURL + model.movies[index].poster_path!)) { image in
                            
                            image
                                .resizable()
                                .scaledToFit()
                                .saturation(getSaturation(index: index))
                                .blur(radius: getBlur(index: index))
                                .cornerRadius(24)
                                .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                                .offset(x: getCardOffset(index: index))
                                .rotationEffect(.init(degrees: getCardRotation(index: index)))
                            
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray.opacity(0.7))
                        }

                        Spacer(minLength: 60)
                        
                    }
                    .frame(height:similarHeight)
                    .contentShape(Rectangle())
                    .offset(x: model.movies[index].offset)
                    .gesture(DragGesture(minimumDistance:0)
                                .onChanged({ value in
                        onChanged(value: value, index: index)
                    }).onEnded({ value in
                        onEnd(value: value, index: index)
                    }))
                }
                
            }
            .padding(.horizontal,24)
            .padding(.vertical,24)
            Button(action: ResetViews) {
                Image(systemName: "arrowshape.turn.up.left.2")
                    .font(.system(size: 20,weight: .semibold))
                    .foregroundColor(.blue.opacity(0.8))
                    .padding(.all,12)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color:Color.gray.opacity(0.6),radius: 2)
            }
            Spacer()
        }
        .onAppear {
            model.fetchSimilar(with: movieID)
        }
    }
    
    func ResetViews() {
        model.swipedCard = 0
        for index in model.movies.indices {
            withAnimation(.spring()) {
                model.movies[index].offset = 0
                
            }
        }
    }
    
    func getSaturation(index: Int) -> Double {
        withAnimation {
            let saturation = index - model.swipedCard == 0 ? 1.0 : 0.1
            
            return saturation
        }
    }
    
    func getBlur(index: Int) -> Double {
        withAnimation {
            let blur = index - model.swipedCard == 0 ? 0.0 : 1.5
            
            return blur
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int ) {
        if value.translation.width < 0 {
            model.movies[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int) {
        withAnimation {
            if -value.translation.width > width / 5 {
                model.movies[index].offset = -width
                model.swipedCard += 1
            }
            else {
                model.movies[index].offset = 0
            }
        }
    }
    
    func getCardRotation(index: Int) -> Double {
        
        let boxWidth = Double(width/3)
        
        let offset = Double(model.movies[index].offset)
        
        let angle: Double = 2
        
        return (offset / boxWidth) * angle
    }
    
    func getCardHeight(index: Int) -> CGFloat {
        let height: CGFloat = similarHeight
        let cardHeight = index - model.swipedCard <= 4 ? CGFloat(index - model.swipedCard) * 35 : 70
        
        return height - cardHeight
    }
    
    func getCardWidth(index: Int) -> CGFloat {
        let boxWidth = UIScreen.main.bounds.width - 60 - 60
        return boxWidth
    }
    
    func getCardOffset(index: Int) -> CGFloat {index - model.swipedCard <= 4 ? CGFloat(index - model.swipedCard) * 30 : 60}
}

//struct SimilarMovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimilarMovieView()
//    }
//}
