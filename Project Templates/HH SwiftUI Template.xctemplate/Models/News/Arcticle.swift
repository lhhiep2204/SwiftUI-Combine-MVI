//___FILEHEADER___

import Foundation

struct Article: Decodable, Hashable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
