import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("年表", systemImage: "list.bullet.rectangle") {
                PhoneTimelineView()
            }
            Tab("設計演進", systemImage: "iphone.gen3") {
                DesignEraView()
            }
            Tab("Apple 官網", systemImage: "safari") {
                NavigationStack {
                    WebPageView(title: "Apple 官網", url: URL(string: "https://www.apple.com/tw/iphone/")!)
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
