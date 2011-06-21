#encoding: utf-8
#lang: en

Feature: Posting from a directory

  Scenario: A single post file in the directory
    Given I have a published post in the post directory
     When I configure the blog with that directory
     Then the blog should appear in the blog
