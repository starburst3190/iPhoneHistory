import SwiftUI

// Tab 2：依正面設計世代分組（Home 鍵、瀏海、動態島）。
struct DesignEraView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(FrontDesign.allCases) { design in
                    let phones = IPhoneModel.all.filter { $0.design == design }
                    Section {
                        ForEach(phones) { phone in
                            NavigationLink {
                                PhoneDetailView(phone: phone)
                            } label: {
                                PhoneRow(phone: phone)
                            }
                        }
                    } header: {
                        Label("\(design.rawValue)（\(phones.count) 款）", systemImage: design.symbol)
                    } footer: {
                        Text(design.summary)
                    }
                }
            }
            .navigationTitle("設計演進")
        }
    }
}

#Preview {
    DesignEraView()
}
