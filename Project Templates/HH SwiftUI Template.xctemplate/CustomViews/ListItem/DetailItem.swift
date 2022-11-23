//___FILEHEADER___

import SwiftUI

struct DetailItem: View {
    
    let article: Article
    
    var body: some View {
        self.containerView
    }
    
}

// MARK: - Views
extension DetailItem {
    
    private var containerView: some View {
        VStack(alignment: .leading) {
            Text(self.article.title ?? "")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 5)
            Text(self.article.description ?? "")
                .font(.system(size: 16))
            self.readMoreView
            self.imageView
        }
    }
    
    private var imageView: some View {
        CacheAsyncImage(url: URL(string: self.article.urlToImage ?? "")!) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 16)
            case .failure(_):
                EmptyView()
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                .padding(.bottom, 16)
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var readMoreView: some View {
        VStack {
            if let url = self.article.url {
                Text(.init("[Read more](\(url))"))
                    .font(.system(size: 15))
            } else {
                EmptyView()
            }
        }
    }
    
}

struct DetailItem_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailItem(article: Article(author: "Jon Fingas",
                                    title: "Modders thought it would be fun to make a folding iPhone",
                                    description: "You don\'t have wait for Apple to see what a foldable iPhone would look like in practice. China-based The Aesthetics of Science and Technology (AST) claims to have built a folding iPhone through heavy modifications. The engineers say they created the one-off w…",
                                    url: "https://www.engadget.com/folding-iphone-unofficial-171559538.html",
                                    urlToImage: "https://s.yimg.com/os/creatr-uploaded-images/2022-11/5183fe30-6048-11ed-aed0-07edb649475b",
                                    publishedAt: "2022-11-09T17:15:59Z"))
    }
    
}
