import SwiftUI

struct IntroScreens: View {
    @State private var skipIntro = false  // To check whether we should skip the intro

    var body: some View {
        if UserDefaults.standard.bool(forKey: "hasSkippedIntro") {
                   // Skip the intro and go directly to the ThirdScreen
                   ThirdScreen()
               }
        else{
            NavigationStack {
                VStack {
                    HStack {
                        Spacer()
                        // NavigationLink for skipping the intro
                        NavigationLink(destination: ThirdScreen()) {
                            Text("Skip")
                                .cornerRadius(10)
                                .onTapGesture {
                                    // Set the flag to skip the intro and save it in UserDefaults
                                    UserDefaults.standard.set(true, forKey: "hasSkippedIntro")
                                    skipIntro = true
                                }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    .onAppear {
                        // Check if the user has already skipped the intro
                        if UserDefaults.standard.bool(forKey: "hasSkippedIntro") {
                            skipIntro = true
                        }
                    }
                    
                    // Use a TabView to create swipable pages
                    TabView {
                        IntroPage(imageName: "checkmark.circle.fill", title: "Welcome to TaskMaster", description: "Manage your tasks efficiently!")
                        IntroPage(imageName: "star.fill", title: "Create Tasks", description: "Easily create and organize your tasks.")
                        IntroPage(imageName: "clock.fill", title: "Stay on Track", description: "Track your progress and get reminders.")
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))  // Style the TabView to show a page indicator
                    
                    // Skip the intro if the user has clicked "Skip"
                    if skipIntro {
                        ThirdScreen()
                    }
                }
            }}
    }
}

struct IntroPage: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        VStack {
            // Show an image (replace with actual image names)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)  // Add the blue color here
                .padding()

            // Show a title
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding()

            // Show a description
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    IntroScreens()
}
