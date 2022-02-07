import SwiftUI

class SelectionCoordinator: ObservableObject, Identifiable {
  
  // MARK: Stored Properties
  
  @Published var viewModel: SelectionViewModel!
  @Published var editSelectionViewModel: EditSelectionViewModel?
  
  // MARK: Initialization
  
  init() {
    self.viewModel = .init(coordinator: self)
  }
  
  // MARK: Methods
  
//  func open(_ recipe: Recipe) {
//    self.detailViewModel = .init(recipe: recipe, coordinator: self)
//  }
//
//  func openRatings(for recipe: Recipe) {
//    self.ratingViewModel = .init(recipe: recipe, recipeService: recipeService, coordinator: self)
//  }
//
//  func closeRatings() {
//    self.ratingViewModel = nil
//  }
//
//  func open(_ url: URL) {
//    self.parent.open(url)
//  }
//
}
