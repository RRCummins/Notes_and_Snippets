//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Ryan Cummins on 6/4/21.
//

import SwiftUI

struct ProfileView: View {
    @State var profileNote: String
    @State var characterCount: Int
    
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""
    
    var body: some View {
        VStack {
            //Title
            //Info Box
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(height: 130, alignment: .center)
                    .cornerRadius(12)
                    .padding()
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                            .offset(y: 28)
                    }
                    .padding(.leading, 12)
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        TextField("Company Name", text: $companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            //Text Box
            VStack(alignment: .leading, spacing: 8) {
                //Text Access
                HStack {
                    HStack {
                        Text("Bio: ")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text(String(100 - bio.count))
                            .bold()
                            .font(.callout)
                            .foregroundColor(bio.count <= 50 ? .brandPrimary : Color(.systemPink))
                        Text(" Characters remain")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .font(.callout)
                    .foregroundColor(.secondary
                    )
                    Button {
                        
                    } label: {
                        Label("Check Out", systemImage: "mappin.and.ellipse")
                    }
                    .foregroundColor(.pink)
                }
                
                TextEditor(text: $bio)
                    .frame(height: 130, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1))
            }
            .padding(.horizontal, 16)
            
            //Button
            Spacer()
            Button {
                
            } label: {
                Text("Create Profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profileNote: "Lorem ipsum", characterCount: 35)
        }
    }
}
