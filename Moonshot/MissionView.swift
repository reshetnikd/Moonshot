//
//  MissionView.swift
//  Moonshot
//
//  Created by Dmitry Reshetnik on 07.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geometry in
                        Image(decorative: self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .padding(.top)
                            .accessibility(hidden: true)
                            .scaleEffect(geometry.frame(in: .global).midY / 220)
                    }
                    .frame(maxWidth: fullView.size.width * 0.7)
                    
                    Text(self.mission.formattedLaunchDate)
                        .font(.subheadline)
                        .padding()
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(decorative: crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(self.strokeColor(crewMember), lineWidth: 1))
                                    .accessibility(hidden: true)
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(crewMember.role == "Commander" ? .red : .secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func strokeColor(_ astronaut: CrewMember) -> Color {
        return astronaut.role == "Commander" ? Color.blue : Color.primary
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
