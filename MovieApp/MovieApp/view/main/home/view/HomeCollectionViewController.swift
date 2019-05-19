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
            print("MostPopular")
           self.homePresenter.setURL(URL: self.url)
        case 1:
             print("HighRated")
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
    override func viewWillAppear(_ animated: Bool)
    {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        self.destinationVC = segue.destination as! MovieDetailsViewController
        //destinationVC.setMovie(movieObj: movies![(self.collectionView?.indexPath(for: reuseIdentifier).row)!]);
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
        //print(movies[indexPath.row].title)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
