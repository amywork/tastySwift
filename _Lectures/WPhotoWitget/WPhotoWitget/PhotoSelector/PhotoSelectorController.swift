//
//  PhotoSelectorController.swift
//  InstagramFirebase
//
//  Created by Brian Voong on 3/30/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var selectedImage: UIImage?
    var images = [UIImage]()
    var assets = [PHAsset]()
    
    var photoSelectorDelegate:PhotoSelectorControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        setupNavigationButtons()
        
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PhotoSelectorCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellId)
        fetchPhotos()
    }
    

    
    //옵션
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        //한번에 받아오는 데이터 제한
        fetchOptions.fetchLimit = 20
        //날짜별로 정렬
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
    //Data Fetch
    fileprivate func fetchPhotos() {
        //PHAsset데이터 받아오기
        //**Privacy - Photo Library Usage Description 작성 해야만 한다!!!**//
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        
        //멀티 쓰레드 사용
        DispatchQueue.global(qos: .background).async {
            
            //각 Asset을 한번씩 불러옴
            allPhotos.enumerateObjects({ (asset, count, stop) in
                //asset -> image로 변환 시켜주는 인스턴스
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                //이미지 불러오기 메소드
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        //초기값 설정
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    //모두 로드시
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                    
                })
                
            })
        }
    }
    
    
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleNext() {
        //다음
        if let selectedImage = selectedImage
        {
        self.photoSelectorDelegate?.photoselectorDidSelectedImage(selectedImage)
            dismiss(animated: true, completion: nil)
        }else
        {
            //선택된 이미지가 없습니다.
        }
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Mark : - DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        
        cell.photoImageView.image = images[indexPath.item]
        
        return cell
    }
    


    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell


        header.photoImageView.image = selectedImage

        if let selectedImage = selectedImage {
            if let index = self.images.index(of: selectedImage) {
                let selectedAsset = self.assets[index]

                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil, resultHandler: { (image, info) in

                    header.photoImageView.image = image
                    self.selectedImage = image
                })

            }
        }

        return header
    }
    
    //Mark : - Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
        
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    //Mark : - Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
}




protocol PhotoSelectorControllerDelegate
{
    func photoselectorDidSelectedImage(_ selectedImgae:UIImage)
}

