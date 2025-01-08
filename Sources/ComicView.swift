import SwiftUI
import Alamofire
import AlamofireImage
import WebKit
import Foundation
import EPUBKit
import EpubReaderLight

// Placeholder for testing
let issueDictionary: [String: Any] = [
   "id": "cm4ccmzlg0001fqbzl27jkaeq",
   "seriesID": "cm0fs5vf600011igf0nwockpf",
   "published": true,
   "entered": "2024-12-06T06:12:41.524Z",
   "issueDetails": [
       "title": "Training Lab",
       "number": 3
   ],
   "issueReleaseDate": [
       "date": "2024-12-06T00:00:00.000Z"
   ],
   "series": [
       "id": "cm0fs5vf600011igf0nwockpf",
       "title": "Six Pack Punches",
       "cover": "https://imagedelivery.net/gQ7S7Z8-BtbLifr4ylpgmA/91c10a03-8a60-41da-552a-9724b6652100/comiccover",
       "audienceID": 1,
       "description": "In a universe divided by heroism (Blue Spark) and villainy (Red Spark), Six-Pack-Punches stands alone. Gifted with both, he embarks on a quest to uncover his true purpose, navigating the blurred lines of good and evil. As Six-Pack-Punches hones his unique powers, he faces formidable enemies, discovers unexpected allies, and confronts the darkness within. With the fate of the cosmos at stake, a critical choice emerges: embrace his extraordinary destiny or succumb to the conflicting forces within.",
       "authorID": "cltgytckv0000i96hhiydcojw",
       "orignal": true,
       "blackListed": false,
       "visbile": true,
       "author": [
           "name": "Lemuel Chileshe"
       ],
       "blur": [
           "seriesID": "cm0fs5vf600011igf0nwockpf",
           "blur": "https://imagedelivery.net/gQ7S7Z8-BtbLifr4ylpgmA/8f53a2e2-5671-4a7b-6b27-b377b7dc5c00/placeholder"
       ]
   ]
];

struct ComicView: View {
    
    let apiHandler:ApiHandler
    @State private var data:[[String:Any?]] = []
    @State var issue:Issue?
    @State private var htmlContent: String = ""
    let parser: EPUBParser
    @State var epubURL: URL
    
    
    init(issue:Issue?){
        self.apiHandler = ApiHandler();
        _issue = State(initialValue: issue);
        self.htmlContent = "";
        self.epubURL = URL(string:"www.google.com") ?? URL(string:"")!
        self.parser = EPUBParser();
    }
    
    var body: some View {
        WebView(url: URL(string:"https://www.blackvalleycomics.com/comic/\(self.issue?.seriesID ?? "")/chapter/\(self.issue?.id ?? "")")!);
    }
}

#Preview {
    let testIssue = Issue(dictionary: issueDictionary);
    ComicView(issue: testIssue);
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        print("hello \(url)");
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update the web view if needed
    }
}


