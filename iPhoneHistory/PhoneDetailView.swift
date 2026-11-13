import SwiftUI

// 詳細頁：上方水平滑動切換顏色，下方是規格與特色，最後可開維基百科。
struct PhoneDetailView: View {
    let phone: IPhoneModel
    @State private var selectedFinish = 0

    var body: some View {
        List {
            Section {
                TabView(selection: $selectedFinish) {
                    ForEach(Array(phone.finishes.enumerated()), id: \.element.id) { index, finish in
                        // 手機放在劇院舞台布幕的位置，顏色名稱在布幕下方。
                        GeometryReader { geo in
                            let screen = TheaterBackground.screenRect(in: geo.size)
                            PhoneSilhouette(phone: phone, finish: finish)
                                .frame(width: screen.width * 0.9, height: screen.height * 0.86)
                                .position(x: screen.midX, y: screen.midY)
                            Text(finish.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .shadow(color: .black.opacity(0.8), radius: 3)
                                .position(x: screen.midX, y: screen.maxY + 26)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 340)
                .background { TheaterBackground() }
                .listRowInsets(EdgeInsets())
            } footer: {
                VStack(spacing: 4) {
                    Text("左右滑動查看 \(phone.finishes.count) 種顏色（示意圖）")
                    Text("背景：Steve Jobs Theater，照片 Justin Ormont / CC BY 4.0")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }

            Section {
                Text(phone.tagline)
            }

            Section("規格") {
                LabeledContent("發表", value: phone.releaseDate)
                LabeledContent("晶片", value: phone.chip)
                LabeledContent("螢幕", value: phone.display)
                LabeledContent("尺寸", value: phone.size)
                LabeledContent("售價", value: phone.price)
                LabeledContent("設計世代", value: phone.design.rawValue)
            }

            Section("重點特色") {
                ForEach(phone.highlights, id: \.self) { item in
                    Label(item, systemImage: "checkmark.circle")
                }
            }

            Section {
                NavigationLink {
                    WebPageView(title: "維基百科", url: phone.wikipediaURL)
                } label: {
                    Label("在維基百科查看 \(phone.name)", systemImage: "book")
                }
            }
        }
        .navigationTitle(phone.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

// 顏色區背景：Steve Jobs Theater 劇院內部，只露出中間的舞台。
// 照片：Justin Ormont，CC BY 4.0，取自 Wikimedia Commons
// https://commons.wikimedia.org/wiki/File:Steve_Jobs_Theater_-_Auditorium.jpg
// 照片放大到讓舞台布幕在顏色區裡有固定的大小和位置，手機就畫在布幕上。
// 作者與授權標示放在下方的 footer，避免被手機或分頁圓點擋住。
struct TheaterBackground: View {
    // 照片 3480×996 px，布幕位於 x 1535–1947、y 450–682。
    private static let photoAspect: CGFloat = 3480.0 / 996.0
    private static let screenWidthInPhoto: CGFloat = 412.0 / 3480.0
    private static let screenHeightInPhoto: CGFloat = 232.0 / 996.0
    private static let screenCenterXInPhoto: CGFloat = 1741.0 / 3480.0
    private static let screenCenterYInPhoto: CGFloat = 566.0 / 996.0

    // 布幕在顏色區裡的高度比例與中心高度比例。
    private static let screenHeightInArea: CGFloat = 0.46
    private static let screenCenterYInArea: CGFloat = 0.40

    // 布幕在顏色區（大小 size）裡的位置；手機頁面和背景共用這個計算。
    static func screenRect(in size: CGSize) -> CGRect {
        let height = size.height * screenHeightInArea
        let width = height * (screenWidthInPhoto / screenHeightInPhoto) * photoAspect
        return CGRect(x: size.width / 2 - width / 2,
                      y: size.height * screenCenterYInArea - height / 2,
                      width: width, height: height)
    }

    var body: some View {
        GeometryReader { geo in
            let screen = Self.screenRect(in: geo.size)
            let photoHeight = screen.height / Self.screenHeightInPhoto
            let photoWidth = photoHeight * Self.photoAspect

            Image("SteveJobsTheater")
                .resizable()
                .frame(width: photoWidth, height: photoHeight)
                .position(x: screen.midX + (0.5 - Self.screenCenterXInPhoto) * photoWidth,
                          y: screen.midY + (0.5 - Self.screenCenterYInPhoto) * photoHeight)
                .overlay(Color.black.opacity(0.25))
                // 布幕原本播著別的照片，蓋上黑底，像 keynote 只投影產品。
                .overlay {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(white: 0.06))
                        .frame(width: screen.width, height: screen.height)
                        .position(x: screen.midX, y: screen.midY)
                }
        }
        .clipped()
            .accessibilityHidden(true)
    }
}

#Preview {
    NavigationStack {
        PhoneDetailView(phone: IPhoneModel.all[11])
    }
}
