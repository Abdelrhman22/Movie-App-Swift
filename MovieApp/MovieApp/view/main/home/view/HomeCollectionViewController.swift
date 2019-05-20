//
//  HomeCollectionViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/11/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
private let reuseIdentifier = "homeCollectionCell"

class HomeCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    @IBAction func switchMovies(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            
           self.homePresenter.setURL(URL: self.url)
        case 1:
            self.homePresenter.setURL(URL: self.urlTopRated)
        default:
            break
        }
    }
    var counter = 1
    var movies : [Movie]! = [];
    let url : String = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=dc9a86621980e480855fa9b593c738e7"
    let urlTopRated : String = "https://api.themoviedb.org/3/discover/movie?sort_by=top_rated.desc&api_key=dc9a86621980e480855fa9b593c738e7"
      var destinationVC : MovieDetailsViewController!
      var homePresenter: HomePresenter = HomePresenter()
      override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter.setDelegate(delegate: self)
        self.homePresenter.setURL(URL: self.url)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        self.destinationVC = segue.destination as! MovieDetailsViewController
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let image = movies[indexPath.row].fullUrl
        cell.moviePosterImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.jpg"))
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 8 * 2) / 2 //some width
        let height = width * 275 / 185 //ratio
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        destinationVC.setMovie(movieObj: movies[indexPath.row]);
    }
    func errorInternetConnection() {
        let alertController = UIAlertController(title: "Internet Connection failed", message: "Please enable internet", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
  

}
