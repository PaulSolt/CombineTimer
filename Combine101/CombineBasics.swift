//
//  CombineBasics.swift
//  Combine101
//
//  Created by Paul Solt on 9/8/19.
//  Copyright © 2019 Paul Solt. All rights reserved.
//

import SwiftUI
import Combine

struct CombineBasics: View {
    var body: some View {
        Text("Combine 101")
            .onAppear(perform: viewDidAppear)
    }
}

func viewDidAppear() {
    // Experiment here

    print("Hello World!")
    
    let stringPublisher: AnyPublisher<String, Never> =
        ["try!", "Swift", "NYC"]
            .publisher              // Publishers.Sequence<[String], Never>
            .eraseToAnyPublisher()  // AnyPublisher<String, Never>
    
    let sink = Subscribers.Sink<String, Never>.init(receiveCompletion: { status in
        print("Finished: \(status)")    // called when finished "iterating" array
    }, receiveValue: { (input: String) in
        print("Received: \(input)")     // called for each element in the array
    })
    
    stringPublisher.subscribe(sink) // stream executes
    
    
    // Short hand Welcome
    _ = ["Welcome", "to", "Combine"]
        .publisher
        .sink(receiveValue: { value in
            print(value)
        })
    
    // Map (Double to Int)
    _ = [42.5, 27.5, 3.2, 104.4]
        .publisher
        .map {
            return Int($0 * 10)
        }.sink { value in
            print(value)
        }
    
    // Filter star ratings >= 3
    _ = [4,5,2,1,3,1]
        .publisher
        .filter {
            $0 >= 3
        }.sink { value in
            print(value)
        }
}

func switchStatus() {
    
    _ =  Subscribers.Sink<String, Never>.init(receiveCompletion: { status in
        switch status {
        case .failure:
            print("Failed")
        case .finished:
            print("Finished")
        }
    }, receiveValue: { (value) in
        
    })
}


struct CombineBasics_Previews: PreviewProvider {
    static var previews: some View {
        CombineBasics()
    }
}
