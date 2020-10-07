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
    try print(p.getValue(section: "LEGACY_XML",
                         parameter: "ListenTcpPort",
                         type:  String()))
    
} catch ParserErrors.invalidPathToFile{
    print(ParserErrors.invalidPathToFile)
} catch ParserErrors.invalidFormatOfFile{
    print(ParserErrors.invalidFormatOfFile)
} catch ParserErrors.invalidPair{
    print(ParserErrors.invalidPair)
} catch ParserErrors.invalidSectionName{
    print(ParserErrors.invalidSectionName)
} catch ParserErrors.invalidTypeOfParameter{
    print(ParserErrors.invalidTypeOfParameter)
} catch ParserErrors.unexistsParameter{
    print(ParserErrors.unexistsParameter)
} catch ParserErrors.unexistsSection{
    print(ParserErrors.unexistsSection)
}



