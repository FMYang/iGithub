//
//  Repo.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import HandyJSON

struct RepoModel: HandyJSON {
    var items: [RepoItem]?
    var total_count: Int?
}

struct RepoItem: HandyJSON {
    public var pulls_url: String?
    public var subscribers_url: String?
    public var tags_url: String?
    public var open_issues: Int?
    public var has_projects: Bool? = false
    public var clone_url: String?
    public var size: Int?
    public var git_url: String?
    public var git_tags_url: String?
    public var id: Int?
    public var default_branch: String?
    public var issue_events_url: String?
    public var has_pages: Bool? = false
    public var archived: Bool? = false
    public var comments_url: String?
    public var homepage: String?
    public var teams_url: String?
    public var url: String?
    public var downloads_url: String?
    public var hooks_url: String?
    public var html_url: String?
    public var issues_url: String?
    public var full_name: String?
    public var fork: Bool? = false
    public var description: String?
    public var license: License?
    public var notifications_url: String?
    public var ssh_url: String?
    public var stargazers_count: Int?
    public var issue_comment_url: String?
    public var compare_url: String?
    public var languages_url: String?
    public var watchers: Int?
    public var milestones_url: String?
    public var branches_url: String?
    public var collaborators_url: String?
    public var has_issues: Bool? = false
    public var archive_url: String?
    public var forks: Int?
    public var created_at: String?
    public var assignees_url: String?
    public var open_issues_count: Int?
    public var labels_url: String?
    public var forks_count: Int?
    public var events_url: String?
    public var blobs_url: String?
    public var has_downloads: Bool? = false
    public var svn_url: String?
    public var forks_url: String?
    public var isPrivate: Bool? = false
    public var releases_url: String?
    public var language: String?
    public var pushed_at: String?
    public var contents_url: String?
    public var statuses_url: String?
    public var owner: Owner?
    public var git_refs_url: String?
    public var stargazers_url: String?
    public var name: String?
    public var contributors_url: String?
    public var score: Int?
    public var subscription_url: String?
    public var updated_at: String?
    public var trees_url: String?
    public var keys_url: String?
    public var has_wiki: Bool? = false
    public var git_commits_url: String?
    public var commits_url: String?
    public var watchers_count: Int?
    public var deployments_url: String?
    public var merges_url: String?
    public var node_id: String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.isPrivate <-- "private"
        
        mapper <<<
            self.updated_at <-- TransformOf(fromJSON: { (rawString) -> String? in
                let timeNow = "Updated " + (rawString?.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")?.timeFromNow() ?? "")
                return timeNow
            }, toJSON: { (str) -> String? in
                return str
            })
    }

}

struct Owner: HandyJSON {
    public var organizations_url: String?
    public var repos_url: String?
    public var html_url: String?
    public var site_admin: Bool? = false
    public var gravatar_id: String?
    public var starred_url: String?
    public var avatar_url: String?
    public var type: String?
    public var gists_url: String?
    public var login: String?
    public var followers_url: String?
    public var id: Int?
    public var subscriptions_url: String?
    public var following_url: String?
    public var received_events_url: String?
    public var node_id: String?
    public var url: String?
    public var events_url: String?
}

struct License: HandyJSON {
    public var name: String?
    public var spdx_id: String?
    public var node_id: String?
    public var key: String?
    public var url: String?
}
