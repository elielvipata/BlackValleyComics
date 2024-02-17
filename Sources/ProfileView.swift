import SwiftUI

let testUser = User(id: "TestId", name: "TestUsername", email: "email@gmail.com", emailVerified: "true", picture: "pictures", updatedAt: "home")

struct ProfileView: View {
    let profileUser : User

    var body: some View {
        TabView {
            HomeView(user:profileUser)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Home")
                }

            Favorites()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Favorites")
                }
            Downloads()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Downloads")
                }
            Purchases()
                .tabItem {
                    Image(systemName: "4.circle")
                    Text("Purchases")
                }
            Account()
                .tabItem {
                    Image(systemName: "5.circle")
                    Text("Account")
                }
        }
    }
}


#Preview{
    ProfileView(profileUser:testUser)
}

struct HomeView: View {
    let user:User
    let apiHandler:ApiHandler
    @State private var data:[[String:Any?]] = []
    
    init(user:User){
        self.user = user
        self.apiHandler = ApiHandler()
        self.apiHandler.sendUserData(profileUser: user)
    }
    
    func getLatestIssues() {
          apiHandler.getLatest { (responseData) in
              DispatchQueue.main.async {
                  self.data = responseData!
              }
          }
      }
    
    var body: some View {
        
        Button("Load latest", action: getLatestIssues)

//        let data = (1...10).map { "Item \($0)" }
//        VStack {
//            List(data, id: \.self) { item in
//                Image(item)
//                    .padding()
//                    .border(Color.gray)
//            }
//
//            Spacer() // Add spacer to fill remaining space
//        }
    }
}

struct Favorites: View {
    var body: some View {
        Text("Content for Tab 2")
    }
}

struct Downloads: View {
    var body: some View {
        Text("Content for Tab 2")
    }
}

struct Purchases: View {
    var body: some View {
        Text("Content for Tab 4")
    }
}

struct Account: View {
    var body: some View {
        Text("Content for Tab 5")
    }
}

