//
//  lastMsgContacs.swift
//  urChoice
//
//  Created by Mazhar on 2022-07-03.
//

import Foundation
struct lastMsgContacs : Codable {
    let status : Int?
    let message : String?
    let chats : [lastMessageChat]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case chats = "chats"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        chats = try values.decodeIfPresent([lastMessageChat].self, forKey: .chats)
    }

}
struct lastMessageChat : Codable {
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
    let user_fullname : String?
    let user_id : Int?
    let user_image_url : String?
    let user_flag_url : String?

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
        user_fullname = try values.decodeIfPresent(String.self, forKey: .user_fullname)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        user_image_url = try values.decodeIfPresent(String.self, forKey: .user_image_url)
        user_flag_url = try values.decodeIfPresent(String.self, forKey: .user_flag_url)
    }

}

