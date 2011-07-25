#lang: en

Feature: Blog navigation

  Background: The blog has been configured
    Given the blog has been configured
      And some post locations have been added

  Scenario: Blog main page
    Given I have published a post
      And I have configured the blog to show 1 post per page
     When I visit the blog's main page
     Then I should see the published post

  Scenario: Blog's main page with one page of posts
    Given I have published 2 posts
      And I have configured the blog to show 2 post per page
     When I visit the blog's main page
     Then I should see post 1
      And I should see post 2

  Scenario: Blog main page with more than a page of posts
    Given I have published 2 posts
      And I have configured the blog to show 1 post per page
     When I visit the blog's main page
     Then I should see post 1
      But I should not see post 2

  @wip
  Scenario: Second page of posts
    Given I have published 2 posts
      And I have configured the blog to show 1 post per page
     When I visit the page 2
     Then I should see post 2
      But I should not see post 1

  @pending
  Scenario: Blog pages without configuring posts per page

  Scenario: Single post page with published post
    Given I have published a post
     When I visit that post's page
     Then I should see the published post

  Scenario: Single post page with not published post
    Given I scheduled a post that has not been published yet
     When I visit that post's page
     Then I should get that page doesn't exist error

  Scenario: Single post page unknown post
     When I visit an unknown post's page
     Then I should get that page doesn't exist error

  @pending
  Scenario: Single post page for two posts with the same title
