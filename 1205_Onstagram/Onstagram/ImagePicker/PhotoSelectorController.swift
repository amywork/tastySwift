//
//  ImagePickerVC.swift
//  Onstagram
//
//  Copyright © 2017년 yunari.me. All rights reserved.
//

import UIKit
import Photos

// MARK: - Protocol
protocol PhotoSelectorControllerDelegate {
    func photoselectorDidSelectedImage(_ selectedImage:UIImage)
}

enum PhotoSelectorLoadType {
    case ProfileImagePicker
    case NewPostPicker
}

class PhotoSelectorController: OnstagramController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    
    var collectionView: UICollectionView?
  
    // MARK: - Property
    var selectedImage: UIImage?
    var images = [UIImage]()
    var assets = [PHAsset]()
    
    // MARK: - ImagePickerDelegate
    var delegate: PhotoSelectorControllerDelegate?
    
    // PickerVC 가 생성될 때 우측 상단 버튼 분기
    var pickerType: PhotoSelectorLoadType = .NewPostPicker
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        setUpCollectionView()
        setupNavigationButtons()
    }
    
    // PHFetchOptions
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 20
        /*날짜별로 정렬 가능
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
         */
        return fetchOptions
    }
    
    // Data Fetch
    fileprivate func fetchPhotos() {
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects({ (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                })
            })
        }
    }

    // MARK: - CollectionView Delegate & DataSource
    private let cellId = "PhotoCell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        header.photoImageView.image = selectedImage
        
        if let selectedImage = selectedImage {
            if let index = self.images.index(of: selectedImage) {
                let selectedAsset = self.assets[index]
                let targetSize = CGSize(width: 600, height: 600)
                
                PHImageManager.default().requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
                    header.photoImageView.image = image
                    self.selectedImage = image
                })
            }
        }
        
        return header
    }
    
    //Mark : - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    //Mark : - CollectionView Layout
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

extension PhotoSelectorController {
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PhotoSelectorCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellId)
    }
    
    fileprivate func setupNavigationButtons() {
        switch self.pickerType {
        case .NewPostPicker:
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
            navigationItem.title = "Select Photo"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        case .ProfileImagePicker:
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
            navigationItem.title = "Edit Profile"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        }
    }
    
    @objc func handleDone() {
        if let selectedImage = selectedImage {
            self.delegate?.photoselectorDidSelectedImage(selectedImage)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }else {
            let alertController = UIAlertController(title: "사진을 선택하세요",
                                                    message: "선택된 사진이 없습니다",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func handleNext() {
        if let selectedImage = selectedImage {
            let postVC = PostController()
            postVC.selectedImage = selectedImage
            self.navigationController?.pushViewController(postVC, animated: true)
        }else {
            let alertController = UIAlertController(title: "사진을 선택하세요",
                                                    message: "선택된 사진이 없습니다",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func handleCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
