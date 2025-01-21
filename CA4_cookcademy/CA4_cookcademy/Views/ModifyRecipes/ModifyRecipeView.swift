//
//  ModifyRecipeView.swift
//  CA4_cookcademy
//
//  Created by bota on 07.01.2025.
//
import SwiftUI
struct ModifyRecipeView: View {
   
    
  @Binding var recipe: Recipe
  @State private var selection = Selection.main
    
    enum Selection {
        case main, ingredients, directions
    }
  var body: some View {
      VStack {
          Picker("Select recipe component", selection: $selection){
              Text("Main info").tag(Selection.main)
              Text("Ingredients").tag(Selection.ingredients)
              Text("Directions").tag(Selection.directions)
          }
          .pickerStyle(SegmentedPickerStyle())
          switch selection {
          case .main:
            ModifyMainInformationView(mainInformation: $recipe.mainInformation)
          case .ingredients:
            ModifyIngredientsView(ingredients: $recipe.ingredients)
          case .directions:
            Text("Directions Editor")
          }
          Spacer()
          }
      }
}


struct ModifyRecipeView_Previews: PreviewProvider {
  @State static var recipe = Recipe()
  static var previews: some View {
    ModifyRecipeView(recipe: $recipe)
  }
}
