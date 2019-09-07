//
//  TimerView.swift
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



struct TimerView: View {
    @State private var timeString: String = "00:00"
    @State private var timer: AnyCancellable? = nil
    @State private var startDate: Date? = nil
    @State private var isActive: Bool = false
    
    var body: some View {
        VStack {
            Text(timeString)
                .font(Font.system(size: 80, weight: .semibold, design: .default)
                    .monospacedDigit()
            )
            startStopButton
        }.onAppear(perform: viewDidAppear)
    }
    
    var startStopButton: some View {
        Button(action: startStop, label: {
            Text(isActive ? "Stop" : "Start")
                .font(.title)
        })
    }
    
    func startStop() {
        if isActive {
            timer?.cancel()
        } else {
            timer = createTimer()
        }
        isActive.toggle()
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
                
        //timer = Timer.publish(every: 0.2, on: .main, in: .default)
        //    .autoconnect()
        //    .sink {
        //        print($0)
        //    }
        
        //startStop()
    }
    
    // TODO: Fix time formatting (timezone?)
    var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        formatter.dateFormat = "mm:ss.SS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowsFractionalUnits = true
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    
    private let zeroTime = "00:00"

    
    func createTimer() -> AnyCancellable {
        startDate = Date()
        
        return Timer.publish(every: 0.01, on: .main, in: .default)
            .autoconnect()
            .compactMap { time in
                self.startDate.map { startDate in
                    self.timeFormatter.string(from:
                        time.timeIntervalSince(startDate)) ?? self.zeroTime
                }
        }
        .sink { (time) in
            self.timeString = time
        }
        // Can use the sink or assign directly to a String property
        //.assign(to: \.timeString, on: self)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}


