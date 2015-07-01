//
//  Destination.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/07/02.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import Foundation

//
class Destination: RLMObject {
    dynamic var title = ""
    dynamic var created_at = NSDate()
    dynamic var routes = RLMArray(objectClassName: Route.className())
}
