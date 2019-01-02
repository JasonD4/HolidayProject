//
//  animeAPI.swift
//  HolidayProject
//
//  Created by Jason on 12/13/18.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation


final class AnimeAPI{

    static func update(complete: @escaping ([GotAnimeAttributes]) -> Void ){
        var anime = [GotAnimeAttributes]()
      
        loadingData(escapee: { (data) in
            
            
                    do{
                let AllAnime = try JSONDecoder().decode(GotAnime.self, from: data)
                anime = AllAnime.data
                    complete(anime)
                print(anime.count)
            }catch{
                print("error is: \(error)")
            }
        })
//        return anime

    }
}




func loadingData (escapee: @escaping (Data) -> Void){
    guard let myURL = URL.init(string: "https://kitsu.io/api/edge/anime?filter[text]=\(animeWanted)") else {return}
        // this is just the link
        URLSession.shared.dataTask(with: myURL) { (data, response, error) in
            // these 3 are variables
            if let response = response {
                print(response)
            }
            if let error = error{
                print(error)
                //if url failed
            }
            if let data = data{
                escapee(data)
                // at the end of all the closer u must do .resume()
                
            }
            
            }.resume()
}

