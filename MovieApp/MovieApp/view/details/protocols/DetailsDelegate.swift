//
//  DetailsDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
protocol DetailsDelegate{
    func setReviews(reviewArr : Array<Review>)
    func setTrailers(trailerArr : Array<Trailer>)
}
