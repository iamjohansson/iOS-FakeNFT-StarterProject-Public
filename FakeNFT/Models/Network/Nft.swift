import Foundation

struct Nft: Decodable {
    let name: String
    let images: [URL]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let id: String
    let createdAt: String
    let isLiked: Bool?
    
    func update(newLiked: Bool) -> Nft {
        .init(
            name: name,
            images: images,
            rating: rating,
            description: description,
            price: price,
            author: author,
            id: id,
            createdAt: createdAt,
            isLiked: newLiked
        )
    }
}


