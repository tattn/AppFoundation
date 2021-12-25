//
//  WebView.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/11/12.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: .init(string: "https://google.com")!)
    }
}
