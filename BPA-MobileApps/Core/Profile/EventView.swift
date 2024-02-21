import SwiftUI

struct Event: Codable {
    var title: String
    var date: Date
    var location: String
    var description: String
}

struct EventFormView: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var location = ""
    @State private var description = ""
    @EnvironmentObject var viewModel: AuthViewModel


    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                Form {
                    Section(header: Text("Event Details")) {
                        TextField("Title", text: $title)
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                        TextField("Location", text: $location)
                        TextEditor(text: $description)
                            .frame(height: 100)
                    }
                    
                    Section {
                        Button(action: saveEvent) {
                            Text("Save Event")
                        }
                        .disabled(title.isEmpty || location.isEmpty || description.isEmpty)
                    }
                }
                .navigationTitle("New Event")
            }
        }
    }

    func saveEvent() {
        let newEvent = Event(title: title, date: date, location: location, description: description)
          viewModel.saveEvent(event: newEvent)
          // Reset form fields
          title = ""
          date = Date()
          location = ""
          description = ""
//        let newEvent = Event(title: title, date: date, location: location, description: description)
//        // Do something with the new event, like saving it to a list
//        print("New event created: \(newEvent)")
//        // Reset form fields
//        title = ""
//        date = Date()
//        location = ""
//        description = ""
    }
}

struct EventFormView_Previews: PreviewProvider {
    static var previews: some View {
        EventFormView()
    }
}
