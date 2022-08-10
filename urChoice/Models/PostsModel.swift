
import Foundation
struct PostsModel : Codable {
	let status : Int?
	let message : String?
	let posts : [Posts]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case posts = "posts"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		posts = try values.decodeIfPresent([Posts].self, forKey: .posts)
	}

}
struct Files : Codable {
    let type : String?
    let full_url : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case full_url = "full_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        full_url = try values.decodeIfPresent(String.self, forKey: .full_url)
    }

}
struct Posts : Codable {
    let id : Int?
    let user_id : Int?
    let post_date : String?
    let post_text : String?
    let type : String?
    var total_likes : Int?
    let total_comments : Int?
    let total_shares : Int?
    let shared_post_id : String?
    let privacy : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let user_fullname : String?
    let user_user_id : Int?
    let user_img_url : String?
    var isLiked : Bool?
    let shared_post : String?
    let files : [Files]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case post_date = "post_date"
        case post_text = "post_text"
        case type = "type"
        case total_likes = "total_likes"
        case total_comments = "total_comments"
        case total_shares = "total_shares"
        case shared_post_id = "shared_post_id"
        case privacy = "privacy"
        case deleted_at = "deleted_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case user_fullname = "user_fullname"
        case user_user_id = "user_user_id"
        case user_img_url = "user_img_url"
        case isLiked = "isLiked"
        case shared_post = "shared_post"
        case files = "files"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        post_date = try values.decodeIfPresent(String.self, forKey: .post_date)
        post_text = try values.decodeIfPresent(String.self, forKey: .post_text)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        total_likes = try values.decodeIfPresent(Int.self, forKey: .total_likes)
        total_comments = try values.decodeIfPresent(Int.self, forKey: .total_comments)
        total_shares = try values.decodeIfPresent(Int.self, forKey: .total_shares)
        shared_post_id = try values.decodeIfPresent(String.self, forKey: .shared_post_id)
        privacy = try values.decodeIfPresent(String.self, forKey: .privacy)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        user_fullname = try values.decodeIfPresent(String.self, forKey: .user_fullname)
        user_user_id = try values.decodeIfPresent(Int.self, forKey: .user_user_id)
        user_img_url = try values.decodeIfPresent(String.self, forKey: .user_img_url)
        isLiked = try values.decodeIfPresent(Bool.self, forKey: .isLiked)
        shared_post = try values.decodeIfPresent(String.self, forKey: .shared_post)
        files = try values.decodeIfPresent([Files].self, forKey: .files)
    }

}


