//
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        guard let index = firstIndex(of: object) else { return }
        remove(at: index)
    }
}
