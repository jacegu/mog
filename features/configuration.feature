#encoding: utf-8
#lang: en

Feature: Engine and blog configuration

  @wip
  Scenario: Configuring an option
    Given I configure a new option with its value
     When I ask the configuration for the option
     Then I get the cofigured value

  Scenario: Configuring post locations

  Scenario: Accessing congfiguration from the blog
