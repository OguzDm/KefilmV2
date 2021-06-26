//
//  SearchView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 25.06.2021.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    var body: some View {
        VStack{
            SearchBarView(placeholder: "Search", text: $searchText)
            VStack{
                List{
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                    Text(searchText)
                }
                
            }
            Spacer()
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
