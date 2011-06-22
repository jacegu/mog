#encoding: utf-8
#lang: en

Feature: Engine and blog configuration

  Scenario: Configuring an option
    Given I configure a new option with its value
     When I ask the configuration for the option
     Then I get the cofigured value

  Scenario: Configuring locations

  Scenario: Accessing configuration options from the blog
    Given I configure a new option with its value
     When I create a blog with that configuration
     Then I should be able to access that option as a blog method

  Scenario: Accessing blog configuration options from the blog
    Given I configure an option with the name "blog_name" and the value "mog"
     When I create a blog with that configuration
     Then I should be able to access that option as a blog method named "name"

  Scenario: Accessing the post locations from the blog
    Given I have configured some locations
     When I create a blog with that configuration
     Then the blog takes its posts from the configured locations


