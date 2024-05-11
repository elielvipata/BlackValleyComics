import SwiftUI
import Auth0
import CoreData

struct MainView: View {
    @State var user: User?
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn");
    
    
    var body: some View {
        if let user = self.user {
            VStack {
                ProfileView(profileUser: user)
//                Button("Logout", action: self.logout)
            }
        } else {
            VStack {
                HeroView()
                Button("Login", action: self.login)
            }
        }
    }
}

extension MainView {
    func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    self.user = User(from: credentials.idToken)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    self.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}

//#Preview {
//    MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

#Preview{
    MainView()
}
