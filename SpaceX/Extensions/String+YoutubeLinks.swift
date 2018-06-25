import Foundation

extension String {
    
    func youtubePreviewImageURL() -> String {
        
        let videoID = getYTVideoID()
        return "https://i1.ytimg.com/vi/\(videoID)/0.jpg"
    }
    
    public func getYTVideoID() -> String {
        
        var results = [String]()
        
        var regex: NSRegularExpression
        
        do {
            regex = try NSRegularExpression(pattern: "[?&;]v=([^?&;]+)", options: [])
        } catch {
            return results.first ?? ""
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        
        guard let match = matches.first else { return results.first ?? ""}
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results.first ?? "" }
        
        for index in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: index)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        return results.first ?? ""
    }
}
