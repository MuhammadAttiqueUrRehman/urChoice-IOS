

import Foundation
struct SignUpModel : Codable {
	let status : Int?
	let message : String?
	let user : User?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		user = try values.decodeIfPresent(User.self, forKey: .user)
	}

}
struct User_languages : Codable {
    let language_id : Int?
    let language_name : String?

    enum CodingKeys: String, CodingKey {

        case language_id = "language_id"
        case language_name = "language_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        language_id = try values.decodeIfPresent(Int.self, forKey: .language_id)
        language_name = try values.decodeIfPresent(String.self, forKey: .language_name)
    }

}
struct User : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let email : String?
    let phone : String?
    let username : String?
    let auth_token : String?
    let device_token : String?
    let type : String?
    let phone_verified_at : String?
    let email_verified_at : String?
    let deactivated_at : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let is_friend : Int?
    let is_follow : Int?
    let is_block : Int?
    let is_like : Int?
    let is_heart : Int?
    let user_img_url : String?
    let user_name : String?
    let user_about : String?
    let user_nickname : String?
    let user_gender : String?
    let user_dob : String?
    let user_address : String?
    let user_total_likes : Int?
    let user_total_hearts : Int?
    let user_total_gems : Int?
    let user_country_code : String?
    let user_country_name : String?
    let user_flag_url : String?
    let user_interests : [Int]?
    let user_languages : [User_languages]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case phone = "phone"
        case username = "username"
        case auth_token = "auth_token"
        case device_token = "device_token"
        case type = "type"
        case phone_verified_at = "phone_verified_at"
        case email_verified_at = "email_verified_at"
        case deactivated_at = "deactivated_at"
        case deleted_at = "deleted_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case is_friend = "is_friend"
        case is_follow = "is_follow"
        case is_block = "is_block"
        case is_like = "is_like"
        case is_heart = "is_heart"
        case user_img_url = "user_img_url"
        case user_name = "user_name"
        case user_about = "user_about"
        case user_nickname = "user_nickname"
        case user_gender = "user_gender"
        case user_dob = "user_dob"
        case user_address = "user_address"
        case user_total_likes = "user_total_likes"
        case user_total_hearts = "user_total_hearts"
        case user_total_gems = "user_total_gems"
        case user_country_code = "user_country_code"
        case user_country_name = "user_country_name"
        case user_flag_url = "user_flag_url"
        case user_interests = "user_interests"
        case user_languages = "user_languages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        auth_token = try values.decodeIfPresent(String.self, forKey: .auth_token)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        phone_verified_at = try values.decodeIfPresent(String.self, forKey: .phone_verified_at)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        deactivated_at = try values.decodeIfPresent(String.self, forKey: .deactivated_at)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        is_friend = try values.decodeIfPresent(Int.self, forKey: .is_friend)
        is_follow = try values.decodeIfPresent(Int.self, forKey: .is_follow)
        is_block = try values.decodeIfPresent(Int.self, forKey: .is_block)
        is_like = try values.decodeIfPresent(Int.self, forKey: .is_like)
        is_heart = try values.decodeIfPresent(Int.self, forKey: .is_heart)
        user_img_url = try values.decodeIfPresent(String.self, forKey: .user_img_url)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        user_about = try values.decodeIfPresent(String.self, forKey: .user_about)
        user_nickname = try values.decodeIfPresent(String.self, forKey: .user_nickname)
        user_gender = try values.decodeIfPresent(String.self, forKey: .user_gender)
        user_dob = try values.decodeIfPresent(String.self, forKey: .user_dob)
        user_address = try values.decodeIfPresent(String.self, forKey: .user_address)
        user_total_likes = try values.decodeIfPresent(Int.self, forKey: .user_total_likes)
        user_total_hearts = try values.decodeIfPresent(Int.self, forKey: .user_total_hearts)
        user_total_gems = try values.decodeIfPresent(Int.self, forKey: .user_total_gems)
        user_country_code = try values.decodeIfPresent(String.self, forKey: .user_country_code)
        user_country_name = try values.decodeIfPresent(String.self, forKey: .user_country_name)
        user_flag_url = try values.decodeIfPresent(String.self, forKey: .user_flag_url)
        user_interests = try values.decodeIfPresent([Int].self, forKey: .user_interests)
        user_languages = try values.decodeIfPresent([User_languages].self, forKey: .user_languages)
    }

}


