//
//  FavouriteDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import CoreData
protocol FavouriteDelegate
{
    func retriveFavouriteMovies ( arr :[NSManagedObject])
    func getClickedMovie (movie : Movie)
}
