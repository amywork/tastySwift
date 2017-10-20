// Singleton DataCenter Object Class

import Foundation
class DataCenter {
    
    static var mainCenter: DataCenter = DataCenter()

    var currentUser: UserModel?
    var settingDataList:[SettingDataModel] = []
    var exploreDataList:[ExploreDataModel] = []
    var documentDirectory: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    private init() {
        // plist -> Data Model
        loadSettingData()
        loadExploreData()
        loadUserData()
    }
    
    
    func loadUserData() {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/CurrentUser.plist"
        guard let documentDic = NSDictionary(contentsOfFile: documentPath) as? [String:Any] else { return }
        currentUser = UserModel(userDic: documentDic)
    }
    
    func writeUserData() -> Bool {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/CurrentUser.plist"
        guard let data = currentUser else { return false }
        let newDic = data.dictionary
        let NSDic = NSDictionary(dictionary: newDic)
        NSDic.write(toFile: documentPath, atomically: true)
        return true
    }
    
    func validateUserInfo(username:String, password: String) -> Bool {
        if let model = self.currentUser {
            if model.userID == username && model.userPWD == password {
                return true
            }
        }
        return false
    }
    
    func object(forkey: String) -> Any? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/CurrentUser.plist"
        guard let documentDic = NSDictionary(contentsOfFile: documentPath) as? [String:Any] else { return nil }
        return documentDic[forkey]
    }
    
    
    func loadSettingData() {
        let settingDataURL = documentDirectory.appendingPathComponent("Settings.plist")
        let settingDataPath = settingDataURL.path
        
        if !FileManager.default.fileExists(atPath: settingDataPath) {
            guard let plistURL = Bundle.main.url(forResource: "Settings", withExtension: "plist") else { return }
            try! FileManager.default.copyItem(at: plistURL, to: settingDataURL)
        }
        
        guard let settingDataArr = NSArray(contentsOf: settingDataURL) as? [[String:Any]] else { return }
        for settingDataDic in settingDataArr {
            print(settingDataDic)
            self.settingDataList.append(SettingDataModel(with: settingDataDic))
        }
        print(settingDataList)
    }
    
    
    func loadExploreData() {
        let exploreDataURL = documentDirectory.appendingPathComponent("ExploreData.plist")
        let exploreDataPath = exploreDataURL.path
        
        if !FileManager.default.fileExists(atPath: exploreDataPath) {
            guard let plistURL = Bundle.main.url(forResource: "ExploreData", withExtension: "plist") else { return }
            try! FileManager.default.copyItem(at: plistURL, to: exploreDataURL)
        }
        
        guard let dataArr = NSArray(contentsOf: exploreDataURL) as? [[String:String]] else { return }
        for dataDic in dataArr {
            guard let data = ExploreDataModel(with: dataDic) else { return }
            self.exploreDataList.append(data)
        }
    }
    
}
