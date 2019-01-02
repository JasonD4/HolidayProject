//
//  DetailViewController.swift
//  HolidayProject
//
//  Created by Jason on 12/31/18.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var AnimeImage: UIImageView!
    @IBOutlet weak var StartToEndDate: UILabel!
    @IBOutlet weak var EpisodeLengthAndTime: UILabel!
    @IBOutlet weak var StatusAndNextRelease: UILabel!
    @IBOutlet weak var AgeRating: UILabel!
    @IBOutlet weak var JapaneseName: UILabel!
    @IBOutlet weak var EpisodeSummary: UITextView!
    var anime: GotAnimeAttributes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
getThatAnime()
    }

    

}





extension DetailViewController{
    private func getThatAnime(){
        
        self.title = anime?.attributes.canonicalTitle
        
        urlToData.urlStuff(url: anime!.attributes.posterImage.original!) { (image) in
            
            self.AnimeImage.image = image
            
        }
        
        StartToEndDate.text = "Start Date: \(anime?.attributes.startDate ?? "Not released yet") - End Date: \(anime?.attributes.endDate ?? "Still Going")"
        
        EpisodeLengthAndTime.text = "EpisodeLength: \(anime?.attributes.episodeLength ?? 0)Mins"
        
        if anime?.attributes.nextRelease == nil{
            
            StatusAndNextRelease.text = "Is this anime still going: \(anime?.attributes.status ?? "")"
        }
        else{
            StatusAndNextRelease.text = "Is this anime still going: \(anime?.attributes.status ?? "") next episode \(anime?.attributes.nextRelease ?? "")"
        }
        
        
        if anime?.attributes.nsfw == true{
            
            AgeRating.text = "\(anime?.attributes.ageRating ?? "") \(anime?.attributes.ageRatingGuide ?? "") I wouldnt recommend to watch this at work"
            
        }
        else  { AgeRating.text = "\(anime?.attributes.ageRating ?? "") \(anime?.attributes.ageRatingGuide ?? "") This is safe to watch at the work"
        }
        
        if anime?.attributes.ja_jp == nil{
            JapaneseName.text = anime?.attributes.canonicalTitle
        }
        else{
            JapaneseName.text = "japanese name: \(anime?.attributes.ja_jp ?? "")"
            
            
        }
        EpisodeSummary.text = anime?.attributes.synopsis ?? ""
        
    }
}
