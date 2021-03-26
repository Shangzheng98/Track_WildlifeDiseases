//
//  readFiles.swift
//  TrackDiseases
//
//  Created by Shangzheng Ji on 3/26/21.
//  Copyright © 2021 Team1. All rights reserved.
//

import Foundation

func readProjectJsonFile() {
    let path: URL? = Bundle.main.url(forResource: "project.json", withExtension: nil)
    let jsonData: Data?
    
    do {
        jsonData = try Data(contentsOf: path!)
        print(jsonData!.description)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        let object = jsonObject as! [String:Any]
        if let projectWebsite = object["projectWebsit"] as? String {
            webpageURL = projectWebsite
        }
        if let questions = object["quesitons"] as? [String] {
            for item in questions {
                questionList.append(item)
            }
        }
        if let choiceSets = object["choiceSets"] as? [[String]] {
            for item in choiceSets {
                var temp = [Choice]()
                for choice in item {
                    let c = Choice(name: choice)
                    temp.append(c)
                }
                choicesList.append(temp)
            }
        }
        
    } catch {
        print("read project.json error!")
        return
    }
}


func readProfileJsonFile() {
    let path: URL? = Bundle.main.url(forResource: "profile.json", withExtension: nil)
    let jsonData: Data?
    do {
        jsonData = try Data(contentsOf: path!)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
        let object = jsonObject as! [String:Any]
        if let profileUrl = object["profileURL"] as? String {
            profileURL = profileUrl
        }
        
        if let achievementList = object["achievements"] as? [String] {
            achievements = achievementList
        }
        
        if let e = object["email"] as? String {
            email = e
        }
        
    } catch {
        print("read profile.json error!")
        return
    }
}

func  readMangeJsonFile() {
    let path: URL? = Bundle.main.url(forResource: "mange.json", withExtension: nil)
    let jsonData: Data?
    do {
        jsonData = try Data(contentsOf: path!)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
        let object = jsonObject as! [String:Any]
        if let projectDescrp = object["projectDescription"] as? String {
            descriptionContent = projectDescrp
        }
        if let mangeDecription = object["mangeDescriptionURL"] as? String {
            mangeWikipediaURL = mangeDecription
        }
        
        if let mangeDescriptionOffline = object["mangeDescriptionOffLine"] as? String {
            mangeDescription = mangeDescriptionOffline
        }
        
    } catch {
        print("read mange.json error!")
        return
    }
}
