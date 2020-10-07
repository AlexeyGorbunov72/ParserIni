//
//  Parser.swift
//  ParserInit
//
//  Created by Alexey on 01.10.2020.
//

import Foundation

class Parser{
    private var initFileData: [String: [String: String]] = [:]
    private var curentSection = ""
    func parse(pathToFile: String) throws{
        
        guard let contentOfFile = try? String(contentsOfFile: pathToFile) else {
            throw ParserErrors.invalidPathToFile
        }
        
        for rawLine in contentOfFile.split(separator: "\n"){
            let line = rawLine.separateByComment()
            try parseLine(line: line)
        }
        print(initFileData)

    }
    private func parseLine(line: String.SubSequence) throws{
        if !line.isEmpty{
            if line.isSection(){
                
                curentSection = try line.getSectionName()
                try checkSectionNameCollision(for: curentSection)
                initFileData[curentSection] = [:]
            } else {
                
                let (parameter, value) = try line.getKeyValue()
                try putValue(section: curentSection,
                             parameter: parameter,
                             value: value)
            }
        }
    }
    private func checkSectionNameCollision(for sectionName: String) throws{
        if initFileData[sectionName] != nil{
            throw ParserErrors.findCollision
        }
    }
    
    private func putValue(section: String, parameter: String, value: String) throws{
        if initFileData[curentSection]![parameter] != nil{
            throw ParserErrors.findCollision
        }
        if initFileData[curentSection] != nil{
            initFileData[curentSection]![parameter] = value
            return
        }
        throw ParserErrors.invalidSection
    }
    
    func getValue<T>(section: String, parameter: String, type: T) throws -> T?{
        if !isEnableType(type: type){
            throw ParserErrors.invalidTypeOfParameter
        }
        if initFileData[section] == nil{
            throw ParserErrors.unexistsSection
        }
        if initFileData[section]![parameter] == nil{
            throw ParserErrors.unexistsParameter
        }
        let value = try initFileData[section]![parameter]?.convertTo(type: type)
        return value
        
    }
    
    func isEnableType<T>(type: T) -> Bool{
        return type is String || type is Int || type is Float || type is Double
        
    }
}

extension String.SubSequence{
    func separateByComment() -> String.SubSequence{
        if let separeted = self.firstIndex(of: ";"){
            return self[..<separeted].strip()
        } else {
            return self.strip()
        }
    }
    
    func getKeyValue() throws -> (key: String, value: String){
        if let separated = self.firstIndex(of: "="){
            
            let key = String(self[..<separated])
                .trimmingCharacters(in: .whitespaces)
            
            let value = String(self[self.index(after: separated)...])
                .trimmingCharacters(in: .whitespaces)
            try checkOnWhiteSpace(for: key)
            if !key.isEmpty{
                return (key, value)
            }
        }
        throw ParserErrors.invalidPair
    }
    
    func getSectionName() throws -> String{
        if let separate = self.firstIndex(of: "["), let rightSeparate = self.lastIndex(of: "]"){
            let leftSeparate = self.index(after: separate)
            let resultString = String(self[leftSeparate..<rightSeparate]).trimmingCharacters(in: .whitespaces)
            
            try checkOnWhiteSpace(for: resultString)
            return resultString
        }
        
        throw ParserErrors.invalidSectionName
    }
    private func checkOnWhiteSpace(for string: String) throws{
        if !string.isEmpty{
            if string.contains(Character(" ")){
                throw ParserErrors.whitespaceInName
            }
        }
    }
    func isSection() -> Bool{
        return self.first == "["
    }
    private func strip() -> String.SubSequence{
        return String.SubSequence(self.trimmingCharacters(in: .whitespaces))
    }
}

extension String{
    func convertTo<T>(type: T) throws -> T? {
       
        if type is Int{
            guard let value = Int(self) as? T? else {
                throw ParserErrors.invalidTypeOfParameter
            }
        
            return value
        }
        if type is Float{
            guard let value = Float(self) as? T? else { throw ParserErrors.invalidTypeOfParameter
            }
            
            return value
        }
        if type is Double{
            guard let value = Double(self) as? T? else {
                throw ParserErrors.invalidTypeOfParameter
            }
            
            return value
        }
        if type is String{
            guard let value = self as? T else {
                throw ParserErrors.invalidTypeOfParameter
            }
            
            return value
        }
        throw ParserErrors.invalidTypeOfParameter
 
    }
}
