//
//  ContentView.swift
//  IdentityPinningTest
//
//  Created by Jolanta Zakrzewska on 10/08/2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    @State private var userSettingStatusText = "No data yet"
    @State private var imageStatusText = "No image data yet"
    @State private var jsonStatusText = "No json data yet"
    @State private var alamofireJsonStatusText = "No json data yet"

    @State private var showWebView = false

    var body: some View {
        NavigationView {
            List {
                Text("User-defined settings")
                    .font(.title2)

                Text(userSettingStatusText)
                    .padding()

                Text("URLSession")
                    .font(.title2)

                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                } else {
                    Text(imageStatusText)
                        .padding()
                }

                Text("Alamofire")
                    .font(.title2)

                if let json = viewModel.json {
                    Text(json)
                        .padding()
                } else {
                    Text(jsonStatusText)
                        .padding()
                }

                Text("Kingfisher")
                    .font(.title2)

                KFImage(URL(string: viewModel.imageApi))
                    .fromMemoryCacheOrRefresh(true) // don't use cache
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)

                Text("WKWebView")
                    .font(.title2)

                Button {
                    showWebView.toggle()
                } label: {
                    Text("open webview")
                }
                .sheet(isPresented: $showWebView) {
                    if let url = URL(string: viewModel.jsonApi) {
                        WebView(url: url)
                    } else {
                        EmptyView()
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Hello, Identity Pinning!")
        }
        .onAppear {
            viewModel.loadImageWithURLSession { success, error in
                imageStatusText = success ? "Processing..." : error?.localizedDescription ?? ""
            }
            viewModel.loadJsonWithAlamofire { success, error in
                jsonStatusText = success ? "Processing..." : error?.localizedDescription ?? ""
            }

            if let setting = Bundle.main.object(forInfoDictionaryKey: "NEW_SETTING") as? String {
                userSettingStatusText = setting
            } else {
                userSettingStatusText = "Setting was not found"
            }
        }
    }
}
