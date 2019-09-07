//
//  ContentView.swift
//  Combine101
//
//  Created by Paul Solt on 9/7/19.
//  Copyright © 2019 Paul Solt. All rights reserved.
//

import SwiftUI
import Combine

//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    print("Don't forget to call super!")
//}
//
//Text("Hello World")
//    .onAppear {
//    print("Only my code here")
//}



struct ContentView: View {
    @State private var text: String = "Swift"
    
    var timer: AnyCancellable? = nil
    
    mutating func buttonPressed() {
        
    }
    
    var body: some View {
        VStack {
            Text(text)
            Button(action: {
                
                _ = Timer.publish(every: 0.2, on: .main, in: .default)
                    .sink {
                        print($0)
                }
//                    .combineLatest("Hello world!".publisher)
//                    .map { _, character in
//                        print(character)
//                        return String(character)
//                }.assign(to: \.text, on: self)
                
                
                _ = "Hello world!"
                    .publisher
                    .map { String($0) }
                    .sink(receiveValue: { letter in
                        print(letter)
                    })
                        
//                    .assign(to: \.text, on: self)

            }, label: {
                Text("Push Me")
            })
        }.onAppear(perform: viewDidAppear)
    }
    
    func viewDidAppear() {
        print("Hello World!")
        // Experiment here
        
        _ = ["Hello", "World"]
            .publisher
            .sink(receiveCompletion: { (status) in
                print("status: \(status)")  // called when finished "iterating" array
            }) { (word) in
                print(word) // called for each element in the array
        }
            
            // Does not match type! (Character != String)
            //        _ = "Hello world!"
            //            .publisher
            ////            .delay(for: 1000, scheduler: RunLoop.main)
            ////            .debounce(for: 1000, scheduler: RunLoop.main)
            //            .map({ String($0) })
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


