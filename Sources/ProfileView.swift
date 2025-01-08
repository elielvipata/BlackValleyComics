import SwiftUI
import Alamofire
import AlamofireImage

let testUser = User(id: "TestId", name: "TestUsername", email: "email@gmail.com", emailVerified: "true", picture: "pictures", updatedAt: "home")



struct ProfileView: View {
    let profileUser : User

    var body: some View {
        TabView {
            HomeView(user:profileUser)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Latest Issues")
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
    @State var latestIssues:[Issue] = []
    @State private var selectedIssue: Issue? = nil

    
    init(user:User){
        self.user = user
        self.apiHandler = ApiHandler()
        self.apiHandler.sendUserData(profileUser: user)
    }
    
    var body: some View {
            VStack {
                List(self.latestIssues, id: \.self) { item in
                    HStack {
                        AsyncImage(url: URL(string: (item.series?.cover)!)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .padding(0)
                            Spacer()
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading) {
                            Text(item.series?.title ?? "null")
                                .font(.headline)
                                .padding(0)
                            Text(item.issueDetails?.title ?? "null")
                            Text(item.releaseDate ?? "n/a")
                        }
                        .background(Color.white) // Remove the delimiter
                        .listRowSeparator(.hidden)
                    }
                    .onTapGesture {
                        // Print the item ID and update selectedIssue
                        print(item.id)
                        selectedIssue = item
                    }
                }
                
                if(selectedIssue != nil){
                    ComicView(issue: selectedIssue)
                        .padding()
                }

            }
            .onAppear {
                // Call the API to get the latest issues when the view appears
                self.apiHandler.getLatest { (responseData) in
                    DispatchQueue.main.async {
                        for issue in responseData! {
                            self.latestIssues.append(Issue(dictionary: issue))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
}

// SwiftUI view for loading remote images using AlamofireImage
struct RemoteImage: View {
    let url: URL
    
    var body: some View {
        // Use an image view with AlamofireImage
        ImageView(url: url)
            .aspectRatio(contentMode: .fit)
    }
}

// Wrapper view around UIImageView with AlamofireImage
struct ImageView: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: URL) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                // Placeholder or loading indicator
                // You can customize this as per your requirement
                ProgressView()
            }
        }
    }
}

// Image loader class using AlamofireImage
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    init(url: URL) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        AF.request(url).responseImage { response in
            if case .success(let downloadedImage) = response.result {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
        }
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

