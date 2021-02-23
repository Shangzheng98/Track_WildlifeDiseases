//
//  Webpage.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/23.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    // Input Parameter
    let url: String
    static var webView: WKWebView!
    func makeUIView(context: Context) -> WKWebView  {
        guard let urlStruct = URL(string: url) else {
            // Show nothing since url is invalid
            return WKWebView(frame: .zero)
        }
        /*
         Convert the URL struct into a URLRequest struct.
         URLRequest is a URL load request that is independent of protocol or URL scheme.
         */
        let urlLoadRequest = URLRequest(url: urlStruct)
        
        if nil == Self.webView {
            Self.webView = WKWebView()
            Self.webView.scrollView.isScrollEnabled = false
        }
        if urlLoadRequest.url != Self.webView.url {
                    Self.webView.load(urlLoadRequest)
                }
        return Self.webView
    }
 
    // A WKWebView object displays interactive web content in a web browser within the app
    func updateUIView(_ webView: WKWebView, context: Context) {
       
        // Convert url from String type to URL struct type
        guard let urlStruct = URL(string: url) else {
            // Show nothing since url is invalid
            return
        }
        /*
         Convert the URL struct into a URLRequest struct.
         URLRequest is a URL load request that is independent of protocol or URL scheme.
         */
        let urlLoadRequest = URLRequest(url: urlStruct)
       
        /*
         Swiping from left screen edge to right shows the previous (back) web view.
         Swiping from right screen edge to left shows the next (forward) web view.
         */
        webView.allowsBackForwardNavigationGestures = true
     
        // Ask the webView object to display the web page for the given url
        webView.load(urlLoadRequest)
    }
 
}
 
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://en.wikipedia.org/wiki/Mange")
    }
}
