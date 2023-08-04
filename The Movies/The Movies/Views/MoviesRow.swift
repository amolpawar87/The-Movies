//
//  MoviesRow.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import SwiftUI

struct MoviesRow: View {
    var theMovie: MovieResponseData?
    
    var body: some View {
        VStack {
            LazyImage(imageUrl: "\(IMAGE_CONSTANT.imageBaseURL)\(theMovie?.posterPath ?? "")")
        }
        .cornerRadius(6)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .padding(.vertical, 10)
    }
}

struct MoviesRow_Previews: PreviewProvider {
    static var previews: some View {
        MoviesRow()
    }
}
