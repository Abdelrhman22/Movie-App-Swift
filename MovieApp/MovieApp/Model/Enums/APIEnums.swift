//
//  APIEnums.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/10/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
enum APIMovie : String{
    case results = "results"
    /*
     Movie Data From Json
    */
    case id = "id"
    case posterPath  = "poster_path"
    case releaseDate = "release_date"
    case title = "title"
    case voteAverage = "vote_average"
    case overview = "overview"
}
enum SortType : String{
    case Popularity = "popularity"
    case TopRated = "vote_count"
}
