import SwiftUI
import UserNotifications

struct TaskDetailScreen: View {
    @Binding var selectedTask: TodoTask         // Task object passed from parent
    @Binding var tasksArray: [TodoTask]         // Array of tasks passed from parent
    var taskIndex: Int                          // Position of the current task

    @State private var isEditing = false        // State for toggling between edit/save mode
    @State private var editedTask = ""         // State for storing the edited task text
    @State private var showDeleteAlert = false  // State to control delete confirmation alert

    @Environment(\.dismiss) var dismiss // Access dismiss environment action
    
    var body: some View {
        VStack(spacing: 20) {
            // Text showing the current task, allowing editing if in edit mode
            if isEditing {
                TextField("Edit Task", text: $editedTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.gray.opacity(0.1)) // Slight background color for the text field
                    .cornerRadius(10)
                    .font(.body) // Ensure text size adapts
            } else {
                Text("Task: \(selectedTask.title)")  // Display task title when not editing
                    .font(.title2)
                    .padding()
                    .fontWeight(.medium)  // Lighter weight for non-editing text
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color.blue.opacity(0.05))  // Soft background color
                    .cornerRadius(10)
                    .shadow(radius: 5) // Soft shadow effect
            }

            HStack(spacing: 20) {
                // Edit/Save Button
                Button(action: {
                    if isEditing {
                        selectedTask.title = editedTask
                        tasksArray[taskIndex] = selectedTask
                        saveTasks()  // Save tasks
                    } else {
                        editedTask = selectedTask.title
                    }
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isEditing.toggle()
                    }
                }) {
                    Label(isEditing ? "Save" : "Edit", systemImage: isEditing ? "checkmark.circle" : "pencil")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(isEditing ? Color.green : Color.blue)  // Change color based on state
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }

                // Delete Button
                Button(action: {
                    showDeleteAlert = true  // Trigger delete confirmation alert
                }) {
                    Label("Delete", systemImage: "trash")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
            }
            .padding()

            // Delete confirmation alert
            .alert("Are you sure?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    tasksArray.remove(at: taskIndex)  // Remove the task from the array
                    saveTasks()                       // Save updated tasks to UserDefaults
                    dismiss()                          // Dismiss the current screen
                }
                Button("Cancel", role: .cancel) {
                    // Do nothing, dismiss the alert
                }
            } message: {
                Text("This action cannot be undone.")  // Message in the alert
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Task Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Function to save the task array to UserDefaults
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasksArray) {
            UserDefaults.standard.set(encoded, forKey: "tasksKey")
        }
    }
}

#Preview {
    @State var sampleTasks = [
        TodoTask(title: "Buy groceries", isCompleted: false),
        TodoTask(title: "Call John", isCompleted: true),
        TodoTask(title: "Read SwiftUI docs", isCompleted: false)
    ]
    @State var selectedTask = TodoTask(title: "Buy groceries", isCompleted: false)

    NavigationView {    // ✅ No need for 'return'
        TaskDetailScreen(
            selectedTask: $selectedTask,
            tasksArray: $sampleTasks,
            taskIndex: 0
        )
    }
}
