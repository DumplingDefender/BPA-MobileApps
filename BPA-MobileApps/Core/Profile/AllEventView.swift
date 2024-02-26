import SwiftUI

struct AllEventView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedEvent: Event?

    var body: some View {
        ZStack {
            Color.brown.edgesIgnoringSafeArea(.all)
            
            VStack {
                Group {
                    if let user = viewModel.currentUser {
                        List(viewModel.events) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
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
            .foregroundColor(.black)
        }
    }
}

struct EventDetailView: View {
    let event: Event
    @State private var weather: WeatherData?
    @State private var isLoading = false
    
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
                
                if let weather = weather {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Weather:")
                            .fontWeight(.bold)
                        Text("\(weather.weather[0].description)")
                    }
                } else {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Button("Fetch Weather") {
                            fetchWeatherData()
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(5)
                    }
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
        .onAppear {
            fetchWeatherData()
        }
    }
    
    private func fetchWeatherData() {
        guard let city = event.location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let apiKey = "f071383d0amshafb19bc2797b511p1e87d4jsn16278dd93771"
        let headers = [
            "X-RapidAPI-Key": "f071383d0amshafb19bc2797b511p1e87d4jsn16278dd93771",
            "X-RapidAPI-Host": "open-weather13.p.rapidapi.com"
        ]
        
        let url = URL(string: "https://open-weather13.p.rapidapi.com/city/\(city)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        isLoading = true
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                isLoading = false
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    weather = weatherData
                    isLoading = false
                }
            } catch {
                print(String(data: data, encoding: .utf8) ?? "Unable to parse data")
                isLoading = false
            }
        }.resume()
    }
    
    
    struct AllEventView_Previews: PreviewProvider {
        static var previews: some View {
            AllEventView().environmentObject(AuthViewModel())
        }
    }
    struct WeatherData: Codable {
        let weather: [WeatherInfo]
        
        struct WeatherInfo: Codable {
            let description: String
        }
    }
}
