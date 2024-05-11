//
//  Issue.swift
//  BlackValleyComics
//
//  Created by Eliel Kilembo on 5/11/24.
//

import Foundation
import JWTDecode

class Issue:Hashable{
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id:String?
    var entered:Date?
    var series:Series?
    var releaseDate:String?
    var seriesID:String?
    var published:Bool?
    var issueDetails:IssueDetails?
    
    init(dictionary:[String:Any]){
        self.id = dictionary["id"] as? String
        self.entered = dictionary["entered"] as? Date
        self.series = Series(dictionary: dictionary["series"] as! [String:Any])
        let releaseDateDictionary = dictionary["issueReleaseDate"] as? [String:Any]
        
        let dateString = releaseDateDictionary?["date"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let date = dateFormatter.date(from: dateString!) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.releaseDate = dateFormatter.string(from: date)
        }
        
        self.seriesID = dictionary["seriesID"] as? String
        self.published = dictionary["published"] as? Bool
        self.issueDetails = IssueDetails(dictionary: dictionary["issueDetails"] as! [String:Any])
    }
}

class Series{
    var audienceId:Int64?
    var author:String?
    var id:String?
    var title:String?
    var blackListed:Bool?
    var authorID:String?
    var cover:String?
    var description:String?
    var original:Bool?
    let visible:Bool?
    
    init(dictionary:[String:Any]){
        self.audienceId = dictionary["audienceID"] as? Int64
        self.author = dictionary["author"] as? String
        self.id = dictionary["id"] as? String
        self.title = dictionary["title"] as? String
        self.blackListed = dictionary["blackListed"] as? Bool
        self.authorID = dictionary["authorID"] as? String
        self.cover = dictionary["cover"] as? String
        self.description = dictionary["description"] as? String
        self.original = dictionary["original"] as? Bool
        self.visible = dictionary["visible"] as? Bool
    }
}

class IssueDetails{
    var title:String
    var number:Int64
    
    init(dictionary:[String:Any]){
                
        let currentTitle = (dictionary["title"] as? String)!
        self.title = currentTitle.replacingOccurrences(of: "'", with: "")
        self.number = (dictionary["number"] as? Int64)!
    }
    
}
