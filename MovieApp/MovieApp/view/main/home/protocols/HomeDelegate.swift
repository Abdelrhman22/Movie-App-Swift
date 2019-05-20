//
//  HomeDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
protocol HomeDelegate{
    func setPopularMovies(popularArr : Array<Movie>);
    func errorPopularMovies()
    func errorInternetConnection()
    
    
    
}
