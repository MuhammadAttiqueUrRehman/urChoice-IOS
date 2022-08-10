
import Foundation
struct PrivateContactsModel : Codable {
	let status : Int?
	let message : String?
	let users : [PrivateUsers]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case users = "users"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		users = try values.decodeIfPresent([PrivateUsers].self, forKey: .users)
	}

}
struct PrivateUsers : Codable {
    let id : Int?
    let user_exist : String?
    let user_name : String?
    let user_img_url : String?
    let phone : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_exist = "user_exist"
        case user_name = "user_name"
        case user_img_url = "user_img_url"
        case phone = "phone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_exist = try values.decodeIfPresent(String.self, forKey: .user_exist)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        user_img_url = try values.decodeIfPresent(String.self, forKey: .user_img_url)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }

}

