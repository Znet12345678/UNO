//
//  Stack.swift
//  UNO
//
//  Created by Schlotman, Zachary J on 4/19/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation
class Stack {
    //make the array properties part of stack, use.array for array functionality
    fileprivate var array: [Card] = []
    var count : Int = 0
    //addcards to the last position of the array
    func push(_ element:Card)
    {
        array.append(element)
        count+=1
    }
    //take the last card from the array removing it and returning it
    func pop() -> Card?
    {
        count-=1
        return array.popLast()
    }
    //returns the last card in the array
    func peek() -> Card? {
        return array.last
    }
    func insert(c : Card, indx : Int){
        array.insert(c, at: indx)
    }
    init(){
        
    }
}
