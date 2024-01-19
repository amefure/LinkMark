//
//  UIWebView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import UIKit
import SwiftUI
import WebKit

struct UIWebView: UIViewRepresentable {
    
    private let webView = WKWebView()
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        // あとでコメントを解除
        // webView.navigationDelegate = context.coordinator
        webView.load(request)
    }
}

extension UIWebView {
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
