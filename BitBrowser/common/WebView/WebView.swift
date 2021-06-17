//
//  WebView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI
import WebKit

class NavigationDelegate: NSObject, WKNavigationDelegate {
    let html = """
        <html>
            <body>
                <h1>404</h1>
            </body>
        </html>
    """
    
//    页面跳转后，内容接受完毕调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(webView.title ?? "default value")
        print(webView.url)
        print(Date())
    }
    
//    若输入无效的url，会调用这个方法，返回自定义的404页面
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("fail to load =========")
        webView.loadHTMLString(html, baseURL: nil)
    }
    
//    webView发起请求之前调用
//    allow后才会进行后面的代理方法
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        请求拦截，为url添加一些前缀
        if var string = navigationAction.request.url?.absoluteString {
            if (!string.hasPrefix("https://") && !string.contains("about:blank")) {
                if (!string.hasPrefix("www")) {
                    string = "https://www." + string
                } else {
                    string = "https://" + string
                }
                decisionHandler(.cancel)
                webView.load(URLRequest(url: URL(string: string)!))
                return
            }
        }
        print(navigationAction.request.url)
        print("allow")
        decisionHandler(.allow)
    }
    
}
struct WebView: UIViewRepresentable {
    let request: URLRequest
    var webview: WKWebView?
    var navigationDelegate = NavigationDelegate()
    
    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
        self.webview?.navigationDelegate = navigationDelegate;
        webview?.allowsBackForwardNavigationGestures = true
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.webview?.load(request)
        }
    }
    
    func goBack(){
        webview?.goBack()
    }
    
    func goForward(){
        webview?.goForward()
    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(web: nil, req: URLRequest(url: URL(string: "https://www.baidu.com")!))
    }
}
