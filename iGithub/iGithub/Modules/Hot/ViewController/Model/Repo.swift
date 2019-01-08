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
    public var pullsUrl: String?
    public var subscribersUrl: String?
    public var tagsUrl: String?
    public var openIssues: Int?
    public var hasProjects: Bool? = false
    public var cloneUrl: String?
    public var size: Int?
    public var gitUrl: String?
    public var gitTagsUrl: String?
    public var id: Int?
    public var defaultBranch: String?
    public var issueEventsUrl: String?
    public var hasPages: Bool? = false
    public var archived: Bool? = false
    public var commentsUrl: String?
    public var homepage: String?
    public var teamsUrl: String?
    public var url: String?
    public var downloadsUrl: String?
    public var hooksUrl: String?
    public var htmlUrl: String?
    public var issuesUrl: String?
    public var fullName: String?
    public var fork: Bool? = false
    public var descriptionValue: String?
    public var license: License?
    public var notificationsUrl: String?
    public var sshUrl: String?
    public var stargazersCount: Int?
    public var issueCommentUrl: String?
    public var compareUrl: String?
    public var languagesUrl: String?
    public var watchers: Int?
    public var milestonesUrl: String?
    public var branchesUrl: String?
    public var collaboratorsUrl: String?
    public var hasIssues: Bool? = false
    public var archiveUrl: String?
    public var forks: Int?
    public var createdAt: String?
    public var assigneesUrl: String?
    public var openIssuesCount: Int?
    public var labelsUrl: String?
    public var forksCount: Int?
    public var eventsUrl: String?
    public var blobsUrl: String?
    public var hasDownloads: Bool? = false
    public var svnUrl: String?
    public var forksUrl: String?
    public var isPrivate: Bool? = false
    public var releasesUrl: String?
    public var language: String?
    public var pushedAt: String?
    public var contentsUrl: String?
    public var statusesUrl: String?
    public var owner: Owner?
    public var gitRefsUrl: String?
    public var stargazersUrl: String?
    public var name: String?
    public var contributorsUrl: String?
    public var score: Int?
    public var subscriptionUrl: String?
    public var updatedAt: String?
    public var treesUrl: String?
    public var keysUrl: String?
    public var hasWiki: Bool? = false
    public var gitCommitsUrl: String?
    public var commitsUrl: String?
    public var watchersCount: Int?
    public var deploymentsUrl: String?
    public var mergesUrl: String?
    public var nodeId: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.isPrivate <-- "private"
    }
}

struct Owner: HandyJSON {
    public var organizationsUrl: String?
    public var reposUrl: String?
    public var htmlUrl: String?
    public var siteAdmin: Bool? = false
    public var gravatarId: String?
    public var starredUrl: String?
    public var avatarUrl: String?
    public var type: String?
    public var gistsUrl: String?
    public var login: String?
    public var followersUrl: String?
    public var id: Int?
    public var subscriptionsUrl: String?
    public var followingUrl: String?
    public var receivedEventsUrl: String?
    public var nodeId: String?
    public var url: String?
    public var eventsUrl: String?
}

struct License: HandyJSON {
    public var name: String?
    public var spdxId: String?
    public var nodeId: String?
    public var key: String?
    public var url: String?
}
