import SwiftUI

struct AllEventView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedEvent: Event?

    var body: some View {
        Group {
            if let user = viewModel.currentUser {
                List(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(event: event), tag: event, selection: $selectedEvent) {
                        Text(event.title)
                    }
                }
                .onAppear {
                    viewModel.fetchData()
                }
            } else {
                Text("User not found")
            }
        }
    }
}

struct EventDetailView: View {
    let event: Event

    var body: some View {
        // Display detailed data of the selected event
        Text("Event: \(event.title)")
            .bold()
        Text("Date: \(event.date)")
        Text("Location: \(event.location)")
        Text("Description: \(event.description)")

    }
}

struct AllEventView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventView().environmentObject(AuthViewModel())
    }
}
