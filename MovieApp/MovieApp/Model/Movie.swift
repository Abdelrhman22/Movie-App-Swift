//
//  Movie.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/10/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
class Movie : NSObject
{
    var id : Int = 0
    var fullUrl : String = ""
    var title : String = ""
    var overview : String = ""
    var releaseDate : String = ""
    var reviewURL : String = ""
    var voteAverage : Float = 0.0
    var trailerURL : String = ""
    var arrReviews  : [Review]
    var arrTrailers : [Trailer]
    override init ()
    {
        self.id = 0
        self.fullUrl = ""
        self.title = ""
        self.overview = ""
        self.releaseDate = ""
        self.reviewURL = ""
        self.voteAverage = 0.0
        self.trailerURL = ""
        self.arrReviews = []
        self.arrTrailers = []
    }
    
}
