#encoding: utf-8
#lang: en

Feature: Engine and blog configuration

  Scenario: Configuring an option
    Given I configure a new option with its value
     When I ask the configuration for the option
     Then I get the cofigured value

  Scenario: Accessing configuration options from the blog

  Scenario: Configuring post locations
    Given I have configured some locations
     When I create a blog with that configuration
     Then the blog takes its posts from the configured locations


