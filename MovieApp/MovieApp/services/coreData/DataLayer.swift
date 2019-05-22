//
//  DataLayer.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/10/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import CoreData

class DataLayer{

    let appDelegate : AppDelegate?
    var managedContext : NSManagedObjectContext?
    let movieEntity : NSEntityDescription?
    var movies : [NSManagedObject]!;     // movies array  of type NSManagedObject to deal with CoreData
    init(appDelegate : AppDelegate)
    {
        self.appDelegate = appDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        movieEntity = NSEntityDescription.entity(forEntityName: MoviesEntity.entityName.rawValue, in: managedContext!)
    }
    // method to insert Movie in CoreData
    func insertMovie(movie : Movie) -> Bool {
        
        let movieObj = NSManagedObject(entity: movieEntity!, insertInto: managedContext)
        
        movieObj.setValue(movie.id, forKey: MoviesEntity.id.rawValue)
        movieObj.setValue(movie.fullUrl, forKey: MoviesEntity.posterPath.rawValue)
        movieObj.setValue(movie.fullUrl, forKey: MoviesEntity.backdropPath.rawValue)
        movieObj.setValue(movie.title, forKey: MoviesEntity.title.rawValue)
        movieObj.setValue(movie.overview, forKey: MoviesEntity.overview.rawValue)
        movieObj.setValue(movie.releaseDate, forKey: MoviesEntity.releaseDate.rawValue)
        movieObj.setValue(movie.reviewURL, forKey: MoviesEntity.reviewUrl.rawValue)
        movieObj.setValue(movie.voteAverage, forKey: MoviesEntity.voteAverage.rawValue)
        movieObj.setValue(movie.trailerURL, forKey: MoviesEntity.trailerUrl.rawValue)
        print("Added to CoreData!")
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print(error)
            return false
        }
        return true
    }
    //*****************************************************************************************
    func getMovieDataById(id : Int) -> Movie {
        let movie : Movie = Movie()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MoviesEntity.entityName.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(MoviesEntity.id.rawValue) == %i", id)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                movie.id = (item.value(forKey: MoviesEntity.id.rawValue) as! Int?)!
                movie.fullUrl = (item.value(forKey: MoviesEntity.posterPath.rawValue) as! String?)!
                movie.title = (item.value(forKey: MoviesEntity.title.rawValue) as! String?)!
                movie.overview = (item.value(forKey: MoviesEntity.overview.rawValue) as! String?)!
                movie.releaseDate = (item.value(forKey: MoviesEntity.releaseDate.rawValue) as! String?)!
                movie.voteAverage = (item.value(forKey: MoviesEntity.voteAverage.rawValue) as! Float?)!
                movie.reviewURL = (item.value(forKey: MoviesEntity.reviewUrl.rawValue) as! String?)!
                movie.trailerURL = (item.value(forKey: MoviesEntity.trailerUrl.rawValue) as! String?)!
            }
            
        } catch let error as NSError {
            print (error)
        }
        return movie
    }
    //*****************************************************************************************
    func printMovie(movie : Movie)-> Void
    {
     print("MovieID is \(movie.id)")
     print("MovieImg is \(movie.fullUrl)")
     print("title is \(movie.title)")
     print("overview is \(movie.overview)") 
     print("releaseDate is \(movie.releaseDate)")
     print("reviewURL is \(movie.reviewURL)")
     print("voteAverage is \(movie.voteAverage)")
     print("trailerURL is \(movie.trailerURL)")
     print("------------------------------------------")
    }
    //*********************************************************************************
    // check if this movie exists in CoreData
    func isMovieExists(id: Int) -> Bool
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MoviesEntity.entityName.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(MoviesEntity.id.rawValue) == %i", id)
        
        var entitiesCount = 0
        
        do {
            entitiesCount = try managedContext!.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return entitiesCount > 0
    }
    //*************************************************************************************
    // to delete movie from CoreData
    func deleteMovie(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MoviesEntity.entityName.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(MoviesEntity.id.rawValue) == %i", id)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                managedContext?.delete(item)
            }
            try managedContext?.save()
            
        } catch let error as NSError {
            print (error)
            return false
        }
        return true
    }
    //*************************************************************************************
    func getFavouriteMovies() -> [NSManagedObject]
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MoviesEntity.entityName.rawValue)
        do
        {
            movies = try managedContext!.fetch(fetchRequest) // fetch
        }catch{
            print("viewWillAppear ...Error while fetching movies ")
        }
        return movies
    }
}
