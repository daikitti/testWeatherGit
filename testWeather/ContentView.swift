//
//  ContentView.swift
//  testWeather
//
//  Created by Have Dope on 19.06.2023.
//

import SwiftUI
import Foundation
import SDWebImageSwiftUI


class GetJsonWeather{
    
    static let shared = GetJsonWeather()
    
    @State var urlIcon = ""
    
    private init(){
        getJson()
        
    }
    
    
    func getJson(){
        
        let urlString = "https://api.weather.yandex.ru/v2/informers?lat=50.2796100&lon=127.5405000"
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.addValue("6f590fdb-7929-404d-9541-069ac0468e10", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, request, error in
            guard let data = data else {
                print(String(describing: error?.localizedDescription))
                return
            }
            
            guard let weatherData = try? JSONDecoder().decode(WeatherJSONStruct.self, from: data) else {return}
            print("\(weatherData.fact.temp)")
            print("\(weatherData.fact.icon)")
            self.urlIcon = (weatherData.fact.icon)
        }
        task.resume()
        
    }
    
    
}


struct ContentView: View {
    init(){GetJsonWeather.shared.getJson()
    }
    var body: some View {
        VStack {

            Text(Благовещенск)
        
            Button {
                GetJsonWeather.shared.getJson()
            } label: {
                Text("Hello, world!")

            }

        }
        
        
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
