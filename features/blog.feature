#lang: en

Feature: Blog navigation

  Background: The blog has been configured
    Given the blog has been configured
      And some post locations have been added

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

  Scenario: Blog main page with a single page of posts
    #Given I have published a post
    #  And I have configured the blog home to show "1" post
    # When I visit the first page of the  blog home
    # Then I should see the published post

  Scenario: Blog main page with a two page of posts

