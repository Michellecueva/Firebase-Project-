//
//  DateExtension.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/27/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
