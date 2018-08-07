//
//  timeFromIntDuration.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

extension Int {
    func getTimeFromIntDuration() -> (Int, Int) {
        let hours: Int = self / 60
        let minutes = self - (hours * 60)
        return (hours, minutes)
    }
}
