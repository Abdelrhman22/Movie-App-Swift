//
//  DetailsViewController_ExtensionDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
extension MovieDetailsViewController: DetailsDelegate
{
    
    func setReviews(reviewArr : Array<Review>) {
        
        self.reviews = reviewArr
        self.setre(reviewArr : reviewArr)
        DispatchQueue.main.async{
            self.view.reloadInputViews()
        }
     /*  for i in 0..<reviews.count
        {
            print(reviews[i].author)
            print(reviews[i].content)
            print("----------------------------")
        }*/
    }
    func setTrailers(trailerArr: Array<Trailer>) {
       self.trailers = trailerArr
       self.setTrai(trailerArr: trailerArr)
        DispatchQueue.main.async{
            self.view.reloadInputViews()
        }
        /*
        print("Trailers Count in DetailsDelegate \(trailers.count)")
        for i in 0..<trailers.count
        {
            print(trailers[i].name)
            print(trailers[i].key)
        }
         */
    }
    
    
}
