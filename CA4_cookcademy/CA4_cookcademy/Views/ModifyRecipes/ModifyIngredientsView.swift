//
//  ModifyIngredientsView.swift
//  CA4_cookcademy
//
//  Created by bota on 17.01.2025.
//

import SwiftUI
struct ModifyIngredientsView: View {
  @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    private let listBackgroundColor = AppColor.background
     private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient()
                  }
          if ingredients.isEmpty {
            Spacer()
              NavigationLink("Add the first ingredient",
                                            destination: ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                                             // Замыкание, которое добавляет новый ингредиент в список
                                             ingredients.append(ingredient)
                                             // Сбрасываем состояние для нового ингредиента
                                             newIngredient = Ingredient(name: "", quantity: 0.0, unit: .none)
                                            })
        Spacer()
      } else {
        List {
          ForEach(ingredients.indices, id: \.self) { index in
            let ingredient = ingredients[index]
            Text(ingredient.description)
          }.listRowBackground(listBackgroundColor)
            NavigationLink("Add another ingredient",
                                            destination: ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                                             // Замыкание для добавления нового ингредиента
                                             ingredients.append(ingredient)
                                             // Сбрасываем состояние для нового ингредиента
                                             newIngredient = Ingredient(name: "", quantity: 0.0, unit: .none)
                                            })
            .buttonStyle(PlainButtonStyle())
            .listRowBackground(listBackgroundColor)
        }
      }
    }.foregroundColor(listTextColor)
  }
}
struct ModifyIngredientsView_Previews: PreviewProvider {
  @State static var emptyIngredients = [Ingredient]()
  static var previews: some View {
    NavigationView {
      ModifyIngredientsView(ingredients: $emptyIngredients)
    }
  }
}
