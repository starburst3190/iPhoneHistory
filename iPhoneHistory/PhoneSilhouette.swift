import SwiftUI

// 用 SwiftUI 形狀畫出的手機正面示意圖，比例取自真實機身長寬。
struct PhoneSilhouette: View {
    let phone: IPhoneModel
    let finish: Finish

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let corner = min(w, h) * cornerFactor
            let inset = screenInsets(w: w, h: h)

            ZStack {
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(finish.color)
                    .overlay(
                        RoundedRectangle(cornerRadius: corner, style: .continuous)
                            .stroke(.black.opacity(0.25), lineWidth: 1)
                    )

                screen(w: w, h: h, corner: corner, inset: inset)

                if phone.design == .homeButton {
                    Circle()
                        .stroke(.black.opacity(0.35), lineWidth: max(1, w * 0.012))
                        .frame(width: w * 0.17, height: w * 0.17)
                        .position(x: w / 2, y: h - inset.bottom / 2)
                }
            }
        }
        .aspectRatio(phone.widthMM / phone.heightMM, contentMode: .fit)
        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
        .accessibilityLabel("\(phone.name) \(finish.name)")
    }

    private var cornerFactor: CGFloat {
        switch phone.design {
        case .homeButton: phone.year < 2014 ? 0.13 : 0.16
        case .notch, .dynamicIsland: 0.17
        case .foldable: 0.12
        }
    }

    private func screenInsets(w: CGFloat, h: CGFloat) -> EdgeInsets {
        switch phone.design {
        case .homeButton:
            return EdgeInsets(top: h * 0.13, leading: w * 0.07, bottom: h * 0.13, trailing: w * 0.07)
        case .notch, .dynamicIsland, .foldable:
            let b = min(w, h) * 0.04
            return EdgeInsets(top: b, leading: b, bottom: b, trailing: b)
        }
    }

    @ViewBuilder
    private func screen(w: CGFloat, h: CGFloat, corner: CGFloat, inset: EdgeInsets) -> some View {
        let screenW = w - inset.leading - inset.trailing
        let screenH = h - inset.top - inset.bottom
        let screenCorner = phone.design == .homeButton ? w * 0.01 : corner - inset.leading

        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: screenCorner, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.25, green: 0.30, blue: 0.75), Color(red: 0.15, green: 0.65, blue: 0.75)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )

            switch phone.design {
            case .homeButton:
                EmptyView()
            case .notch:
                // iPhone 13 Pro（2021）起瀏海縮窄約兩成。
                UnevenRoundedRectangle(bottomLeadingRadius: w * 0.05, bottomTrailingRadius: w * 0.05)
                    .fill(.black)
                    .frame(width: screenW * (phone.year >= 2021 ? 0.4 : 0.5), height: screenH * 0.035)
            case .dynamicIsland:
                // iPhone 18 Pro 的動態島比前幾代更窄。
                Capsule()
                    .fill(.black)
                    .frame(width: screenW * (phone.year >= 2026 ? 0.2 : 0.27), height: screenH * 0.028)
                    .padding(.top, screenH * 0.015)
            case .foldable:
                // 打開狀態：中間是摺痕。內螢幕用螢幕下鏡頭，沒有挖孔，
                // 只在右半邊上方畫一個很淡的圓點表示鏡頭位置。
                Rectangle()
                    .fill(.white.opacity(0.35))
                    .frame(width: max(1, w * 0.006), height: screenH)
                Circle()
                    .fill(.black.opacity(0.18))
                    .frame(width: screenH * 0.035, height: screenH * 0.035)
                    .padding(.top, screenH * 0.035)
                    .offset(x: screenW * 0.25)
            }
        }
        .frame(width: screenW, height: screenH)
        .position(x: inset.leading + screenW / 2, y: inset.top + screenH / 2)
    }
}

#Preview {
    HStack(alignment: .bottom, spacing: 20) {
        ForEach([IPhoneModel.all[0], IPhoneModel.all[11], IPhoneModel.all.last!]) { phone in
            PhoneSilhouette(phone: phone, finish: phone.finishes[0])
                .frame(height: 220)
        }
    }
    .padding()
}
