#encoding: utf-8
#lang: en

Feature: Posting from a directory

  Scenario: A single post file in the directory
    Given I have a published post in the post directory
     When I configure the blog with that directory
     Then the post should appear in the blog

  Scenario: A directory with a post file and a non-post file
    Given I have a published post in the post directory
      And there is a file that is not a post in the directory
     When I configure the blog with that directory
     Then the post should appear in the blog
