//
//  SettingModel.swift
//  HeadNews
//
//  Created by Cheng Sun on 4/9/19.
//  Copyright © 2019 EF. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenRightTitle:Bool = false
    var isHiddenSubtitle: Bool = false
    var isHiddenRightArraw: Bool = false
    var isHiddenSwitch: Bool = false
}
