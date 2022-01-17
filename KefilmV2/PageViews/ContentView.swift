//
//  ContentView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tab = .nowPlaying
    var body: some View {
        
        ZStack(alignment: .bottom)  {
            
            Group{
                switch selectedTab {
                case .nowPlaying:
                    HomePageView()
                case .popular:
                    PopularMoviesView()
                case .search:
                    SearchView()
                }
               
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            HStack {
                ForEach(tabItems) { item in
                    Button {
                        selectedTab = item.tab
                    } label: {
                        VStack(spacing:0) {
                            
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .scaleEffect(1.25)
                                .font(.body.bold())
                                .frame(width:44,height: 29)
                            
                            Text(item.text)
                                .font(.avenirNext(size: 14))
                                .lineLimit(1)

                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                }
            }
            .padding(.horizontal,8)
            .padding(.top,14)
            .frame(height: 88, alignment: .top)
            .background(.ultraThinMaterial,in: Rectangle())
            .frame(maxHeight: .infinity,alignment: .bottom)
            .ignoresSafeArea()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
