import SwiftUI

// 年表最上方：顯示偵測到的手機。在列表裡的機型可以點進介紹頁。
struct DeviceBanner: View {
    let device: DetectedDevice

    var body: some View {
        switch device {
        case .listed(let phone):
            NavigationLink {
                PhoneDetailView(phone: phone)
            } label: {
                HStack(spacing: 14) {
                    PhoneSilhouette(phone: phone, finish: phone.finishes[0])
                        .frame(width: 36, height: 60)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("你正在使用")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(phone.name)
                            .font(.title3.bold())
                        Text("點一下看它的介紹")
                            .font(.footnote)
                            .foregroundStyle(.tint)
                    }
                }
                .padding(.vertical, 4)
            }

        case .unlisted(let name):
            message(symbol: "iphone", title: "你正在使用 \(name)",
                    detail: "很可惜你的手機沒有被列在裡面，但這不代表它不存在。")

        case .impossible(let name):
            message(symbol: "questionmark.circle", title: "偵測到 \(name)",
                    detail: "你是怎麼開啟這個App的？")

        case .notIPhone(let name):
            message(symbol: "ipad.landscape", title: "你正在使用 \(name)",
                    detail: "這台不是 iPhone，下面的年表還是可以慢慢看。")
        }
    }

    private func message(symbol: String, title: String, detail: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: symbol)
                .font(.title)
                .foregroundStyle(.tint)
                .frame(width: 36)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        List {
            DeviceBanner(device: .listed(IPhoneModel.all.last!))
            DeviceBanner(device: .unlisted(name: "iPhone 15"))
            DeviceBanner(device: .impossible(name: "iPhone 4s"))
            DeviceBanner(device: .notIPhone(name: "iPad"))
        }
    }
}
