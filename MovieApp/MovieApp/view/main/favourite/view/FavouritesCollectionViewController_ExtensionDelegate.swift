//
//  FavouriteCollectionViewController_ExtensionDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import CoreData
extension FavouritesCollectionViewController: FavouriteDelegate
{
    func getClickedMovie(movie: Movie) {
       self.clickedMovie = movie
    }
    
    func retriveFavouriteMovies (arr :[NSManagedObject]){
        self.moviesArr = arr
        DispatchQueue.main.async{
            self.collectionView?.reloadData()
        }
    }
    
    
}
