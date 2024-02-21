import SwiftUI

struct AllEventView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        if let user = viewModel.currentUser {
            List(viewModel.events) { event in
                Text(event.title)
            }
            .onAppear {
                viewModel.fetchData()
            }
        } else {
            Text("User not found")
        }
    }
}


struct AllEventView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventView()
    }
}
