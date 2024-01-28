//
//  ContentView.swift
//  BlackValleyComics
//
//  Created by Eliel Kilembo on 1/28/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    Text("Welcome! You are logged in.")
                    Button(action: {
                        self.logout()
                    }) {
                        Text("Logout")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                } else {
                       Text("Click here to login")
                       .font(.headline)
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            
        }
    }

    func login() {
        // Add your login logic here
        // For example, set isLoggedIn to true upon successful login
        isLoggedIn = true
    }

    func logout() {
        // Add your logout logic here
        // For example, set isLoggedIn to false upon logout
        isLoggedIn = false
    }
}

struct LoginView: View {
    var body: some View {
        TabView {
            FirstTabView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Tab 1")
                }

            SecondTabView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Tab 2")
                }
        }
    }
}

struct FirstTabView: View {
    var body: some View {
        Text("Content for Tab 1")
    }
}

struct SecondTabView: View {
    var body: some View {
        Text("Content for Tab 2")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
