//
//  Challenges.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/26/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

internal func exerciseOne() {
    // This would normally be network calls that return `NSData`. We'll show you how to do those soon!
    // In this case, we are using a local JSON file.
    guard let jsonURL = Bundle.main.url(forResource: "Random-User", withExtension: "json") else {
        print("Could not find Random-User.json!")
        return
    }
    let jsonData = try! Data(contentsOf: jsonURL)
    
    
    // Enter SwiftyJSON!
    // userData now contains a JSON object representing all the data in the JSON file.
    // This JSON file contains the same data as the tutorial example.
    let userData = try! JSON(data: jsonData)
    
    // Alright, now we have a JSON object from SwiftyJSON containing the user data!
    // Let's save the user's first name to a constant!
    let firstName = userData["results"][0]["name"]["first"].stringValue
    // Do you see what we did there? We navigated down the JSON heirarchy, asked for "results",
    // then the first dictionary value of that array, then the dictionary stored in "name",
    // then the value stored in "first". We  then told it that we wanted the value as a string.
    /*
     
     
     Now it's your turn to get the rest of the values needed to print the following:
     
     "<first name> <last name> lives at <street name> in <city>, <state>, <post code>.
     If you want to contact <title>. <last name>, you can email <email address> or
     call at <cell phone number>."
     
     */
    
    let myFirstName = userData["results"][0]["name"]["first"].stringValue
    let lastName = userData["results"][0]["name"]["last"].stringValue
    let streetname = userData["results"][0]["location"]["street"].stringValue
    let city = userData["results"][0]["location"]["city"].stringValue
    let state = userData["results"][0]["location"]["state"].stringValue
    let postCode = userData["results"][0]["location"]["postcode"].intValue
    let title = userData["results"][0]["name"]["title"].stringValue
    let email = userData["results"][0]["email"].stringValue
    let cellPhone = userData["results"][0]["phone"].stringValue
    
    print("\(myFirstName) \(lastName) lives at \(streetname) in \(city), \(state), \(postCode). If you want to contact \(title). \(lastName), you can email \(email) or call at \(cellPhone)")
    
}

internal func exerciseTwo() {
    // This would normally be network calls that return `NSData`. We'll show you how to do those soon!
    // In this case, we are using a local JSON file.
    guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
        print("Could not find Random-User.json!")
        return
    }
    let jsonData = try! Data(contentsOf: jsonURL)
    
    
    // Enter SwiftyJSON!
    // moviesData now contains a JSON object representing all the data in the JSON file.
    // This JSON file contains the same data as the tutorial example.
    let moviesData = try! JSON(data: jsonData)
    
    // We save the value for ["feed"]["entry"][0] to topMovieData to pull out just the first movie's data
    let topMovieData = moviesData["feed"]["entry"][0]
    let topMovie = Movie(json: topMovieData)
    
    //     Uncomment this print statement when you are ready to check your code!
    
    print("The top movie is \(topMovie.name) by \(topMovie.rightsOwner). It costs $\(topMovie.price) and was released on \(topMovie.releaseDate). You can view it on iTunes here: \(topMovie.link)")
}

internal func exerciseThree() {
    // This would normally be network calls that return `NSData`. We'll show you how to do those soon!
    // In this case, we are using a local JSON file.
    guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
        print("Could not find iTunes-Movies.json!")
        return
    }
    let jsonData = try! Data(contentsOf: jsonURL)
    
    // Enter SwiftyJSON!
    // moviesData now contains a JSON object representing all the data in the JSON file.
    // This JSON file contains the same data as the tutorial example.
    let moviesData = try! JSON(data: jsonData)
    
    // We've done you the favor of grabbing an array of JSON objects representing each movie
    let allMoviesData = moviesData["feed"]["entry"].arrayValue
    
    
    // Figure out a way to turn the allMoviesData array into Movie structs!
    var allMovies: [Movie] = []
    
    for eachMovie in allMoviesData{
        let currentMovie = Movie(json: eachMovie)
        allMovies.append(currentMovie)
    }
    
    print(allMovies[0])
    
    
    /*
     
     Uncomment the below print statement and then print out the names of the two Disney
     movies in allMovies. A movie is considered to be a "Disney movie" if `rightsOwner`
     contains the `String` "Disney". Iterate over all the values in `allMovies` to check!
     
     
     Movie(name: "Zootopia", rightsOwner: "© 2016 Disney Enterprises, Inc. All Rights Reserved", price: 19.990000000000002, link: "https:itunes.apple.com/us/movie/zootopia/id1084138493?uo=2", releaseDate: "March 4, 2016")
     
     */
    print("The following movies are Disney movies:")
    var disneyMovies = [String]()
    for eachMovie in allMovies{
        if eachMovie.rightsOwner.contains("Disney"){
            disneyMovies.append(eachMovie.name)
        }
    }
    print(disneyMovies)
    
    var cheapMovie = [String: Double]()
    
    //
    for eachMovie in allMovies{
        if eachMovie.price < 15.0{
            cheapMovie[eachMovie.name] = eachMovie.price
        }
    }
    
    for (key, value) in cheapMovie {
        print("\(key): \(value)")
    }
    
    
    
    /*
     
     Uncomment the below print statement and then print out the name and price of each
     movie that costs less than $15. Iterate over all the values in `allMovies` to check!
     
     
     
     
     Uncomment the below print statement and then print out the name and release date of
     each movie released in 2016. Iterate over all the values in `allMovies` to check!
     
     */
    print("The following movies were released in 2016:")
    
    var yearMovie = [String:String]()
    for eachMovie in allMovies{
        if eachMovie.releaseDate.contains("2016"){
            yearMovie[eachMovie.name] = eachMovie.releaseDate
        }
    }
    
    for (key, value) in yearMovie{
        
        print("\(key) was released in \(value)")
    }
}

