#lang: en

Feature: The post file format used by mog

  The post file format of mog posts is simple.
  It doesn't require more markup than the markup you want to use. The posts
  will be written in a very natural way.

  You only have to take care of the HTML mark up you want to use and respect
  a simple rule: write things in order.

  It is really, really simple. The only thing you need to know is that the
  file will be splitted into three parts:

    - Title
    - Description
    - Content

  The first line with text in the file will be taken as the post title.
  It should be short and contain no markup.

  The second line with text will be taken as the post description. It should
  also be short, usually up to 160 characters. You can not use markup in the
  post description.

  The rest of the file will be taken as the post content. You can use markup
  in it and make it as long as you want it to be.

  Scenario: A correctly formatted post
    Given a post file with the content:
      """

      The post title.

      The post description.

      The first line of the post content.

      The second line of the post content.

      """
    When a post is created from that file
    Then the post title should be "The post title."
     And the post description should be "The post description."
     And the post content should contain "The first line of the post content."
     And the post content should contain "The second line of the post content."
