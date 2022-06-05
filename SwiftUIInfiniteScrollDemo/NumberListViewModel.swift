//
//  NumberListViewModel.swift
//  SwiftUIInfiniteScrollDemo
//
//  Created by Pedro Alvarez on 05/06/22.
//
import SwiftUI

class NumberListViewModel: ObservableObject {
    
    @Published var numbers: [Int] = []
    @Published var currentPage: Int = 1
    
    var total: Int {
        currentPage < 25 ? numbers.count + 10 : numbers.count
    }
    
    func populateData() {
        
        guard let url = URL(string: "https://island-bramble.glitch.me/data?page=\(currentPage)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            let numbers = try? JSONDecoder().decode([Int].self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.numbers.append(contentsOf: numbers ?? [])
            }
        }.resume()
        currentPage += 1
    }
    
    func shouldLoadData(id: Int) -> Bool {
        return id == numbers.count - 2
    }
}
