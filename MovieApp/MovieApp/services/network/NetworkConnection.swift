//
//  NetworkConnection.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage
import SwiftyJSON

class NetworkConnection : NetworkProtocol{
    
   
    var movies  : [Movie]!;
    var reviews : [Review]!;
    var trailers: [Trailer]!;
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var homePresenter :HomePresenter?
    var detailsPresenter : DetailsPresenter?
     var arrReviewRes = [[String:AnyObject]]()
     var fullReviews : String = ""
    func setDelegate(delegate: HomePresenter)
    {
        self.homePresenter = delegate
    }
    func setDelegate(delegate: DetailsPresenter) {
        self.detailsPresenter = delegate
    }
    
    
    func fetchMostPopular(url: String) {
        movies = []
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil)
            {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["results"].arrayObject
                {
                    self.arrRes = resData as! [[String:AnyObject]]
                    for index in 0..<self.arrRes.count{
                        let dict = self.arrRes[index]
                        let movieObject = Movie()
                        let movieId = dict[APIMovie.id.rawValue] as! Int
                        movieObject.id = movieId
                        let imgUrl = dict[APIMovie.posterPath.rawValue] as? String
                        if let fullUrl = imgUrl
                        {
                            
                            movieObject.fullUrl = "https://image.tmdb.org/t/p/w185/" + fullUrl
                        }
                        else{
                            movieObject.fullUrl = "https://silverspaceship.com/static/shot_1_thumb.png"
                        }
                        
                        movieObject.title = (dict[APIMovie.title.rawValue] as? String)!
                        movieObject.overview = (dict[APIMovie.overview.rawValue]as? String)!
                        movieObject.releaseDate = (dict[APIMovie.releaseDate.rawValue]as? String)!
                        let reviewURL = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=dc9a86621980e480855fa9b593c738e7"
                        movieObject.reviewURL = reviewURL
                        let trailerURL = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=dc9a86621980e480855fa9b593c738e7"
                        movieObject.trailerURL = trailerURL
                        movieObject.voteAverage = (dict[APIMovie.voteAverage.rawValue] as? NSNumber)?.floatValue ?? 0
                        self.movies.append(movieObject)
                    }
                }
                else
                {
                    print("responseData No results")
                }
            } // end of If
            else
            {
                print("responseData is nil")
            }
            if self.movies.count > 0
            {
                self.homePresenter?.successPopularMovies(PopularArr: self.movies)
            }
            else
            {
                self.homePresenter?.failurePopularMovies()
            }
        } // end of Alamofire.request
       
    }
    func getReviews(url : String)
    {
        reviews = []
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil)
            {
                let swiftyJsonVar = JSON(responseData.result.value!)
    
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrReviewRes = resData as! [[String:AnyObject]]
                    for i in 0..<self.arrReviewRes.count
                    {
                        var dictReview = self.arrReviewRes[i]
                        let reviewObject = Review()
                        reviewObject.author  = (dictReview["author"] as? String)!
                        reviewObject.content = (dictReview["content"] as? String)!
                        self.reviews.append(reviewObject)
                    }
                    self.detailsPresenter?.setReviews(reviewArr: self.reviews)
                }
            }
        }
       
    }
    func getTrailers(url: String) {
       trailers = []
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil)
            {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrReviewRes = resData as! [[String:AnyObject]]
                    for i in 0..<self.arrReviewRes.count
                    {
                        var dictReview = self.arrReviewRes[i]
                        let trailerObject = Trailer()
                        trailerObject.name  = (dictReview["name"] as? String)!
                        trailerObject.key = (dictReview["key"] as? String)!
                        self.trailers.append(trailerObject)
                    }
                    self.detailsPresenter?.setTrailers(trailerArr: self.trailers)
                }
            }
        }
    }
    
    
    
}
