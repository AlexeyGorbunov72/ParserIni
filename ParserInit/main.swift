//
//  main.swift
//  ParserInit
//
//  Created by Alexey on 01.10.2020.
//

import Foundation

let p = Parser()
do{
    try p.parse(pathToFile: "/Users/Retard/Desktop/input.ini")
    try print(p.getValue(section: "COMMON", parameter: "DiskCachePath", type:  String()))
    
} catch ParserErrors.invalidPathToFile{
        print("invalid path to file")
}



