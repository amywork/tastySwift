//
//  MusicPlayerViewController.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 25..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

class MusicPlayerViewController: UIViewController {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var artistLb: UILabel!
    
    @IBOutlet weak var albumListCollectionView: UICollectionView!
    
    @IBOutlet weak var playBtn: UIButton!
    
    lazy var dataManger:MusicDataManager = MusicDataManager()
    var currentIndex = 0

    lazy var player:AVPlayer = AVPlayer()
    var isPlaying:Bool = false
    {
        didSet{
            if self.isPlaying
            {
                playBtn.setBackgroundImage(#imageLiteral(resourceName: "pauseWhite"), for: .normal)
            }else
            {
                playBtn.setBackgroundImage(#imageLiteral(resourceName: "playWhite"), for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    //변경
        play(index: currentIndex)
        //제스쳐 추가
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnAlbumCover(_:)))
        albumListCollectionView.addGestureRecognizer(gesture)
        
    }
    //앨범 가사 보기
    @objc func tapOnAlbumCover(_ sender:UITapGestureRecognizer)
    {//앨범커버 선택시 가사 뷰 띄우기
        
        if let lyricsVc = self.storyboard?.instantiateViewController(withIdentifier: "SongLyricViewController") as? SongLyricViewController
        {
            
            lyricsVc.data = dataManger.songDatas[currentIndex]
            self.addChildViewController(lyricsVc)
            self.view.addSubview(lyricsVc.view)
        }

    }
    //플레이 버튼 클릭
    @IBAction func playAction(_ sender:UIButton) {
    
        if isPlaying {
            pause()
        }else
        {
            play(index: currentIndex)
        }
    }
    
    
    @IBAction func nextSongAction(_ sender: UIButton) {
        if currentIndex != dataManger.songDatas.count - 1
        {
            currentIndex += 1
            
            playAnothor(with: currentIndex)
            
        }
    }
    
    @IBAction func prevSongAction(_ sender: UIButton) {
        if currentIndex != 0
        {
            currentIndex -= 1
            //scrollAnimation
            playAnothor(with: currentIndex)
            
        }
    }
    
}

extension MusicPlayerViewController
{
    private func playAnothor(with index:Int)
    {
        let pageWidth = (albumListCollectionView.bounds.size.height*0.6) + 25
        let newOffset = CGPoint(x: CGFloat(currentIndex) * pageWidth, y: albumListCollectionView.contentOffset.y)
        albumListCollectionView.setContentOffset(newOffset, animated: true)
    }
    
    private func play(index:Int ) {
        player.pause()
        let selectedData = dataManger.songDatas[currentIndex]
        self.titleLb.text = selectedData.title
        self.artistLb.text = selectedData.artistName
        if let urlPath = Bundle.main.url(forResource: selectedData.songUrl, withExtension: "mp3")
        {
            let asset = AVAsset(url: urlPath)
            let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: nil)
            player.replaceCurrentItem(with: playerItem)
            player.play()
            isPlaying = true
        }
        
    }
    
    private func pause()
    {
        player.pause()
        isPlaying = false
    }
}


extension MusicPlayerViewController:UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout
{
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManger.songDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumCollectionCell

       cell.imgView.image = dataManger.songDatas[indexPath.item].artworkImg
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    //변경
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.bounds.size.height * 0.6, height: collectionView.bounds.size.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //변경
        let sideInset = (collectionView.bounds.size.width - collectionView.bounds.size.height * 0.6)/2
        
        return UIEdgeInsets(top: 0, left:sideInset , bottom: 0, right: sideInset)
    }
    
    //변경
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        let sideInset = (collectionView.bounds.size.width - collectionView.bounds.size.height)
//        return sideInset
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let sideInset = (collectionView.bounds.size.width - collectionView.bounds.size.height)
//        return sideInset
//    }
    
}

extension MusicPlayerViewController:UIScrollViewDelegate
{
    //변경
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = (albumListCollectionView.bounds.size.height*0.6) + 25
        let pageIndex = Int(targetContentOffset.pointee.x/pageWidth + 0.5)
        currentIndex = pageIndex
        play(index:currentIndex)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        play(index:currentIndex)
        
    }
    
}





