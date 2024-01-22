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
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.load(request)
    }
}

extension UICustomWebView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        
        var webView: UICustomWebView
        
        init(_ webView: UICustomWebView){
            self.webView = webView
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // target_blankでも開けるようにする：WKUIDelegate
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) { }
        
        // ページ表示が完了するたびに呼ばれる
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    }
}

extension UICustomWebView {
    
    public func goBack(){
        webView.goBack()
    }
    
    public func goForward(){
        webView.goForward()
    }
    
    public func openBrowser(browser: BrowserConfig){
        guard let url = webView.url else { return }
        switch browser {
            
        case .safari:
            // Safariで起動する
            guard UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        case .chrome:
            // Chromeで起動する
            // URL内の「http」→ 「googlechrome」に置換
            // URL内の「https」→ 「googlechromes」に置換
            let urlString = url.absoluteString
            let pattern = "http"
            let with = "googlechrome"
            
            guard let firstMatchRange = urlString.range(of: pattern) else { return }

            let replacedString = urlString.replacingOccurrences(of: pattern, with: with, options: [], range: firstMatchRange)
            
            guard let chromeUrl = URL(string: replacedString) else { return }
            guard UIApplication.shared.canOpenURL(chromeUrl) else { return }
            UIApplication.shared.open(chromeUrl)
        }
    }
    
    public func reload(){
        webView.reload()
    }
    
    // シェアロジック
    public func shareUrl(){
        guard let url = webView.url else { return }
        let items = [webView.title ?? "", url] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true, completion: {})
    }
}
