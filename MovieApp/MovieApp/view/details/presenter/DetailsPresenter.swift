//
//  DetailsPresenter.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
class DetailsPresenter{
    var detailsDelegate : DetailsDelegate?
    var connection: NetworkProtocol?
    var dataLayer : DataLayer?
    var MovieReviews : String = ""
    init()
    {
        connection = NetworkConnection()
    }
    func setDelegate(delegate: DetailsDelegate , dataLayer: DataLayer)
    {
        self.detailsDelegate = delegate
        self.dataLayer = dataLayer
        self.connection?.setDelegate(delegate: self)
    }
    func getReviews(url : String) {
        connection?.getReviews(url: url)
    }
    func setReviews(reviewArr : Array<Review>){
        detailsDelegate?.setReviews(reviewArr : reviewArr)
    }
    func getTrailers(url : String) {
        connection?.getTrailers(url: url)
    }
    func setTrailers(trailerArr : Array<Trailer>) {
       detailsDelegate?.setTrailers(trailerArr: trailerArr)
    }
    func isMovieExists(id : Int) -> Bool {
        return (dataLayer?.isMovieExists(id: id))!
       
    }
}
