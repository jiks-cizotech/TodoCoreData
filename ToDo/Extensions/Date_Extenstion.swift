//
//  Date_Extenstion.swift
//  ToDo
//
//  Created by jignesh solanki on 05/10/23.
//

import Foundation

extension Date{
    func toString() -> String{
     let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .short
        
        dateformatter.dateFormat = "MM/dd/YYYY HH:mm"
        
        let result = dateformatter.string(from: self)
        return result
    }
}
