//
//  MediaListVCViewController.swift
//  MediaFinder
//
//  Created by Mohamed on 12/19/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class MediaListVC: UIViewController, UISearchBarDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var mediaTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var mediaTypeSC: UISegmentedControl!
    @IBOutlet weak var noDataImg: UIImageView!
    
    //MARK:- Properties
    var mediaArray: [Media] = [Media]()
    var user: User!
    var mediaType: String = MediaType.music
    var searchQuery = ""
    var scStaus: Int = 0
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = VCTitles.MediaList
        
        SearchBar.delegate = self
        
        CustomNavigationBar()
        
        setupMediaTable()
        
        getLastSearchFromDataBase()
        
        mediaTypeSC.selectedSegmentIndex = scStaus
        
        hideTable()
    }

    //MARK:- Actions
    @IBAction func ProfileBtnTapped(_ sender: UIButton) {
            goToProfileVC()
        }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            scStaus = sender.selectedSegmentIndex
            mediaType = MediaType.music
            bindMedia()
        }
        else if sender.selectedSegmentIndex == 1 {
            scStaus = sender.selectedSegmentIndex
            mediaType = MediaType.movie
            bindMedia()
        }
        else if sender.selectedSegmentIndex == 2 {
            scStaus = sender.selectedSegmentIndex
            mediaType = MediaType.tvShow
            bindMedia()
        }
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension MediaListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reusabelIdentifier, for: indexPath) as! MediaCellView
        cell.configure(media: mediaArray[indexPath.row], mediaType: mediaType)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        previewMedia(indexPath: indexPath)
    }
}

//MARK:- Priavte Methods
extension MediaListVC {
    // get media from API
    private func bindMedia() {
        APIManager.loadMedia(searchQuery: searchQuery, mediaType: mediaType) { (error, mediaArr) in
        if let error = error {
            print(error.localizedDescription)
        } else if let mediaArr = mediaArr {
            self.mediaArray = mediaArr
            self.mediaTable.reloadData()
            self.inserLastSearchIntoDataBase()
            self.hideTable()
        }
      }
    }
    
    private func setupMediaTable(){
        //Register Cell
        mediaTable.register(UINib(nibName: Cell.mediaCell, bundle: nil), forCellReuseIdentifier: Cell.mediaCell)
        //set table view delegates
        mediaTable.dataSource = self
        mediaTable.delegate = self
        //self sizing
        mediaTable.rowHeight = UITableView.automaticDimension
        mediaTable.estimatedRowHeight = 600
    }
    
    @objc private func goToProfileVC() {
        let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
        let profileVC = sb.instantiateViewController(identifier: ViewContoller.ProfileVC) as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func setubNavigationBarButton() {
        let profileButton = UIBarButtonItem()
        profileButton.image = UIImage.init(systemName: "person.circle.fill")
        profileButton.target = self
        profileButton.action = #selector(goToProfileVC)
        navigationItem.rightBarButtonItem = profileButton
    }
    
    private func CustomNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        setubNavigationBarButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText.lowercased()
        print(searchQuery)
        bindMedia()
    }
    
    private func previewMedia(indexPath: IndexPath) {
        guard let url = URL(string: mediaArray[indexPath.row].previewUrl) else {return}
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true, completion: nil)
    }
    
    private func inserLastSearchIntoDataBase() {
        UserDefaults.standard.setValue(mediaType, forKey: UserDefaultsKeys.mediaType)
        UserDefaults.standard.setValue(scStaus, forKey: UserDefaultsKeys.scStatus)
        SQLiteManager.shared().deleteLastSearch()
        SQLiteManager.shared().insertLastSearchResult(mediaArr: self.mediaArray)
    }
    
    private func getLastSearchFromDataBase() {
        if let mediaArr = SQLiteManager.shared().getLastSearchResult() {
            self.mediaArray = mediaArr
        }

        if let mediaType = UserDefaults.standard.string(forKey: UserDefaultsKeys.mediaType) {
            self.mediaType = mediaType
        }
        
        self.scStaus = UserDefaults.standard.integer(forKey: UserDefaultsKeys.scStatus)
    }
    
    private func hideTable() {
        if mediaArray.count == 0 {
            noDataImg.isHidden = false
        } else {
            noDataImg.isHidden = true
        }
    }
}

