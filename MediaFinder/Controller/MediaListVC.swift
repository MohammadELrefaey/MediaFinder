//
//  MediaListVCViewController.swift
//  MediaFinder
//
//  Created by Mohamed on 12/19/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class MediaListVC: UIViewController {

    let reusabelIdentifier: String = "MediaCellView"
    var mediaArray: [Media] = [Media]()
    var user: User!

    
    @IBOutlet weak var mediaTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Cell
        mediaTable.register(UINib(nibName: "MediaCellView", bundle: nil), forCellReuseIdentifier: reusabelIdentifier)
        
        // call Bind media unction
        bindMedia()
        
        // store to UserDefaults
        self.user = UserDefaulsManager.shared().get()
        
        //set table view delegates
        mediaTable.dataSource = self
        mediaTable.delegate = self
    }
    
    
    // get media from API
     func bindMedia() {
        
      APIManager.loadMovies { (error, myMoviesArr) in
        if let error = error {
            print(error.localizedDescription)
        } else if let myMoviesArr = myMoviesArr {
            self.mediaArray = myMoviesArr
            self.mediaTable.reloadData()
        }
      }
    }
    
    
    
    // Profile Button
    func goToProfileVC() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = sb.instantiateViewController(identifier: VC.ProfileVC) as! ProfileVC
    self.navigationController?.pushViewController(profileVC, animated: true)
    }

    @IBAction func ProfileBtnTapped(_ sender: UIButton) {
        goToProfileVC()
    }
}

// Extensions of tableView protocols

extension MediaListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusabelIdentifier, for: indexPath) as! MediaCellView
        cell.configure(media: mediaArray[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
}
