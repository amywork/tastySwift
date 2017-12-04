//
//  UserModel.swift
//  DataModelSample
//
//  Created by youngmin joo on 2017. 10. 15..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation

enum Gender:Int
{
    case man = 1
    case woman = 2
}

//유저 모델
struct UserModel
{
    var userID:String
    var pw:String
    var email:String
    var birthday:String?
    var gender:Gender?
    
    init?(dataDic:[String:Any])
    {
        //필수 항목 모델화
        guard let userID = dataDic["UserID"] as? String else {return nil}
        self.userID = userID
        
        guard let pw = dataDic["userPw"] as? String else {return nil}
        self.pw = pw
        
        guard let email = dataDic["email"] as? String else {return nil}
        self.email = email
        
        //옵셔널 항목 모델화
        self.birthday = dataDic["birthDay"] as? String
        
        if let rawData = dataDic["gender"] as? Int, (rawData == 1 || rawData == 2)
        {
            self.gender = Gender(rawValue:rawData)
        }
    }
}
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

//전시회 정보
struct Exhibition
{
    var title:String
    var startDate:Date
    var endDate:Date
    var imageURL:String?
    var place:String?
    
    init?(data:Dictionary<String,String>)
    {
        guard let title = data["title"] else { return nil }
        self.title = title
        //날짜변환
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        guard let startDateStr = data["startDate"] else { return nil }
        guard let sDate = formatter.date(from: startDateStr) else { return nil}
        self.startDate = sDate

        guard let endDateStr = data["endDate"] else { return nil }
        guard let eDate = formatter.date(from: endDateStr) else { return nil}
        self.endDate = eDate
    
    }
    
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

struct AlbumInfo
{
    var albumTitle:String
    var artist:String
    var genre:String
    
    init?(dataDic:[String:Any])
    {
        guard let albumTitle = dataDic["albumTitle"] as? String else { return nil }
        self.albumTitle = albumTitle
        guard let artist = dataDic["artist"] as? String else { return nil }
        self.artist = artist
        guard let genre = dataDic["genre"] as? String else { return nil }
        self.genre = genre
    }
}
struct SongData
{
    var songTitle:String
//    var trackNum:Int
    var artist:String
//    var writer:String
    var formatter:DateFormatter = DateFormatter()
    
    var playTime:Int = 0{
        willSet
        {
            let now = Date(timeIntervalSince1970: TimeInterval(newValue))
            formatter.dateFormat = "mm:ss"
            self.totalPlayTime = formatter.string(from: now)
        }
    }
    var totalPlayTime:String = "00:00"
//    var playURL:String
    
    init?(dataDic:[String:Any])
    {
        guard let songTitle = dataDic["songTitle"] as? String  else { return nil }
        self.songTitle = songTitle
        guard let artist = dataDic["artist"] as? String else { return nil }
        self.artist = artist
        
        guard let playTime = dataDic["playTime"] as? Int else { return nil }
        self.playTime = playTime
        
        let now = Date(timeIntervalSince1970: TimeInterval(playTime))
        formatter.dateFormat = "mm:ss"
        self.totalPlayTime = formatter.string(from: now)
        
        print(totalPlayTime)
    }
    
    mutating func timeUse()
    {
        playTime -= 1
    }
    
}

struct AlbumModel
{
    var albumInfo:AlbumInfo
    var songList:[SongData] = []
    
    init?(dataDic:[String:Any])
    {
        guard let infoDic = dataDic["albumInfo"] as? Dictionary<String,Any> else {return nil}
        //데이터 인스턴스 만들기
        guard let info = AlbumInfo(dataDic: infoDic) else {return nil}
        albumInfo = info
        
        guard let list = dataDic["songList"] as? [Dictionary<String,Any>] else {return nil}
        //for문을 통해 각 데이터를 모델로 만든후 Array에 추가
        for songDic in list
        {
            if let songData = SongData(dataDic: songDic)
            {
                songList.append(songData)
            }
        }
    }

}
/*
 - playlists: array of playlist
 - id: 플레이리스트 아이디
 - upid: 유저 플레이리스트 아이디
 - title: 플레이리스트 이름
 - main_img_url: 플레이리스트 이미지
 - thumb_img_url: 썸네일
 - song_cnt: 플레이리스트에 포함된 곡 수
 - is_premium: Y/N
 - monthly_ym: yyyyMM. 월별 모아듣기 리스트의 경우 연월 정보.
 - like_info: 좋아요 정보    // 2015-01-15
     - song: object key for song.
         - id: object key (song_id)
             - like_cnt
             - is_like: Y/N
 - up: object key for user playlist.
 - id: object key (upid)
 - like_cnt
 - is_like: Y/N
 - artist: object key for artist.
 - id: object key (artist_id)
 - like_cnt
 - is_like: Y/N
 */
struct Example
{
    
}
/*
- id: 플레이리스트 아이디
- upid: 유저 플레이리스트 아이디
- title: 플레이리스트 이름
- main_img_url: 플레이리스트 이미지
- thumb_img_url: 썸네일
- song_cnt: 플레이리스트에 포함된 곡 수
- is_premium: Y/N
- monthly_ym: yyyyMM. 월별 모아듣기 리스트의 경우 연월 정보.
*/
enum LikeType
{
    case song
    case playlist
    case artist
}

struct likeInfo
{
    var type:LikeType
    var count:Int
    var isLike:Bool
    /*
         - song: object key for song.
             - id: object key (song_id)
                 - like_cnt
                 - is_like: Y/N
 */
    init?(data:[String:Any])
    {
        if let songData = data["song"] as? [String:Any],
            let dic = songData["id"] as? [String:Any]
        {
            type = .song
            count = dic["like_cnt"] as? Int ?? 0
            if let likeKey = data["like_cnt"] as? String,
                (likeKey == "Y" || likeKey == "N")
            {
                self.isLike = likeKey == "y" ? true : false
            }else
            {
                self.isLike = false
            }
            
        }else if let playlistData = data["up"] as? [String:Any],
             let dic = playlistData["id"] as? [String:Any]
        {
            type = .playlist
            count = dic["like_cnt"] as? Int ?? 0
            
            if let likeKey = data["is_like"] as? String,
                (likeKey == "Y" || likeKey == "N")
            {
                self.isLike = likeKey == "y" ? true : false
            }else
            {
                self.isLike = false
            }
        
        }else if let artistData = data["artist"] as? [String:Any],
             let dic = artistData["id"] as? [String:Any]
        {
            type = .artist
            count = dic["like_cnt"] as? Int ?? 0
            if let likeKey = data["like_cnt"] as? String,
                (likeKey == "Y" || likeKey == "N")
            {
                self.isLike = likeKey == "y" ? true : false
            }else
            {
                self.isLike = false
            }
        
        }else
        {
            return nil
        }
    }
 
    //두번째 방법
//    init?(data:[String:Any])
//    {
//        for (key,value) in data
//        {
//            //타입 설정
//            switch key
//            {
//            case "song":
//                type = .song
//            case "up":
//                type = .playlist
//            case "artist":
//                type = .artist
//            }
//            //벗겨내기
//            guard let data  = value as? [String:Any],
//            let dic = data["id"] as? [String:Any] else {return nil}
//            //실제 데이터 가져오기
//            count = dic["like_cnt"] as? Int ?? 0
//            if let likeKey = data["like_cnt"] as? String,
//                (likeKey == "Y" || likeKey == "N")
//            {
//                self.isLike = likeKey == "y" ? true : false
//            }else
//            {
//                self.isLike = false
//            }
//        }
//    }
}

enum PlayListType
{
    case origin
    case custom
}

struct PlayList
{
    var type:PlayListType
    var id:Int
    var title:String
    var mainImgURL:String?
    var thumbImgURL:String?
    var totalSongCount:Int
    var isPremium:Bool
    var date:Date?

    init?(data:[String:Any])
    {
        if let id = data["id"] as? Int
        {
            self.type = .origin
            self.id = id
        }else if let id = data["upid"] as? Int
        {
            self.type = .custom
            self.id = id
        }else
        {
            return nil
        }
        
        guard let title = data["title"] as? String else {return nil}
        self.title = title
        
        self.mainImgURL = data["main_img_url"] as? String
        self.thumbImgURL = data["thumb_img_url"] as? String
        self.totalSongCount = data["song_cnt"] as? Int ?? 0
        
        if let premium = data["isPremium"] as? String,
            (premium == "Y" || premium == "N")
        {
            self.isPremium = premium == "y" ? true : false
        }else
        {
            self.isPremium = false
        }
        
        guard let date = data["monthly_ym"] as? Int else { return nil}
        
        let year = date/100
        let month = date%100
        let calender = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.year = year
        components.month = month
        
        self.date = calender.date(from: components)
        
        print(date)
    }
}

//
//func pListCreation() {
//    let fileManager = FileManager.default
//    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//    let path = documentDirectory.appending("/example.plist")
//    
//    if (!fileManager.fileExists(atPath: path)) {
//        let dicContent:[String: String] = ["Alabama": "Montgomery", "Alaska":"Juneau","Arizona":"Phoenix"]
//        let plistContent = NSDictionary(dictionary: dicContent)
//        let success:Bool = plistContent.write(toFile: path, atomically: true)
//        if success {
//            print("file has been created!")
//        }else{
//            print("unable to create the file")
//        }
//        
//    }else{
//        print("file already exist")
//    }
//}

