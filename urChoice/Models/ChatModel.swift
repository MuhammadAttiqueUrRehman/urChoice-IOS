

import Foundation
struct ChatModel : Codable {
	let status : Int?
	let message : String?
	let chats : [Chats]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case chats = "chats"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		chats = try values.decodeIfPresent([Chats].self, forKey: .chats)
	}

}
struct Chats : Codable {
    let id : Int?
    let message_id : Int?
    let sender_id : Int?
    let receiver_belong_to_model : String?
    let receiver_belong_to_model_id : Int?
    let type : String?
    let seen_status : String?
    let deliver_status : String?
    let created_at : String?
    let updated_at : String?
    let files : [FilesMsg]?
    let user_message : String?
    let user_receive : String?
    let user_fullname : String?
    let user_id : Int?
    let user_image_url : String?
    let user_flag_url : String?
    var messageType = ""

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case message_id = "message_id"
        case sender_id = "sender_id"
        case receiver_belong_to_model = "receiver_belong_to_model"
        case receiver_belong_to_model_id = "receiver_belong_to_model_id"
        case type = "type"
        case seen_status = "seen_status"
        case deliver_status = "deliver_status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case files = "files"
        case user_message = "user_message"
        case user_receive = "user_receive"
        case user_fullname = "user_fullname"
        case user_id = "user_id"
        case user_image_url = "user_image_url"
        case user_flag_url = "user_flag_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        message_id = try values.decodeIfPresent(Int.self, forKey: .message_id)
        sender_id = try values.decodeIfPresent(Int.self, forKey: .sender_id)
        receiver_belong_to_model = try values.decodeIfPresent(String.self, forKey: .receiver_belong_to_model)
        receiver_belong_to_model_id = try values.decodeIfPresent(Int.self, forKey: .receiver_belong_to_model_id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        seen_status = try values.decodeIfPresent(String.self, forKey: .seen_status)
        deliver_status = try values.decodeIfPresent(String.self, forKey: .deliver_status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        files = try values.decodeIfPresent([FilesMsg].self, forKey: .files)
        user_message = try values.decodeIfPresent(String.self, forKey: .user_message)
        user_receive = try values.decodeIfPresent(String.self, forKey: .user_receive)
        user_fullname = try values.decodeIfPresent(String.self, forKey: .user_fullname)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        user_image_url = try values.decodeIfPresent(String.self, forKey: .user_image_url)
        user_flag_url = try values.decodeIfPresent(String.self, forKey: .user_flag_url)
       
    }

}
struct FilesMsg : Codable {
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

struct sendMessageModel : Codable {
    let status : Int?
    let message : String?
    let chats : Chats?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case chats = "chat"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        chats = try values.decodeIfPresent(Chats.self, forKey: .chats)
    }

}


