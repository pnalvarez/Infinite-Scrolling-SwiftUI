//
//  ContentView.swift
//  SwiftUIInfiniteScrollDemo
//
//  Created by Pedro Alvarez on 05/06/22.
//

import SwiftUI

struct NumberListView: View {
    @StateObject private var numberListVM = NumberListViewModel()
    
    var body: some View {
        List(0..<numberListVM.total, id: \.self) { index in
            if index < numberListVM.numbers.count {
                Text("\(numberListVM.numbers[index])")
                .onAppear {
                    if numberListVM.shouldLoadData(id: index) {
                        numberListVM.populateData()
                    }
                }
            } else {
                ProgressView()
                    .foregroundColor(Color.blue)
                    .padding()
            }
        }
        .onAppear {
            numberListVM.populateData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListView()
    }
}
