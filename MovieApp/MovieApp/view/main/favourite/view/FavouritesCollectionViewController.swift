//
//  FavouritesCollectionViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/11/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
private let reuseIdentifier = "movieCell"

class FavouritesCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout  {
     var moviesArr : [NSManagedObject]!;
     var clickedMovie: Movie = Movie()
     var destinationVC : MovieDetailsViewController!
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var favouritePresenter: FavouritePresenter = FavouritePresenter()
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        favouritePresenter.setDelegate(delegate: self  , dataLayer: dataLayer)
        DispatchQueue.main.async{
            self.collectionView?.reloadData()
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.destinationVC = segue.destination as? MovieDetailsViewController
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let imageLink  = (moviesArr![indexPath.row].value(forKey: MoviesEntity.posterPath.rawValue) as! String)
        cell.favouritePosterImage.sd_setImage(with: URL(string: imageLink), placeholderImage: UIImage(named: "placeholder.jpg"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 8 * 2) / 2 //some width
        let height = width * 275 / 185 //ratio
        return CGSize(width: width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        favouritePresenter.getClickedMovie(id: (moviesArr![indexPath.row].value(forKey: MoviesEntity.id.rawValue) as! Int))
        destinationVC.setMovie(movieObj: clickedMovie);
    }
    
}
