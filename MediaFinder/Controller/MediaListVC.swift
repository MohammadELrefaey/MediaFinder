//
//  MediaListVCViewController.swift
//  MediaFinder
//
//  Created by Mohamed on 12/19/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class MediaListVC: UIViewController {

    let reusabelIdentifeier: String = "MediaTableViewCell"
    var mediaArray: [Media] = [Media]()
    var user: User!

    
    @IBOutlet weak var mediaTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.user = getUserDefaults()
        
        //unwraping media array
        if let unWrappedMediaArray = self.user.mediaArray {
            mediaArray = unWrappedMediaArray
            print(mediaArray)
        }
        
        //set table view delegates
        mediaTable.dataSource = self
        mediaTable.delegate = self
    }
    
    

    
    
    // Profile Button
    func goToProfileVC() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let profileVC = sb.instantiateViewController(identifier: "profileVC") as! ProfileVC
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusabelIdentifeier, for: indexPath) as! MediaTableViewCell
        cell.configure(media: mediaArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    
}
