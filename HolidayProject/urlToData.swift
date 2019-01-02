//
//  urlToData.swift
//  HolidayProject
//
//  Created by Jason on 12/14/18.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

final class urlToData{
    
    static func urlStuff(url: URL, completion: @escaping (UIImage) -> Void)  {
        let newURL = url
        
        do{
             let data = try Data(contentsOf: newURL)
            if let image = UIImage.init(data: data){
                completion(image)
            }
        }
        catch{
            print(error)
        }
    }
    
    
    
    
    
    
}
