import SwiftUI

struct ContentView: View {
    @State var counter = 0

    var body: some View {
        NavigationStack { // Wrap in NavigationStack to enable navigation
            VStack(spacing: 10) {
                // Display the counter value
                CounterDisplay(counter: counter)
                
                // Buttons to modify the counter
                CounterControls(counter: $counter)
            }
            .padding()
            .onAppear {
                print("App appeared. Counter: \(counter)")
            }
        }
    }
}

// Subview for displaying the counter
struct CounterDisplay: View {
    let counter: Int
    
    var body: some View {
        VStack {
            Text("Counter: \(counter)")
                .font(.title)
//                .scaleEffect(counter > 0 ? 1.2 : 1.0) // Grows slightly when counter is > 0
//                .animation(.easeInOut, value: counter) // Smooth animation
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .padding()
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundStyle(.red)
        }
    }
}

// Subview for counter buttons
struct CounterControls: View {
    @Binding var counter: Int

    var body: some View {
        VStack(spacing: 15) {
            Button("Increment") {
                counter += 1
                print("Counter value: \(counter)")
            }
            .buttonStyle(.borderedProminent)
            
            Button("Decrease Value") {
                if counter > 0 {
                    counter -= 1
                    print("Decreased counter to \(counter)")
                }
            }
            .buttonStyle(.bordered)
            .disabled(counter == 0)
            
            Button("Reset Value") {
                counter = 0
                print("Counter reset")
            }
            .buttonStyle(.bordered)
            
            // NavigationLink for navigation
            NavigationLink(destination: SecondScreen(counterValue: $counter)) {
                Text("Go to Second Screen")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
#Preview {
    ContentView()
}
