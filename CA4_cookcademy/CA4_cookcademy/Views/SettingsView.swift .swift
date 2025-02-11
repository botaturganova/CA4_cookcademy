//
//  SettingsView.swift .swift
//  CA4_cookcademy
//
//  Created by bota on 10.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
  
  var body: some View {
    NavigationView {
      Form {
        ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
          .padding()
          .listRowBackground(listBackgroundColor)
        ColorPicker("Text Color", selection: $listTextColor)
          .padding()
          .listRowBackground(listBackgroundColor)
        Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
          .padding()
          .listRowBackground(listBackgroundColor)
      }
      .foregroundColor(listTextColor)
      .navigationTitle("Settings")
    }
  }
}

#Preview {
    SettingsView()
}
