//___FILEHEADER___

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let content: (AsyncImagePhase) -> Content
    
    init(url: URL,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }
    
    var body: some View {
        if let cached = ImageCache[self.url] {
            self.content(.success(cached))
        } else {
            AsyncImage(url: self.url) { phase in
                self.cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success (let image) = phase {
            ImageCache[self.url] = image
        }
        return content(phase)
    }
    
}

fileprivate class ImageCache {
    
    static var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
    
}
