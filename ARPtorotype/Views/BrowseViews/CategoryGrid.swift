//
//  CategoryGrid.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct CategoryGrid: View {
    
    @Binding var showBrowse: Bool
    @ObservedObject private var viewModel = ARModelsViewModel()
    
    var body: some View {
        VStack {
            ForEach(ARModelCategory.allCases, id: \.self) { category in
                if let modelsByCategory = viewModel.arModels.filter({ $0.category == category }) {
                    HorizontalGrid(showBrowse: $showBrowse, title: category.label, items: modelsByCategory)
                }
            }
        }
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct CategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGrid(showBrowse: Binding.constant(false))
    }
}
