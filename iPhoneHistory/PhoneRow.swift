import SwiftUI

// List 每一列：小示意圖、機型名稱、年份與一句話介紹。
struct PhoneRow: View {
    let phone: IPhoneModel

    var body: some View {
        HStack(spacing: 14) {
            PhoneSilhouette(phone: phone, finish: phone.finishes[0])
                .frame(width: 36, height: 60)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(phone.name)
                        .font(.headline)
                    Spacer()
                    Text(String(phone.year))
                        .font(.subheadline.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                Text(phone.tagline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List(IPhoneModel.all.prefix(3)) { phone in
        PhoneRow(phone: phone)
    }
}
