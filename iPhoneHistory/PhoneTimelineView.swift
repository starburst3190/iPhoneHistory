import SwiftUI

// Tab 1：最上方是使用者的手機，下面是依發表年份排列的 iPhone 年表。
struct PhoneTimelineView: View {
    let phones = IPhoneModel.all
    private let device = DeviceDetector.detect()

    var body: some View {
        NavigationStack {
            List {
                Section("你的手機") {
                    DeviceBanner(device: device)
                }
                Section("歷代 iPhone") {
                    ForEach(phones) { phone in
                        NavigationLink {
                            PhoneDetailView(phone: phone)
                        } label: {
                            PhoneRow(phone: phone)
                        }
                    }
                }
            }
            .navigationTitle("iPhone 年表")
        }
    }
}

#Preview {
    PhoneTimelineView()
}
