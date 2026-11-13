import SwiftUI
import WebKit

// 顯示網頁的頁面：標題列固定不透明，網頁只在標題列下方捲動。
struct WebPageView: View {
    let title: String
    let url: URL

    var body: some View {
        WKWebViewContainer(url: url)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            // 網頁多半是白底，透明導覽列會讓深色模式的白色標題看不見；
            // 改成不透明的系統底色，網頁從標題列下緣開始顯示。
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    }
}

// 用 UIViewRepresentable 包住 WKWebView。
// iOS 26 的 SwiftUI 原生 WebView 在不透明導覽列下會把網頁最上方藏起來，
// WKWebView 則會從自己的框架頂端開始顯示網頁。
struct WKWebViewContainer: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}

#Preview {
    NavigationStack {
        WebPageView(title: "Apple", url: URL(string: "https://www.apple.com/tw/iphone/")!)
    }
}
