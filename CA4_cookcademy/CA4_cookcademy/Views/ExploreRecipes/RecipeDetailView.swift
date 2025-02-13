//
//  RecipeDetailView.swift
//  CA4_cookcademy
//
//  Created by bota on 24.12.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @EnvironmentObject var recipeData: RecipeData
    @State private var isPresenting = false
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text("Author: \(recipe.mainInformation.description)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")"
                                     + "\(direction.description)")
                            }.foregroundColor(listTextColor)
                        }
                    }.listRowBackground(listBackgroundColor)
                }
            }
            .navigationTitle(recipe.mainInformation.name)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button("Edit") {
                            isPresenting = true
                        }
                        Button(action: {
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        }
                    }
                }
            }
            // 3
            .sheet(isPresented: $isPresenting) {
                NavigationView {
                    ModifyRecipeView(recipe: $recipe)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    isPresenting = false
                                }
                            }
                        }
                        .navigationTitle("Edit Recipe")
                }
                .onDisappear {
                    recipeData.saveRecipes()
                }
            }
            }
        }
        
        struct RecipeDetailView_Previews: PreviewProvider {
            @State static var recipe = Recipe.testRecipes[0]
            static var previews: some View {
                NavigationView {
                    RecipeDetailView(recipe: $recipe)
                }
            }
        }
    }

