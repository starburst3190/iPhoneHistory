import SwiftUI

@main
struct iPhoneHistoryApp: App {
    init() {
        // 顏色區背景是偏暗的劇院照片，圓點用白色才看得清楚。
        UIPageControl.appearance().currentPageIndicatorTintColor = .white
        UIPageControl.appearance().pageIndicatorTintColor = .white.withAlphaComponent(0.4)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
