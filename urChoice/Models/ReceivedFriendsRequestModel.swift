/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ReceivedFriendsRequestModel : Codable {
	let status : Int?
	let message : String?
	let friendRequests : [ReceivedFriendRequests]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case friendRequests = "friendRequests"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		friendRequests = try values.decodeIfPresent([ReceivedFriendRequests].self, forKey: .friendRequests)
	}

}
struct ReceivedFriendRequests : Codable {
    let id : Int?
    let user_id : Int?
    let action : String?
    let text : String?
    let reaction_by : Int?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let reaction_user_fullname : String?
    let reaction_user_user_id : Int?
    let reaction_user_img_url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case action = "action"
        case text = "text"
        case reaction_by = "reaction_by"
        case deleted_at = "deleted_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case reaction_user_fullname = "reaction_user_fullname"
        case reaction_user_user_id = "reaction_user_user_id"
        case reaction_user_img_url = "reaction_user_img_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        action = try values.decodeIfPresent(String.self, forKey: .action)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        reaction_by = try values.decodeIfPresent(Int.self, forKey: .reaction_by)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        reaction_user_fullname = try values.decodeIfPresent(String.self, forKey: .reaction_user_fullname)
        reaction_user_user_id = try values.decodeIfPresent(Int.self, forKey: .reaction_user_user_id)
        reaction_user_img_url = try values.decodeIfPresent(String.self, forKey: .reaction_user_img_url)
    }

}

