import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false   // Controls navigation to Home

    var body: some View {
        if isActive == true {
            IntroScreens()   // Navigate to the Home Screen after the splash
        }
        else {
            VStack {
                Image(systemName: "checkmark.circle.fill")  // App Icon
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()

                Text("TaskMaster")  // App Name
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .onAppear {
                // Delay for 2 seconds, then move to ContentView
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
