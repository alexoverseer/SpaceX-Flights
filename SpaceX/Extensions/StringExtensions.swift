import Foundation

extension String {
    
    func capturedGroups(withRegex pattern: String) -> String {
        var results = [String]()
        
        var regex: NSRegularExpression
        
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results.first ?? ""
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))

        guard let match = matches.first else { return results.first ?? ""}
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results.first ?? "" }
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        return results.first ?? ""
    }
}
