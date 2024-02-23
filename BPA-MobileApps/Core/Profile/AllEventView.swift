import SwiftUI

struct AllEventView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedEvent: Event?

    var body: some View {
        ZStack { // Use ZStack to place the background behind the content
            Color.brown.edgesIgnoringSafeArea(.all) // Set the background color
            
            VStack {
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
            .foregroundColor(.black) // Set text color to white for better visibility on black background
        }
    }
}

struct EventDetailView: View {
    let event: Event

    var body: some View {
        ZStack {
            Color.brown.edgesIgnoringSafeArea(.all) 
            VStack(alignment: .leading, spacing: 20) {
               
                Text(event.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date:")
                        .fontWeight(.bold)
                    Text("\(event.date)")
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Location:")
                        .fontWeight(.bold)
                    Text(event.location)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Description:")
                        .fontWeight(.bold)
                    Text(event.description)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding()
        .foregroundColor(.black)
        }
    }
}





struct AllEventView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventView().environmentObject(AuthViewModel())
    }
}
