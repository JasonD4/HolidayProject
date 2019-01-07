//
//  ViewController.swift
//  HolidayProject
//
//  Created by Jason on 12/13/18.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit
public var animeWanted = "bleach"

class AnimeViewController: UIViewController {
    
    @IBOutlet weak var AnimeSearchBar: UISearchBar!
    @IBOutlet weak var AnimeTableView: UITableView!
    @IBOutlet weak var DismissWarning: UIButton!
    
    
    var anime = [GotAnimeAttributes](){
        didSet{
            DispatchQueue.main.async {
                self.AnimeTableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        AnimeAPI.update { (animes) in
            self.anime = animes
        }
        AnimeTableView.dataSource = self
        AnimeTableView.delegate = self
        AnimeSearchBar.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func warningPopUp(_ sender: Any) {
        
            let alert = UIAlertController(title: "Does it Exsist?", message: "No anime was found", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let indexPath = AnimeTableView.indexPathForSelectedRow,
        let animeViewController = segue.destination as? DetailViewController else {return}
        
        animeViewController.anime = anime[indexPath.row]
        
    }
    

    
    
    
    
    

}

extension AnimeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return anime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = AnimeTableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as? AnimeCell else { return UITableViewCell()}
        let animeSelected = anime[indexPath.row]

        cell.AnimeName.text = animeSelected.attributes.canonicalTitle
        if animeSelected.attributes.episodeCount == nil{
            cell.EpisodeCount.text = "Episodes count: N/A"

        }
        else{
            cell.EpisodeCount.text = "Episodes count: \(animeSelected.attributes.episodeCount ?? 0)"

        }
        cell.StartDate.text = animeSelected.attributes.startDate
        cell.IsOnging.text = animeSelected.attributes.status.capitalized
        
        urlToData.urlStuff(url: animeSelected.attributes.posterImage.original!) { (image) in

            cell.AnimeImage?.image = image

        }
        
        cell.layer.borderWidth = 2
        
        
        return cell
    }
    

}



extension AnimeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }



}




extension AnimeViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchName = searchBar.text else {return animeWanted = "bleach"}
        
        animeWanted = searchName.replacingOccurrences(of: " ", with: "-")
        AnimeAPI.update { (animes) in
            self.anime = animes
            if self.anime.count == 0{
                self.warningPopUp((Any).self)
            }
        }
        searchBar.resignFirstResponder()
        let indexPath = IndexPath(row: 0, section: 0)
        AnimeTableView.scrollToRow(at: indexPath, at: .top, animated: true)

        
    }
    
    
    
}
