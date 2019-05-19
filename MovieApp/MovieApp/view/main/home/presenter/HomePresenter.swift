//
//  HomePresenter.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
class HomePresenter{
    var connection: NetworkProtocol?
    
    var homeDelegate: HomeDelegate?
    
    init() {
        connection = NetworkConnection()
    }
    func setDelegate(delegate: HomeDelegate){
        self.homeDelegate = delegate
        self.connection?.setDelegate(delegate: self)
    }
    func successPopularMovies( PopularArr: Array<Movie>) {
    
        homeDelegate!.setPopularMovies(popularArr: PopularArr)
       
    }
    func failurePopularMovies( ) {
        homeDelegate!.errorPopularMovies()

    }
    
    func setURL(URL : String) {
        connection?.fetchMostPopular(url: URL)
    }
    
    
    
}
