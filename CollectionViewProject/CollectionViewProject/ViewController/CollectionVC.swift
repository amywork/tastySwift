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
    var currentPageIndex = 0 {
        willSet {
            titleLabel.text = albumList[newValue].title
            artistLabel.text = albumList[newValue].artist
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playImageView:UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    
    /*Life Cycle*/
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPagingEnabled = true
        currentPageIndex = 0
    }
}

extension CollectionVC {
    @IBAction func pauseBtnHandler() {
        if isPlaying {
            isPlaying = false
            playImageView.image = #imageLiteral(resourceName: "Pause")
        }else {
            isPlaying = true
            playImageView.image = #imageLiteral(resourceName: "Play")
        }
    }
}

/*Extension Collection Data Source*/
extension CollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cellWidth: CGFloat {
        return collectionView.bounds.width*0.8
    }
    
    var cellHeight: CGFloat {
        return collectionView.bounds.width*0.8
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
    
    /*minimumInteritemSpacingForSectionAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /*minimumLineSpacingForSectionAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (viewWidth - cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        /*
         let fLayout = collectionViewLayout as! UICollectionViewFlowLayout
         fLayout.itemSize
         
         let indexPath = IndexPath(item: 0, section: section)
         collectionView.cellForItem(at: indexPath)
         */

        return UIEdgeInsets(top: (viewHeight-cellHeight)/2, left: (viewWidth-cellWidth)/2, bottom: (viewHeight-cellHeight) / 2, right: (viewWidth-cellWidth)/2)
        
    }
    
}

extension CollectionVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageIndex = Int(targetContentOffset.pointee.x/scrollView.bounds.size.width)
        currentPageIndex = pageIndex
    }
    
}
