//
//  AlbumViewController.swift
//  1016_DataModel
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

let albumTelevision:Dictionary<String,Any> =
    ["albumInfo":["albumTitle":"Television",
                  "artist":"지코(ZICO) ♥️🙈",
                  "genre":"h i p h o p"],
     "songList":[["songTitle":"천재",
                  "trackNum":1,
                  "artist":"지코(ZICO)",
                  "writer":"지코, Poptime",
                  "playTime":12340,
                  "playURL":"http://music.naver.com/123"],
                 ["songTitle":"Artist",
                  "trackNum":2,
                  "artist":"지코(ZICO)",
                  "writer":"지코, Poptime",
                  "playTime":10130,
                  "playURL":"http://music.naver.com/124"],
                 ["songTitle":"ANTI",
                  "trackNum":3,
                  "artist":"지코(ZICO)",
                  "writer":"지코, Poptime",
                  "playTime":12134,
                  "playURL":"http://music.naver.com/126"],
                 ["songTitle":"버뮤다 트라이앵글",
                  "trackNum":4,
                  "artist":"지코(ZICO)",
                  "writer":"지코, Poptime",
                  "playTime":12134,
                  "playURL":"http://music.naver.com/126"],
                 ["songTitle":"Fanxy Child",
                  "trackNum":5,
                  "artist":"지코(ZICO)",
                  "writer":"지코, Poptime",
                  "playTime":12134,
                  "playURL":"http://music.naver.com/126"]
        ]
]

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var TableView: UITableView!
    
    
    //MARK: - Data(Album Model)
    var albumModel:AlbumModel?
    var songList:[SongData]? {
        return albumModel?.songList
    }
    
    func createAlbumDataToModel() {
        self.albumModel = AlbumModel(dataDic: albumTelevision)
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        // TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // register이나 dataSource = self는 스토리보드에서 해줄 수 있음
        createAlbumDataToModel()
        titleLabel.text = self.albumModel?.albumInfo.albumTitle
        artistLabel.text = self.albumModel?.albumInfo.artist
        genreLabel.text = self.albumModel?.albumInfo.genre
    }
    
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.songList![indexPath.row].songTitle
        return cell
    }

}
