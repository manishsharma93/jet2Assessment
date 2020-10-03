
import Foundation
struct ArticleResponse : Codable {
	var id : String?
	var createdAt : String?
	var content : String?
	var comments : Int?
	var likes : Int?
	var media : [Media]?
	var user : [User]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case createdAt = "createdAt"
		case content = "content"
		case comments = "comments"
		case likes = "likes"
		case media = "media"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		comments = try values.decodeIfPresent(Int.self, forKey: .comments)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		media = try values.decodeIfPresent([Media].self, forKey: .media)
		user = try values.decodeIfPresent([User].self, forKey: .user)
	}

}
