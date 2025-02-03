//
//  SecondSceen.swift
//  first_project
//
//  Created by Zibran Khan on 25/01/25.
//

import SwiftUI

struct SecondScreen: View {
    @Binding var counterValue: Int // ✅ Allows updating value in ContentView

    @Environment(\.dismiss) var dismiss // Access dismiss environment action
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to the Second Screen!")
                .font(.largeTitle)
                .padding()
            
            Text("Counter Value: \(counterValue)")
                            .font(.largeTitle)
                            .padding()
            
            Button("Increment Value 2nd screen"){
                counterValue = counterValue + 1
            }.buttonStyle(.bordered)
            
            Button("Go Back") {
                // Action to go back is automatic
                dismiss()
                
            }
            
            NavigationLink(destination: ThirdScreen()) {
                Text("Go to third Screen")
                    .font(.headline)
                    .padding()
                   
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
            .buttonStyle(.borderedProminent)
            NavigationLink(destination: ContentView()) {
                Text("Go to First Screen")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Second Screen") // Sets the title of the screen
        .navigationBarTitleDisplayMode(.inline) // Inline title style
    }
}
#Preview {
    ContentView()
}
