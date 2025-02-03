import SwiftUI

struct ThirdScreen: View {
    
    // Use the correct TodoTask model here
    @State private var tasksArray: [TodoTask] = []  // Array to store tasks
    @State private var newTask = ""                  // New task text
    @State private var showAlert = false             // Alert for empty task input
    
    private let tasksKey = "tasksKey"               // Fixed typo: was `tasksKeys`
    
    var body: some View {
        NavigationStack {
            VStack {
                // 🌟 App Header
                HStack {
                    Image(systemName: "checkmark.circle.fill") // App icon
                        .foregroundColor(.blue)
                        .font(.system(size: 30))               // Icon size

                    Text("TaskMaster")                         // App title
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.top, 20)
                
                // 🌟 Input Field Section
                HStack {
                    Image(systemName: "pencil")                      // Icon for task input
                        .foregroundColor(.blue)
                    
                    TextField("Enter a new task...", text: $newTask) // Custom placeholder
                        .padding(10)
                        .background(Color(.systemGray6))             // Light gray background
                        .cornerRadius(10)                            // Rounded corners
                }
                .padding(.horizontal)                                // Add spacing on sides

                // 🌟 Add Task Button
                Button(action: {
                    if newTask.isEmpty {
                        showAlert = true
                        return
                    }
                    let newTaskItem = TodoTask(title: newTask, isCompleted: false)
                    tasksArray.append(newTaskItem)
                    saveTasks()
                    newTask = ""
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")  // Add icon
                        Text("Add Task")                      // Button text
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)                  // Text/Icon color
                    .padding()                                // Space inside button
                    .frame(width: 200)                // Make button full-width
                    .background(Color.blue)                   // Button background color
                    .cornerRadius(12)                         // Rounded corners
                }
                .padding(.horizontal)
                .padding(.top, 20)  // Add top margin for spacing

                
                // List to display tasks
                // 🌟 Task List
                List {
                    ForEach(tasksArray.indices, id: \.self) { taskIndex in
                        
                        // 🌟 NavigationLink wraps the entire HStack
                        NavigationLink(destination: TaskDetailScreen(
                            selectedTask: $tasksArray[taskIndex],
                            tasksArray: $tasksArray,
                            taskIndex: taskIndex
                        )) {
                            HStack {
                                // ✅ Completion Icon
                                let task = tasksArray[taskIndex]

                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .blue)
                                    .onTapGesture {
                                        tasksArray[taskIndex].isCompleted.toggle()  // ✅ Toggle completion
                                        saveTasks()                                 // ✅ Save changes
                                    }

                                Text(task.title)
                                    .font(.body)
                                    .padding(.leading, 8)
                                    .strikethrough(task.isCompleted, color: .gray) // ✅ Add strikethrough if completed
                                    .foregroundColor(task.isCompleted ? .gray : .black) // ✅ Dim color if completed
                                    
                                Spacer() // Pushes content to the left
                            }
                            .padding()
                            .background(Color.white)                    // Card background
                            .cornerRadius(12)                           // Rounded corners
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2) // Subtle shadow
                        }
                        .swipeActions(edge: .trailing) {                // Swipe to delete
                            Button(role: .destructive) {
                                deleteTask(at: IndexSet(integer: taskIndex))
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .listRowSeparator(.hidden) // 🚩 Hide the separator for this row
                    }
                }
                .listStyle(PlainListStyle())

            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please write something!"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                loadTasks()  // Load tasks when the view appears
            }
        }
    }
    
    // Delete task at specific offsets
    private func deleteTask(at offsets: IndexSet) {
        tasksArray.remove(atOffsets: offsets)
        saveTasks() // Save after deletion
    }
    
    // Save tasks to UserDefaults
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasksArray) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }

    // Load tasks from UserDefaults
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let savedTasks = try? JSONDecoder().decode([TodoTask].self, from: data) {
            tasksArray = savedTasks
            print("Loaded tasks: \(tasksArray)")
        } else {
            print("No tasks found in UserDefaults.")
        }
    }

}

#Preview {
    ThirdScreen()
}
