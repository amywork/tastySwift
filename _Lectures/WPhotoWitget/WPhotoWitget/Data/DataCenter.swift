//
//  DataCenter.swift
//  WPhotoWitget
//
//  Created by youngmin joo on 2017. 11. 9..
//  Copyright © 2017년 youngmin joo. All rights reserved.
//

import Foundation
import UIKit

let photoListKey = "photoList"

class DataCenter {
    static var main = DataCenter()
    

    var photoList:[PhotoData] = []
    
    private init()
    {
        loadPhotoData()
    }
    
    private func loadPhotoData()
    {
        guard let list = UserDefaults.standard.value(forKey: photoListKey) as? [[String:Any]] else { return }
        
        for dic in list
        {            
            if let photoData =  PhotoData(dataDic: dic)
            {
                photoList.append(photoData)
            }
        }
    }
    
    func savePhotosData()
    {
        var dicList:[Any] = []
        for photo in photoList
        {
            dicList.append(photo.dictionaryData)
        }
        print(dicList)
        UserDefaults.standard.set(dicList, forKey: photoListKey)
    }
    
    func addPhoto(title:String, data:Data)
    {
        photoList.append(PhotoData(title:title, data:data))
        savePhotosData()//매번 저장할 필요는 없음
    }

    
    //////////////////    
    var likePhotoData:PhotoData?{
        didSet{
            let gruopUser = UserDefaults(suiteName: "group.wingjoo.developer.todayextention")
            if likePhotoData!.isLike
            {
                gruopUser?.set(likePhotoData!.dictionaryData, forKey: "FavoritDataKey")
            }else
            {//좋아하는 사진 데이터가 없음
                gruopUser?.set(nil, forKey: "FavoritDataKey")
            }
            updatePhotoData(new: likePhotoData!)
        }
    }
    
    func updatePhotoData(new newData:PhotoData)
    {
        photoList = photoList.map { (data) -> PhotoData in
            
            if data.title == newData.title
            {
               return newData
            }else
            {
                return data
            }
        }
        
        print(photoList)
        
        savePhotosData()
    }
    
}


struct PhotoData {
    
    var title:String
    var imageData:Data
    var isLike:Bool = false
 
    var image:UIImage?{
        return UIImage(data:imageData)
    }
    
    var dictionaryData:[String:Any]{
        return ["title":title,"data":imageData,"isLike":isLike]
    }
    
    init(title:String, data:Data)
    {
        self.title = title
        self.imageData = data
    }
    
    init?(dataDic:[String:Any])
    {
        guard let title = dataDic["title"] as? String else {return nil}
        self.title = title
        guard let data = dataDic["data"] as? Data else {return nil}
        self.imageData = data
        guard let isLike = dataDic["isLike"] as? Bool else {return nil}
        self.isLike = isLike
    }
    
}




