//
//  ConnectivityHelper.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Alamofire
public struct ConnectivityHelper{
    public static var isConnected: Bool{
        return NetworkReachabilityManager()!.isReachable
    }
}
