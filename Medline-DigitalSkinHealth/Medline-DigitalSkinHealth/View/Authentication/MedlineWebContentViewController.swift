//
//  MedlineToDisplayWebContentController.swift
//  XCTestSample
//
//  Created by Sunil Kumar Jaiswal on 18/02/21.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class MedlineWebContentViewController: MedlineBaseViewController {
    
    @IBOutlet weak var medlineWkWebView: WKWebView!
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    var webpageURL: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medlineWkWebView.navigationDelegate = self
        medlineWkWebView.clearsContextBeforeDrawing = true
        addCustomMedlineNavigationBar(withBack: true)
        if isDeviceTypeIPad() {
            topSpaceConstraint.constant = MedlineAppConstant.kWebPageTopSpace
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = NSURL (string: retrieveProperString(retrieveString: webpageURL))
        let requestObj = NSURLRequest(url: url! as URL)
  
        medlineWkWebView.navigationDelegate = self
        medlineWkWebView.load(requestObj as URLRequest)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        releaseViewcontrollerResources()
    }
    
    deinit{
        print("deinit is called")
        releaseViewcontrollerResources()
    }
    
    func releaseViewcontrollerResources() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        print("Release Resources Of Controller")
    }
    
}

extension MedlineWebContentViewController: WKNavigationDelegate {
    // MARK: Webview delegate methods
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
        print(error.localizedDescription)
        stopActivityIndicator()
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        print("Start to load")
        startActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        print("Finish Loading")
        stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        print("Error in Loading")
        stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           let trust = challenge.protectionSpace.serverTrust!
           let exceptions = SecTrustCopyExceptions(trust)
           SecTrustSetExceptions(trust, exceptions)
           completionHandler(.useCredential, URLCredential(trust: trust))
    }
}
