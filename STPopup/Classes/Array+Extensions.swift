//
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
