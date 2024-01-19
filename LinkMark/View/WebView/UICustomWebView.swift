//
//  UIWebView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import UIKit
import SwiftUI
import WebKit

// WebViewを表示するためのUikitView
struct UICustomWebView: UIViewRepresentable {
    
    private var webView: WKWebView
    public var url: URL
    
    init(url: URL) {
        
        self.url = url
        self.webView = WKWebView()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
extension UICustomWebView {
    public func reload(){
        webView.reload()
    }
    
    public func goBack(){
        webView.goBack()
    }
    
    public func goForward(){
        webView.goForward()
    }
}
