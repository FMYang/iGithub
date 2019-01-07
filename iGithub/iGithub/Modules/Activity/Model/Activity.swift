//
//  File.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import HandyJSON

struct Activity: HandyJSON  {
    var actor: Actor?
    var created_at: String?
    var id: Int?
    var org: Org?
    var payload: PayLoad?
    var repo: Repo?
    var type: EventType?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.created_at <-- TransformOf(fromJSON: { (rawString) -> String? in
                let timeNow = rawString?.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")?.timeFromNow()
                return timeNow
            }, toJSON: { (str) -> String? in
                return str
            })
    }
}

/// 用户信息
struct Actor: HandyJSON {
    var avatar_url: String?
    var display_login: String?
    var gravatar_id: String?
    var id: Int?
    var login: String?
    var url: String?
}

/// 组织信息
struct Org: HandyJSON {
    var avatar_url: String?
    var gravatar_id: String?
    var id: Int?
    var login: String?
    var url: String?
}

/// 仓库信息
struct Repo: HandyJSON {
    var id: Int?
    var name: String?
    var url: String?
}

/// 用户行为
struct PayLoad: HandyJSON {
    var action: String?
}

struct RepoDetail: HandyJSON {
    var description: String?
    var stargazers_count: Int = 0
    var language: String?
    var updated_at: String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.updated_at <-- TransformOf(fromJSON: { (rawString) -> String? in
                let timeNow = rawString?.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")?.timeFromNow()
                return timeNow
            }, toJSON: { (str) -> String? in
                return str
            })
    }
}

enum EventType: String, HandyJSONEnum {
    case fork = "ForkEvent"
    case commitComment = "CommitCommentEvent"
    case create = "CreateEvent"
    case issueComment = "IssueCommentEvent"
    case issues = "IssuesEvent"
    case member = "MemberEvent"
    case organizationBlock = "OrgBlockEvent"
    case `public` = "PublicEvent"
    case pullRequest = "PullRequestEvent"
    case pullRequestReviewComment = "PullRequestReviewCommentEvent"
    case push = "PushEvent"
    case release = "ReleaseEvent"
    case star = "WatchEvent"
    case unknown = ""
    
    var eventName: String {
        switch self {
        case .fork: return "fork"
        case .commitComment: return "commitComment"
        case .create: return "create"
        case .issueComment: return "issueComment"
        case .issues: return "issues"
        case .member: return "member"
        case .organizationBlock: return "organization"
        case .`public`: return "`public`"
        case .pullRequest: return "pullRequest"
        case .pullRequestReviewComment: return "pullRequestReviewComment"
        case .push: return "push"
        case .release: return "release"
        case .star: return "star"
        case .unknown: return "unknown"
        }
    }
}
