import SwiftUI

// 正面設計世代，用來分類，也決定 PhoneSilhouette 要畫 Home 鍵、瀏海還是動態島。
enum FrontDesign: String, CaseIterable, Identifiable {
    case homeButton = "Home 鍵"
    case notch = "瀏海 Face ID"
    case dynamicIsland = "動態島"
    case foldable = "摺疊螢幕"

    var id: Self { self }

    var symbol: String {
        switch self {
        case .homeButton: "circle.circle"
        case .notch: "faceid"
        case .dynamicIsland: "capsule.fill"
        case .foldable: "rectangle.split.2x1"
        }
    }

    var summary: String {
        switch self {
        case .homeButton: "2007–2017：螢幕下方有實體或壓感 Home 鍵，2013 年起整合 Touch ID。"
        case .notch: "2017–2022：取消 Home 鍵，螢幕上方的瀏海放 Face ID 相機。"
        case .dynamicIsland: "2022 至今：瀏海改成可以顯示通知與活動的動態島。"
        case .foldable: "2026 至今：可以左右打開的摺疊 iPhone，內外兩個螢幕都有動態島。"
        }
    }
}

// 機身顏色，在詳細頁用水平滑動的分頁逐一顯示。
struct Finish: Identifiable {
    let id = UUID()
    let name: String
    let hex: UInt32

    var color: Color {
        Color(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

struct IPhoneModel: Identifiable {
    let id = UUID()
    let name: String
    let year: Int
    let releaseDate: String
    let chip: String
    let display: String
    let size: String
    let heightMM: Double
    let widthMM: Double
    let price: String
    let design: FrontDesign
    let tagline: String
    let highlights: [String]
    let finishes: [Finish]

    // 用機型名稱搜尋中文維基百科，避免條目名稱不一致造成 404。
    var wikipediaURL: URL {
        var components = URLComponents(string: "https://zh.wikipedia.org/w/index.php")!
        components.queryItems = [URLQueryItem(name: "search", value: name)]
        return components.url!
    }
}

extension IPhoneModel {
    // 代表機型，依發表時間排序。規格為美國發表時的資料。
    static let all: [IPhoneModel] = [
        IPhoneModel(
            name: "iPhone", year: 2007, releaseDate: "2007 年 6 月",
            chip: "Samsung ARM11 412 MHz", display: "3.5 吋", size: "115 × 61 × 11.6 mm",
            heightMM: 115, widthMM: 61, price: "US$499 起", design: .homeButton,
            tagline: "把 iPod、手機和網路裝置合在一起的第一代。",
            highlights: ["多點觸控螢幕", "完整網頁的 Safari", "視覺化語音信箱", "沒有 App Store，只有內建 App"],
            finishes: [Finish(name: "鋁金屬銀", hex: 0xC8CACC)]
        ),
        IPhoneModel(
            name: "iPhone 3G", year: 2008, releaseDate: "2008 年 7 月",
            chip: "Samsung ARM11 412 MHz", display: "3.5 吋", size: "115.5 × 62.1 × 12.3 mm",
            heightMM: 115.5, widthMM: 62.1, price: "US$199 起（兩年合約）", design: .homeButton,
            tagline: "App Store 隨 iPhone OS 2 一起推出。",
            highlights: ["App Store", "3G 網路", "內建 GPS", "塑膠背蓋"],
            finishes: [Finish(name: "黑色", hex: 0x1C1C1E), Finish(name: "白色", hex: 0xF2F2F2)]
        ),
        IPhoneModel(
            name: "iPhone 4", year: 2010, releaseDate: "2010 年 6 月",
            chip: "Apple A4", display: "3.5 吋 Retina", size: "115.2 × 58.6 × 9.3 mm",
            heightMM: 115.2, widthMM: 58.6, price: "US$199 起（兩年合約）", design: .homeButton,
            tagline: "玻璃前後蓋加不鏽鋼邊框，第一支 Retina 螢幕。",
            highlights: ["Retina 顯示器", "FaceTime 視訊", "前鏡頭", "第一顆 Apple 自家晶片 A4"],
            finishes: [Finish(name: "黑色", hex: 0x1C1C1E), Finish(name: "白色", hex: 0xF2F2F2)]
        ),
        IPhoneModel(
            name: "iPhone 4s", year: 2011, releaseDate: "2011 年 10 月",
            chip: "Apple A5", display: "3.5 吋 Retina", size: "115.2 × 58.6 × 9.3 mm",
            heightMM: 115.2, widthMM: 58.6, price: "US$199 起（兩年合約）", design: .homeButton,
            tagline: "Siri 第一次出現。",
            highlights: ["Siri 語音助理", "800 萬畫素相機", "1080p 錄影", "雙核心 A5"],
            finishes: [Finish(name: "黑色", hex: 0x1C1C1E), Finish(name: "白色", hex: 0xF2F2F2)]
        ),
        IPhoneModel(
            name: "iPhone 5", year: 2012, releaseDate: "2012 年 9 月",
            chip: "Apple A6", display: "4 吋 Retina", size: "123.8 × 58.6 × 7.6 mm",
            heightMM: 123.8, widthMM: 58.6, price: "US$199 起（兩年合約）", design: .homeButton,
            tagline: "螢幕第一次變大，改用 Lightning 接頭。",
            highlights: ["4 吋 16:9 螢幕", "Lightning 接頭", "LTE 網路", "鋁合金一體機身"],
            finishes: [Finish(name: "黑色與石板色", hex: 0x2C2C2E), Finish(name: "白色與銀色", hex: 0xE5E5EA)]
        ),
        IPhoneModel(
            name: "iPhone 5s", year: 2013, releaseDate: "2013 年 9 月",
            chip: "Apple A7", display: "4 吋 Retina", size: "123.8 × 58.6 × 7.6 mm",
            heightMM: 123.8, widthMM: 58.6, price: "US$199 起（兩年合約）", design: .homeButton,
            tagline: "Touch ID 指紋辨識和 64 位元晶片。",
            highlights: ["Touch ID", "第一顆 64 位元手機晶片 A7", "M7 動態協同處理器", "金色機身首次推出"],
            finishes: [Finish(name: "太空灰", hex: 0x4A4A4C), Finish(name: "銀色", hex: 0xE3E4E5), Finish(name: "金色", hex: 0xE6D3B3)]
        ),
        IPhoneModel(
            name: "iPhone 6", year: 2014, releaseDate: "2014 年 9 月",
            chip: "Apple A8", display: "4.7 吋 Retina HD", size: "138.1 × 67.0 × 6.9 mm",
            heightMM: 138.1, widthMM: 67.0, price: "US$199 起（兩年合約）", design: .homeButton,
            tagline: "大螢幕和圓弧邊框，同時推出 5.5 吋的 Plus。",
            highlights: ["4.7 吋螢幕", "Apple Pay（NFC）", "圓弧鋁合金機身", "第一次有 Plus 尺寸"],
            finishes: [Finish(name: "太空灰", hex: 0x4A4A4C), Finish(name: "銀色", hex: 0xE3E4E5), Finish(name: "金色", hex: 0xE6D3B3)]
        ),
        IPhoneModel(
            name: "iPhone 6s", year: 2015, releaseDate: "2015 年 9 月",
            chip: "Apple A9", display: "4.7 吋 Retina HD", size: "138.3 × 67.1 × 7.1 mm",
            heightMM: 138.3, widthMM: 67.1, price: "US$649 起", design: .homeButton,
            tagline: "3D Touch 和原況照片。",
            highlights: ["3D Touch 壓力感應", "原況照片 Live Photos", "1200 萬畫素相機", "7000 系列鋁合金"],
            finishes: [Finish(name: "太空灰", hex: 0x4A4A4C), Finish(name: "銀色", hex: 0xE3E4E5), Finish(name: "金色", hex: 0xE6D3B3), Finish(name: "玫瑰金", hex: 0xE8C4BC)]
        ),
        IPhoneModel(
            name: "iPhone SE", year: 2016, releaseDate: "2016 年 3 月",
            chip: "Apple A9", display: "4 吋 Retina", size: "123.8 × 58.6 × 7.6 mm",
            heightMM: 123.8, widthMM: 58.6, price: "US$399 起", design: .homeButton,
            tagline: "iPhone 5s 外型，裝進 6s 的晶片。",
            highlights: ["4 吋小螢幕", "A9 晶片", "較低售價", "支援 Apple Pay"],
            finishes: [Finish(name: "太空灰", hex: 0x4A4A4C), Finish(name: "銀色", hex: 0xE3E4E5), Finish(name: "金色", hex: 0xE6D3B3), Finish(name: "玫瑰金", hex: 0xE8C4BC)]
        ),
        IPhoneModel(
            name: "iPhone 7", year: 2016, releaseDate: "2016 年 9 月",
            chip: "Apple A10 Fusion", display: "4.7 吋 Retina HD", size: "138.3 × 67.1 × 7.1 mm",
            heightMM: 138.3, widthMM: 67.1, price: "US$649 起", design: .homeButton,
            tagline: "拿掉 3.5 mm 耳機孔，Home 鍵改成壓感式。",
            highlights: ["取消耳機孔", "IP67 防潑抗水", "壓感式 Home 鍵", "立體聲喇叭"],
            finishes: [Finish(name: "曜石黑", hex: 0x0B0B0D), Finish(name: "霧面黑", hex: 0x2B2B2D), Finish(name: "銀色", hex: 0xE3E4E5), Finish(name: "金色", hex: 0xE6D3B3), Finish(name: "玫瑰金", hex: 0xE8C4BC)]
        ),
        IPhoneModel(
            name: "iPhone 8", year: 2017, releaseDate: "2017 年 9 月",
            chip: "Apple A11 Bionic", display: "4.7 吋 Retina HD", size: "138.4 × 67.3 × 7.3 mm",
            heightMM: 138.4, widthMM: 67.3, price: "US$699 起", design: .homeButton,
            tagline: "玻璃背蓋回歸，支援無線充電。",
            highlights: ["Qi 無線充電", "玻璃背蓋", "True Tone 顯示器", "A11 Bionic"],
            finishes: [Finish(name: "太空灰", hex: 0x4A4A4C), Finish(name: "銀色", hex: 0xE3E4E5), Finish(name: "金色", hex: 0xE6D3B3)]
        ),
        IPhoneModel(
            name: "iPhone X", year: 2017, releaseDate: "2017 年 11 月",
            chip: "Apple A11 Bionic", display: "5.8 吋 Super Retina OLED", size: "143.6 × 70.9 × 7.7 mm",
            heightMM: 143.6, widthMM: 70.9, price: "US$999 起", design: .notch,
            tagline: "全螢幕設計，Face ID 取代 Home 鍵。",
            highlights: ["Face ID", "OLED 全螢幕", "手勢操作取代 Home 鍵", "不鏽鋼邊框"],
            finishes: [Finish(name: "太空灰", hex: 0x4A4A4C), Finish(name: "銀色", hex: 0xE3E4E5)]
        ),
        IPhoneModel(
            name: "iPhone XR", year: 2018, releaseDate: "2018 年 10 月",
            chip: "Apple A12 Bionic", display: "6.1 吋 Liquid Retina LCD", size: "150.9 × 75.7 × 8.3 mm",
            heightMM: 150.9, widthMM: 75.7, price: "US$749 起", design: .notch,
            tagline: "較便宜的全螢幕 iPhone，顏色選擇多。",
            highlights: ["6.1 吋 LCD", "六種顏色", "單鏡頭人像模式", "A12 Bionic"],
            finishes: [Finish(name: "黑色", hex: 0x1C1C1E), Finish(name: "白色", hex: 0xF2F2F2), Finish(name: "藍色", hex: 0x5EB0E5), Finish(name: "黃色", hex: 0xF9D045), Finish(name: "珊瑚色", hex: 0xEE7762), Finish(name: "(PRODUCT)RED", hex: 0xBA0C2E)]
        ),
        IPhoneModel(
            name: "iPhone 11", year: 2019, releaseDate: "2019 年 9 月",
            chip: "Apple A13 Bionic", display: "6.1 吋 Liquid Retina LCD", size: "150.9 × 75.7 × 8.3 mm",
            heightMM: 150.9, widthMM: 75.7, price: "US$699 起", design: .notch,
            tagline: "加入超廣角鏡頭和夜間模式。",
            highlights: ["超廣角鏡頭", "夜間模式", "U1 超寬頻晶片", "售價比 XR 低"],
            finishes: [Finish(name: "黑色", hex: 0x1C1C1E), Finish(name: "白色", hex: 0xF2F2F2), Finish(name: "綠色", hex: 0xAEE1CD), Finish(name: "黃色", hex: 0xFFE681), Finish(name: "紫色", hex: 0xD1CDDA), Finish(name: "(PRODUCT)RED", hex: 0xBA0C2E)]
        ),
        IPhoneModel(
            name: "iPhone 12", year: 2020, releaseDate: "2020 年 10 月",
            chip: "Apple A14 Bionic", display: "6.1 吋 Super Retina XDR", size: "146.7 × 71.5 × 7.4 mm",
            heightMM: 146.7, widthMM: 71.5, price: "US$799 起", design: .notch,
            tagline: "回到直角邊框，支援 5G 和 MagSafe。",
            highlights: ["5G 網路", "MagSafe 磁吸", "Ceramic Shield 玻璃", "同時推出 5.4 吋 mini"],
            finishes: [Finish(name: "黑色", hex: 0x1C1C1E), Finish(name: "白色", hex: 0xF2F2F2), Finish(name: "藍色", hex: 0x1F4A6E), Finish(name: "綠色", hex: 0xD8EFD5), Finish(name: "(PRODUCT)RED", hex: 0xBA0C2E), Finish(name: "紫色", hex: 0xB7AFE6)]
        ),
        IPhoneModel(
            name: "iPhone 13 Pro", year: 2021, releaseDate: "2021 年 9 月",
            chip: "Apple A15 Bionic", display: "6.1 吋 ProMotion XDR", size: "146.7 × 71.5 × 7.65 mm",
            heightMM: 146.7, widthMM: 71.5, price: "US$999 起", design: .notch,
            tagline: "120 Hz ProMotion 螢幕，瀏海變小。",
            highlights: ["ProMotion 120 Hz", "電影級模式", "微距攝影", "瀏海縮小 20%"],
            finishes: [Finish(name: "石墨色", hex: 0x54524F), Finish(name: "金色", hex: 0xF4E8CE), Finish(name: "銀色", hex: 0xF1F2ED), Finish(name: "天峰藍", hex: 0xA7C1D9), Finish(name: "松嶺綠", hex: 0x576856)]
        ),
        IPhoneModel(
            name: "iPhone 14 Pro", year: 2022, releaseDate: "2022 年 9 月",
            chip: "Apple A16 Bionic", display: "6.1 吋 ProMotion XDR", size: "147.5 × 71.5 × 7.85 mm",
            heightMM: 147.5, widthMM: 71.5, price: "US$999 起", design: .dynamicIsland,
            tagline: "動態島取代瀏海，螢幕可以常亮。",
            highlights: ["動態島", "全天候顯示", "4800 萬畫素主相機", "車禍偵測"],
            finishes: [Finish(name: "太空黑", hex: 0x403E3D), Finish(name: "銀色", hex: 0xF0F2F2), Finish(name: "金色", hex: 0xF4E8CE), Finish(name: "暗紫色", hex: 0x594F63)]
        ),
        IPhoneModel(
            name: "iPhone 15 Pro", year: 2023, releaseDate: "2023 年 9 月",
            chip: "Apple A17 Pro", display: "6.1 吋 ProMotion XDR", size: "146.6 × 70.6 × 8.25 mm",
            heightMM: 146.6, widthMM: 70.6, price: "US$999 起", design: .dynamicIsland,
            tagline: "鈦金屬機身，Lightning 換成 USB‑C。",
            highlights: ["鈦金屬邊框", "USB‑C（USB 3）", "動作按鈕取代靜音開關", "3 奈米 A17 Pro"],
            finishes: [Finish(name: "原色鈦金屬", hex: 0xBAB4A9), Finish(name: "藍色鈦金屬", hex: 0x3F4655), Finish(name: "白色鈦金屬", hex: 0xF2F1ED), Finish(name: "黑色鈦金屬", hex: 0x3B3B3D)]
        ),
        IPhoneModel(
            name: "iPhone 16", year: 2024, releaseDate: "2024 年 9 月",
            chip: "Apple A18", display: "6.1 吋 Super Retina XDR", size: "147.6 × 71.6 × 7.8 mm",
            heightMM: 147.6, widthMM: 71.6, price: "US$799 起", design: .dynamicIsland,
            tagline: "相機控制按鈕，支援 Apple Intelligence。",
            highlights: ["相機控制按鈕", "Apple Intelligence", "動作按鈕下放到標準版", "直排雙鏡頭可拍空間影片"],
            finishes: [Finish(name: "黑色", hex: 0x3C4042), Finish(name: "白色", hex: 0xFAFAFA), Finish(name: "粉紅色", hex: 0xF2ADDA), Finish(name: "青綠色", hex: 0xB0D4D2), Finish(name: "群青色", hex: 0x9AADF6)]
        ),
        IPhoneModel(
            name: "iPhone Air", year: 2025, releaseDate: "2025 年 9 月",
            chip: "Apple A19 Pro", display: "6.5 吋 ProMotion XDR", size: "156.2 × 74.7 × 5.64 mm",
            heightMM: 156.2, widthMM: 74.7, price: "US$999 起", design: .dynamicIsland,
            tagline: "5.6 mm 厚，推出時最薄的 iPhone（後來被 iPhone Duo 超越了）。",
            highlights: ["5.6 mm 機身", "鈦金屬邊框", "只支援 eSIM", "單顆 4800 萬畫素相機"],
            finishes: [Finish(name: "太空黑", hex: 0x2E2E30), Finish(name: "雲白色", hex: 0xF5F5F0), Finish(name: "淺金色", hex: 0xEADFC8), Finish(name: "天藍色", hex: 0xC8DCEB)]
        ),
        IPhoneModel(
            name: "iPhone 17 Pro", year: 2025, releaseDate: "2025 年 9 月",
            chip: "Apple A19 Pro", display: "6.3 吋 ProMotion XDR", size: "150.0 × 71.9 × 8.75 mm",
            heightMM: 150.0, widthMM: 71.9, price: "US$1,099 起", design: .dynamicIsland,
            tagline: "改回鋁合金一體機身，加入均熱板散熱。",
            highlights: ["鋁合金一體成形", "均熱板散熱", "三顆 4800 萬畫素鏡頭", "橫向相機平台"],
            finishes: [Finish(name: "宇宙橙", hex: 0xE3803A), Finish(name: "深藍色", hex: 0x2F3A52), Finish(name: "銀色", hex: 0xE8E8E6)]
        ),
        IPhoneModel(
            name: "iPhone 18 Pro", year: 2026, releaseDate: "2026 年 9 月",
            chip: "Apple A20 Pro", display: "6.3 吋 ProMotion XDR", size: "150.0 × 71.9 × 8.75 mm",
            heightMM: 150.0, widthMM: 71.9, price: "US$1,199 起", design: .dynamicIsland,
            tagline: "外觀延續 17 Pro，動態島縮小。",
            highlights: ["動態島縮小", "2 奈米 A20 Pro", "主相機可變光圈", "8 倍光學品質變焦"],
            finishes: [Finish(name: "黑色", hex: 0x2B2B2D), Finish(name: "銀色", hex: 0xE8E8E6), Finish(name: "冰川藍色", hex: 0xC9DCE6), Finish(name: "勃根地紅色", hex: 0x6B2433)]
        ),
        IPhoneModel(
            name: "iPhone Duo", year: 2026, releaseDate: "2026 年 10 月",
            chip: "Apple A20 Pro", display: "7.6 吋內螢幕＋5.4 吋外螢幕", size: "打開 164.6 × 117.8 × 5.2 mm／闔起 84.1 × 117.8 × 11.3 mm",
            heightMM: 117.8, widthMM: 164.6, price: "US$1,999 起", design: .foldable,
            tagline: "第一支摺疊 iPhone，打開是 7.6 吋螢幕。",
            highlights: ["鈦金屬可摺疊設計", "內外螢幕都有動態島", "側邊按鈕 Touch ID", "內螢幕支援 Apple Pencil (USB‑C)"],
            finishes: [Finish(name: "夜空色", hex: 0x232838), Finish(name: "星光白色", hex: 0xF1EFEA)]
        ),
    ]
}
