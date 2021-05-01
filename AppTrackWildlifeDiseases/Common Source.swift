//
//  Common Source.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import Foundation


public var descriptionContent = ""
public var achievements = [String]()
public var email = ""

public var profileURL = ""

public var webpageURL = ""  // for the webpage of this project

public var mangeContent = "www.google.com"

public var mangeWikipediaURL = ""

public var netWorkStatus = "offline"

public var mangeDescription = "COVID-19 and many other emerging diseases, such as Ebola and the avian flu, have origins in wildlife. Thus, it is crucial to monitor wildlife diseases. However, this is expensive and time consuming, and the diseases could emerge in areas without monitoring. Citizen science bring an opportunity for early detection of wildlife diseases. This project will focus on the development of an app, freely available to the public, to track mange, an infectious disease in wildlife that is easy to detect by non-experts. Mange is spreading globally and Virginia has an ongoing epidemic in bears. Thus, this disease is a great model to implement the app, which can be expanded to other diseases in the future."

public var questionList = [String]()
public var choicesList = [[Choice]]()
public func formatter(number: Double) -> String
{
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    let n = Double(number)
    return formatter.string(from: NSNumber(value: n)) ?? "$0"
}
