import Foundation

/// 偵測結果：使用者手上的裝置屬於哪一種情況。
enum DetectedDevice {
    /// 在我們的列表裡，可以點進介紹頁。
    case listed(IPhoneModel)
    /// 能執行這個 App，但不在列表裡。
    case unlisted(name: String)
    /// 太舊，裝不了 iOS 27，照理說開不了這個 App。
    case impossible(name: String)
    /// 不是 iPhone（iPad 或 Mac）。
    case notIPhone(name: String)
}

/// 讀取裝置型號代碼（例如 iPhone19,2），再對照成機型名稱。
enum DeviceDetector {
    /// 第一支能跑 iOS 27 的 iPhone 是 iPhone 11（iPhone12,1）。
    /// iPhone11,x 以前（XS、XR 及更舊）都裝不了 iOS 27。
    /// 依據：Xcode 內 iOS 27 模擬器支援的機型清單。
    static let firstSupportedMajor = 12

    static func detect() -> DetectedDevice {
        if ProcessInfo.processInfo.isiOSAppOnMac {
            return .notIPhone(name: "Mac")
        }
        let id = identifier()
        if id.hasPrefix("iPad") {
            return .notIPhone(name: "iPad")
        }
        if id.hasPrefix("iPod") {
            return .impossible(name: "iPod touch（\(id)）")
        }
        guard id.hasPrefix("iPhone") else {
            return .unlisted(name: id)
        }

        let name = names[id] ?? "iPhone（\(id)）"
        if let major = majorNumber(of: id), major < firstSupportedMajor {
            return .impossible(name: name)
        }
        if let phone = IPhoneModel.all.first(where: { $0.name == name }) {
            return .listed(phone)
        }
        return .unlisted(name: name)
    }

    /// 型號代碼。模擬器回報的是 Mac 的 CPU，要改讀模擬器提供的環境變數。
    /// Debug 版可用啟動參數 `-DeviceOverride iPhone12,1` 假裝成別的手機，方便測試。
    static func identifier() -> String {
        #if DEBUG
        if let override = UserDefaults.standard.string(forKey: "DeviceOverride") {
            return override
        }
        #endif
        if let simulated = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulated
        }
        var info = utsname()
        uname(&info)
        return withUnsafeBytes(of: &info.machine) { buffer in
            String(decoding: buffer.prefix { $0 != 0 }, as: UTF8.self)
        }
    }

    /// "iPhone19,2" → 19
    private static func majorNumber(of id: String) -> Int? {
        let digits = id.dropFirst("iPhone".count).prefix { $0.isNumber }
        return Int(digits)
    }

    /// 型號代碼對照表。名稱和列表裡的 `IPhoneModel.name` 一致時，才會連到介紹頁。
    static let names: [String: String] = [
        "iPhone1,1": "iPhone",
        "iPhone1,2": "iPhone 3G",
        "iPhone2,1": "iPhone 3GS",
        "iPhone3,1": "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
        "iPhone4,1": "iPhone 4s",
        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
        "iPhone5,3": "iPhone 5c", "iPhone5,4": "iPhone 5c",
        "iPhone6,1": "iPhone 5s", "iPhone6,2": "iPhone 5s",
        "iPhone7,1": "iPhone 6 Plus",
        "iPhone7,2": "iPhone 6",
        "iPhone8,1": "iPhone 6s",
        "iPhone8,2": "iPhone 6s Plus",
        "iPhone8,4": "iPhone SE",
        "iPhone9,1": "iPhone 7", "iPhone9,3": "iPhone 7",
        "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus",
        "iPhone10,1": "iPhone 8", "iPhone10,4": "iPhone 8",
        "iPhone10,2": "iPhone 8 Plus", "iPhone10,5": "iPhone 8 Plus",
        "iPhone10,3": "iPhone X", "iPhone10,6": "iPhone X",
        "iPhone11,2": "iPhone XS",
        "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max",
        "iPhone11,8": "iPhone XR",
        "iPhone12,1": "iPhone 11",
        "iPhone12,3": "iPhone 11 Pro",
        "iPhone12,5": "iPhone 11 Pro Max",
        "iPhone12,8": "iPhone SE（第 2 代）",
        "iPhone13,1": "iPhone 12 mini",
        "iPhone13,2": "iPhone 12",
        "iPhone13,3": "iPhone 12 Pro",
        "iPhone13,4": "iPhone 12 Pro Max",
        "iPhone14,2": "iPhone 13 Pro",
        "iPhone14,3": "iPhone 13 Pro Max",
        "iPhone14,4": "iPhone 13 mini",
        "iPhone14,5": "iPhone 13",
        "iPhone14,6": "iPhone SE（第 3 代）",
        "iPhone14,7": "iPhone 14",
        "iPhone14,8": "iPhone 14 Plus",
        "iPhone15,2": "iPhone 14 Pro",
        "iPhone15,3": "iPhone 14 Pro Max",
        "iPhone15,4": "iPhone 15",
        "iPhone15,5": "iPhone 15 Plus",
        "iPhone16,1": "iPhone 15 Pro",
        "iPhone16,2": "iPhone 15 Pro Max",
        "iPhone17,1": "iPhone 16 Pro",
        "iPhone17,2": "iPhone 16 Pro Max",
        "iPhone17,3": "iPhone 16",
        "iPhone17,4": "iPhone 16 Plus",
        "iPhone17,5": "iPhone 16e",
        "iPhone18,1": "iPhone 17 Pro",
        "iPhone18,2": "iPhone 17 Pro Max",
        "iPhone18,3": "iPhone 17",
        "iPhone18,4": "iPhone Air",
        "iPhone18,5": "iPhone 17e",
        "iPhone19,2": "iPhone 18 Pro",
        "iPhone19,3": "iPhone 18 Pro Max",
        "iPhone19,4": "iPhone Duo",
    ]
}
