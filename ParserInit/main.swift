//
//  main.swift
//  ParserInit
//
//  Created by Alexey on 01.10.2020.
//

import Foundation

let parser = Parser()
do{
    try parser.parse(pathToFile: "/Users/Retard/Desktop/input.ini")
    if let value = try parser.getValue(
                section: "LEGACY_XML",
                parameter: "ListenTcpPort",
                type:  Int()){
        print(value)
    } else {
        print("Value is nil")
    }
    
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
    
} catch ParserErrors.findCollision{
    print(ParserErrors.findCollision)
    
} catch ParserErrors.whitespaceInName{
    print(ParserErrors.whitespaceInName)
    
} catch ParserErrors.cantConvertToThisType {
    print(ParserErrors.cantConvertToThisType)
    
} catch {
    print("Another error :(")
}



