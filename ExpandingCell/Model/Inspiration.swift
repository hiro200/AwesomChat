//
//  Inspiration.swift
//  AwesomeChat
//
//  Created by Good Luck on 20/02/2019.
//  Copyright © 2019 GoodLuck. All rights reserved.
//

import UIKit

struct ExpandingLayoutConstants {
    
        // The height of the non-featured cell
        static let standardHeight: CGFloat = 100
        // The height of the first visible cell
        static let featuredHeight: CGFloat = 280
    
}


class Inspiration: Session {
    
    
    class func allInspirations() -> [Inspiration] {
        var inspirations: [Inspiration] = []
        guard let URL = Bundle.main.url(forResource: "Inspirations", withExtension: "plist"),
            let tutorialsFromPlist = NSArray(contentsOf: URL) else {
                return inspirations
        }
        for dictionary in tutorialsFromPlist {
            let inspiration = Inspiration(dictionary: dictionary as! NSDictionary)
            inspirations.append(inspiration)
        }
        return inspirations
    }
    
}
