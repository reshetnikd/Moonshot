//
//  ContentView.swift
//  Moonshot
//
//  Created by Dmitry Reshetnik on 05.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showMode = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    if self.showMode {
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                            .font(.headline)
                            
                            ForEach(0..<mission.crew.count) { member in
                                Text(self.getAstronaut(name: mission.crew[member].name))
                            }
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showMode.toggle()
                }) {
                    Image(systemName: showMode ? "calendar.circle" : "person.crop.circle")
                }
            )
        }
    }
    
    func getAstronaut(name: String) -> String {
        return self.astronauts.first(where: { $0.id == name })?.name ?? "Failure"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
