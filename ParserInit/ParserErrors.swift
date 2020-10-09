//
//  ParserErrors.swift
//  ParserInit
//
//  Created by Alexey on 01.10.2020.
//


enum ParserErrors: Error{
    case invalidPathToFile
    case invalidFormatOfFile
    case invalidTypeOfParameter
    case unexistsSection
    case unexistsParameter
    case invalidPair
    case invalidSectionName
    case invalidSection
    case whitespaceInName
    case findCollision
    case cantConvertToThisType
}
