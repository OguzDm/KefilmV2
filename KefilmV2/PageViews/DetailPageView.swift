//
//  DetailPageView.swift
//  KefilmV2
//
//  Created by Oğuz Demirhan on 17.01.2022.
//

import SwiftUI
import WrappingStack

struct DetailPageView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    private let imageHeight: CGFloat = 400
    private let collapsedImageHeight: CGFloat = 0
    let movieID: Int
    
    @ObservedObject private var articleContent: ViewFrame = ViewFrame()
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero
    
    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight
        
        // if our offset is roughly less than -225 (the amount scrolled / amount off screen)
        if offset < -sizeOffScreen {
            // Since we want 75 px fixed on the screen we get our offset of -225 or anything less than. Take the abs value of
            let imageOffset = abs(min(-sizeOffScreen, offset))
            
            // Now we can the amount of offset above our size off screen. So if we've scrolled -250px our size offscreen is -225px we offset our image by an additional 25 px to put it back at the amount needed to remain offscreen/amount on screen.
            return imageOffset - sizeOffScreen
        }
        
        // Image was pulled down
        if offset > 0 {
            return -offset
            
        }
        
        return 0
    }
    
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height
        
        if offset > 0 {
            return imageHeight + offset
        }
        
        return imageHeight
    }
    
    // at 0 offset our blur will be 0
    // at 300 offset our blur will be 6
    func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // (values will range from 0 - 1)
        
        return blur * 6 // Values will range from 0 - 6
    }
    
    // 1
    private func getHeaderTitleOffset() -> CGFloat {
        let currentYPos = titleRect.midY
        
        // (x - min) / (max - min) -> Normalize our values between 0 and 1
        
        // If our Title has surpassed the bottom of our image at the top
        // Current Y POS will start at 75 in the beggining. We essentially only want to offset our 'Title' about 30px.
        if currentYPos < headerImageRect.maxY {
            let minYValue: CGFloat = 50.0 // What we consider our min for our scroll offset
            let maxYValue: CGFloat = collapsedImageHeight // What we start at for our scroll offset (75)
            let currentYValue = currentYPos

            let percentage = max(-1, (currentYValue - maxYValue) / (maxYValue - minYValue)) // Normalize our values from 75 - 50 to be between 0 to -1, If scrolled past that, just default to -1
            let finalOffset: CGFloat = -30.0 // We want our final offset to be -30 from the bottom of the image header view
            // We will start at 20 pixels from the bottom (under our sticky header)
            // At the beginning, our percentage will be 0, with this resulting in 20 - (x * -30)
            // as x increases, our offset will go from 20 to 0 to -30, thus translating our title from 20px to -30px.
            
            return 20 - (percentage * finalOffset)
        }
        
        return .infinity
    }
    var body: some View {
        ZStack(alignment:.top) {
            ScrollView {
                if viewModel.loadingState == .ready {
                    
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(viewModel.model?.original_title ?? "-")
                                            .font(.avenirNext(size: 28))
                                            .background(GeometryGetter(rect: self.$titleRect))
                                        
                                        Spacer()
                                        
                                        if !viewModel.videos.isEmpty {
                                            Button {
                                                if UIApplication.shared.canOpenURL(URL(string: Constants.baseYoutubeURL + viewModel.videos.first!.key)!){
                                                    UIApplication.shared.openURL(URL(string: Constants.baseYoutubeURL + viewModel.videos.first!.key)!)
                                                   } else{
                                                       UIApplication.shared.openURL(URL(string: Constants.baseYoutubeURL + viewModel.videos.first!.key)!)
                                                   }
                                            } label: {
                                                HStack {
                                                    Text("Trailer")
                                                        .font(.avenirNext(size: 16))
                                                    Image(systemName: "play.fill")
                                                }
                                                .padding(.all,5)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(8)
                                                .foregroundColor(.primary)
                                              

                                            }
                                        }
                                    }
                                   
                                    
                                    HStack {
                                        ForEach(viewModel.model!.genres,id:\.self) { genre in
                                                Text(genre.name)
                                                    .padding(.all,4)
                                                    .background(.ultraThinMaterial)
                                                    .cornerRadius(8)
                                            
                                        }
                                    }
                                       
                                    Text("\(viewModel.model?.releaseYear ?? "-") • \(viewModel.model?.runTimeText ?? "-")")
                                        .font(.avenirNextRegular(size: 16))
                                        .foregroundColor(.gray)
                                }
                                
                            }
                           
                            
                            Text(viewModel.model?.overview ?? "-")
                                .lineLimit(nil)
                                .font(.avenirNextRegular(size: 17))
                            
                          
                        }
                        .padding(.horizontal)
                        .padding(.top, 16.0)
                    }
                    .offset(y: imageHeight + 16)
                    .background(GeometryGetter(rect: $articleContent.frame))
                    
                    GeometryReader { geometry in
                        // 3
                        ZStack(alignment: .topLeading) {
                            
                            AsyncImage(url: URL(string: Constants.baseImageURL + viewModel.model!.backdrop_path)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
                                    .blur(radius: self.getBlurRadiusForImage(geometry))
                                    .clipped()
                                    .background(GeometryGetter(rect: self.$headerImageRect))
                                    .onAppear {
                                        viewModel.poster = image
                                    }
                            } placeholder: {
                                Rectangle()
                                    .fill(.gray.opacity(0.5))
                                    .overlay(ProgressView())
                            }
                            
                            
                            // 4
                            Text(viewModel.model?.original_title ?? "-")
                                .font(.avenirNext(size: 17))
                                .foregroundColor(.white)
                                .offset(x: 0, y: self.getHeaderTitleOffset())
                        }
                        .clipped()
                        .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
                    }.frame(height: imageHeight)
                    .offset(x: 0, y: -(articleContent.startingRect?.maxY ?? UIScreen.main.bounds.height))
                }
             
            }.edgesIgnoringSafeArea(.all)
               .onAppear {
                   viewModel.initialize(id: movieID)
               }
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "chevron.backward")
                                    .font(.system(size:24))
                                    .foregroundColor(.primary))

                }
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "ellipsis")
                                    .rotationEffect(Angle(degrees: 270))
                                    .font(.system(size:24))
                                    .foregroundColor(.primary))

                }
            }
            .padding(.horizontal)
        }
        
     }
}

struct DetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPageView(movieID: 3131)
    }
}

class ViewFrame: ObservableObject {
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }
    
    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            AnyView(Color.clear)
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
            self.rect = value
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
