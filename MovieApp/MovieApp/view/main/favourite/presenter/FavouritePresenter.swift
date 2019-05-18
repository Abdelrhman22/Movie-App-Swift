//
//  FavouritePresenter.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import CoreData
class FavouritePresenter{
    var movies : [NSManagedObject]!
    var clcikdeMovie : Movie = Movie()
    var dataLayer : DataLayer?
    var favouriteDelegate: FavouriteDelegate?
    
    init() {

    }
  
    
    func setDelegate(delegate: FavouriteDelegate , dataLayer : DataLayer){
        self.favouriteDelegate = delegate
        self.dataLayer = dataLayer
        getFavouriteMovies()
      }
    func getFavouriteMovies()
    {
        movies = dataLayer?.getFavouriteMovies()
        favouriteDelegate?.retriveFavouriteMovies(arr: movies)
    }
    func getClickedMovie(id : Int)
    {
        clcikdeMovie =  (dataLayer?.getMovieDataById(id: id))!
        favouriteDelegate!.getClickedMovie(movie: clcikdeMovie)
    }
}
