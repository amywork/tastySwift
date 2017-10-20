// Singleton DataCenter Object Class

import Foundation
class DataCenter {
    
    static var mainCenter: DataCenter = DataCenter()
    var userModel: Users?
    var settingDataList:[SettingDataModel] = []
    var documentDirectory: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    private init() {
        // plist -> Data Model
     loadSettingData()
    }

    
    func loadSettingData() {
        guard let settingPath = Bundle.main.path(forResource: "Settings", ofType: "plist") else { return }
        guard let settingDataArr = NSArray(contentsOfFile: settingPath) as? [[String:Any]] else { return }
        print(settingDataArr)
        for settingDataDic in settingDataArr {
            print(settingDataDic)
            self.settingDataList.append(SettingDataModel(with: settingDataDic))
        }
    }
    
    
    func loadData() {
        // documentDirectory plist까지의 경로
        let userDataURL = documentDirectory.appendingPathComponent("UserData.plist")
        let settingDataURL = documentDirectory.appendingPathComponent("Settings.plist")
        let userDataPath = userDataURL.path
        let settingDataPath = settingDataURL.path
        
        // Bundle -> Document 로의 plist 파일 복사
        if !FileManager.default.fileExists(atPath: userDataPath) {
            guard let plistURL = Bundle.main.url(forResource: "UserData", withExtension: "plist") else { return }
            try! FileManager.default.copyItem(at: plistURL, to: userDataURL)
        }
        
        if !FileManager.default.fileExists(atPath: settingDataPath) {
            guard let plistURL = Bundle.main.url(forResource: "Settings", withExtension: "plist") else { return }
            try! FileManager.default.copyItem(at: plistURL, to: settingDataURL)
        }
        
        // Userdata Load
        let propertyDecoder = PropertyListDecoder()
        let data = try! Data(contentsOf: userDataURL)
        self.userModel = try! propertyDecoder.decode(Users.self, from: data)
        
        // SettingData Load
        guard let settingDataArr = NSArray(contentsOf: settingDataURL) as? [[String:Any]] else { return }
        for settingDataDic in settingDataArr {
            self.settingDataList.append(SettingDataModel(with: settingDataDic))
        }
        
    }
    
    func validateUserInfo(username:String, password: String) -> Bool {
        if let model = self.userModel {
            for user in model.users {
                if user.username == username && user.password == password {
                    return true
                }
            }
        }
        return false
    }
    
}
