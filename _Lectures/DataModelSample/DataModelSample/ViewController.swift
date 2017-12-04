//
//  ViewController.swift
//  DataModelSample
//
//  Created by youngmin joo on 2017. 10. 15..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit





class ViewController: UIViewController {
    
    @IBOutlet var titleLB:UILabel!
    @IBOutlet var artistLB:UILabel!
    @IBOutlet var genreLB:UILabel!
    
    //유저 모델
    var userData:UserModel?
    func createUserDataToModel()
    {
        //데이터는 하단 참조
        self.userData = UserModel(dataDic: userDic)
    }
    
    //전시회 모델
    var exhibits:[Exhibition] = []
    func createExhibitDataToModel()
    {
        //데이터는 하단 참조
        for dic in exhibitData
        {
            self.exhibits.append(Exhibition(data: dic)!)
        }
    }
    

    //MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let model = AlbumModel(dataDic: album)
//        {
//            print(model)
//        }
     
        
        if let path =  Bundle.main.path(forResource: "UserPlist", ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: path) as? [String:Any]
        {
            
            let userDataModel = UserModel(dataDic: dic)
            
            
        }
        
        
        
    }

}


//유저 샘플 데이터
let userDic:Dictionary<String,Any> =
    ["userID":"joo",
     "userPw":"12345!@",
     "email":"knightjym@gmail.com",
     "birthDay":"2017/10/15",
     "gender":1
]

//전시회 데이터
let exhibitData = [["imageURL":"http://ticketimage.interpark.com/Play/image/small/17/17010729.gif",
                    "title":"경복궁 야간 특별관람",
                    "place":"경복궁",
                    "startDate":"2017년 08월 13",
                    "endDate":"2017.09.02"
    ],["imageURL":"http://ticketimage.interpark.com/Play/image/small/17/17010729.gif",
       "title":"경복궁 야간 특별관람",
       "place":"경복궁",
       "startDate":"2017년 08월 13",
       "endDate":"2017.09.02"
    ],
      ["imageURL":"http://ticketimage.interpark.com/Play/image/small/17/17010729.gif",
       "title":"경복궁 야간 특별관람",
       "place":"경복궁",
       "startDate":"2017년 08월 13",
       "endDate":"2017.09.02"
    ]]

let album:Dictionary<String,Any> =
    ["albumInfo":["albumTitle":"2집 Oh!",
                  "artist":"소녀시대",
                  "genre":"댄스"],
     "songList":[["songTitle":"Oh!",
                  "trackNum":1,
                  "artist":"소녀시대",
                  "writer":"김정배",
                  "playTime":12340,
                  "playURL":"http://music.naver.com/123"],
                 ["songTitle":"Show! Show! Show!",
                  "trackNum":2,
                  "artist":"소녀시대",
                  "writer":"김부민",
                  "playTime":10130,
                  "playURL":"http://music.naver.com/124"],
                 ["songTitle":"웃자 (Be Happy)",
                  "trackNum":4,
                  "artist":"소녀시대",
                  "writer":"이트라이브",
                  "playTime":12134,
                  "playURL":"http://music.naver.com/126"]
        ]
]
