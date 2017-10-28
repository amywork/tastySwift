//
//  CollectionVC.swift
//  CollectionViewProject
//
//  Created by 김기윤 on 26/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import AVFoundation
private let reuseIdentifier = "AlbumCoverCell"
class CollectionVC: UIViewController {
    /*Property*/
    var albumList:[AlbumDataModel] = DataCenter.main.albumList
    var isPlaying: Bool = false
    var player:AVPlayer?
    var currentPageIndex = 0 {
        willSet {
            titleLabel.text = albumList[newValue].title
            artistLabel.text = albumList[newValue].artist
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBAction func nextSongAction(_ sender: UIButton) {
    }
    
    @IBAction func prevSongAction(_ sender: UIButton) {
    }

    
    /*Life Cycle*/
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.isPagingEnabled = true
        currentPageIndex = 0
    }
}


/*Extension Collection Data Source*/
extension CollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cellWidth: CGFloat {
        return collectionView.bounds.width*0.5
    }
    
    var cellHeight: CGFloat {
        return collectionView.bounds.width*0.5
    }
    
    var viewWidth: CGFloat {
        return collectionView.bounds.width
    }
    
    var viewHeight: CGFloat {
        return collectionView.bounds.height
    }
    
    
    /*numberOfItemsInSection*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumList.count
    }
    
    /*cellForItemAt*/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCoverCell
        cell.data = albumList[indexPath.item]
        return cell
    }
    
    
    /*sizeForItemAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (viewWidth-cellWidth)/2, bottom: 0, right: (viewWidth-cellWidth)/2)
    }
    
}

/*scrollViewWillEndDragging*/
extension CollectionVC: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageIndex = Int(targetContentOffset.pointee.x/scrollView.bounds.size.width)
        currentPageIndex = pageIndex
    }
}
