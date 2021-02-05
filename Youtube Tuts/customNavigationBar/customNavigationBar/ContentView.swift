//
//  ContentView.swift
//  customNavigationBar
//
//  Created by Ryan Cummins on 12/16/20.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            // This NavigationView is just a formality
            NavigationView{
                Text("")
            }
            .navigationTitle("This will be hidden")
            .navigationBarHidden(true)
            Color.gray.edgesIgnoringSafeArea(.all)
            NavigationLink(destination: DestinationView(isDestination: true)){
                Text("Home!")
            }
            CustomNavigationView(isDestination: false, title: "Home", buttons: [])
        }
    }
}

struct DestinationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var isDestination = false
    
    var body: some View {
        
        let buttons = [
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "magnifyingglass.circle.fill")
            }),
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "plus.circle.fill")
            })
        ]
        
        
        ZStack{
            // This NavigationView is just a formality
            NavigationView{
                Text("")
            }
            .navigationTitle("This will be hidden")
            .navigationBarHidden(true)
            Color.blue.edgesIgnoringSafeArea(.all)
            Text("We are at the Destination")
            CustomNavigationView(isDestination: isDestination, buttons: buttons)
        }
    }
}

struct CustomNavigationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //    self.presentationMode.wrappedValue.dismiss()
    
    var isDestination = false
    
    var title = "Events"
    var buttons:[Button<Image>]
    
    var body: some View {
        VStack{
            HStack{
                if isDestination {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    })
                }
                Text(title)
                    .font(.system(size: 35, weight: .bold))
                Spacer()
                ForEach(0..<buttons.count) { i in
                    self.buttons[i]
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                }
            }.padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView()
    }
}
