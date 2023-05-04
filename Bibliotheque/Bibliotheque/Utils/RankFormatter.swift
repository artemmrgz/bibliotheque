//
//  RankFormatter.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 04/05/2023.
//

import UIKit

struct RankFormatter {

    func makeAttrebutedRank(currentRank: Int, rankLastWeek: Int) -> NSMutableAttributedString {
        let rankDifference = stringify(rankLastWeek - currentRank)
        let rootString = currentRankFormatted(String(describing: currentRank))
        rootString.append(rankDifferenceFormatted(rankDifference))
        return rootString
    }
        
    
    func rankDifferenceFormatted(_ rankDifference: String) -> NSMutableAttributedString {
        var formatter = rankDifferenceBaseFormatter()
        
        if rankDifference.starts(with: "+") {
            formatter[.foregroundColor] = UIColor.systemGreen
        } else if rankDifference.starts(with: "-") {
            formatter[.foregroundColor] = UIColor.systemRed
        } else {
            formatter[.foregroundColor] = UIColor.systemGray2
        }
        
        return NSMutableAttributedString(string: rankDifference, attributes: formatter)
    }
        
    func rankDifferenceBaseFormatter() -> [NSAttributedString.Key: Any] {
        var numberAttrString = [NSAttributedString.Key: Any]()
        numberAttrString[.font] = UIFont.systemFont(ofSize: 15)
        numberAttrString[.baselineOffset] = 20
        return numberAttrString
    }
    
    func currentRankFormatted(_ currentRank: String) -> NSMutableAttributedString {
        var rankAttrString = [NSAttributedString.Key: Any]()
        rankAttrString[.font] = UIFont.systemFont(ofSize: 45, weight: .bold)
        rankAttrString[.foregroundColor] = Resources.Color.accentYellow
        
        return NSMutableAttributedString(string: currentRank, attributes: rankAttrString)
    }
    
    func stringify(_ number: Int) -> String {
        let numberAsString = String(describing: number)

        if number > 0 {
            return "+" + numberAsString
        }
        
        return numberAsString
    }
}
