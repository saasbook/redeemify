"Connextra" format

As a [kind of stakeholder],
So that [I can achieve some goal],
I want to [do some task]

Narrative description: As a [role], I want [feature], so that I [benefit]

Examples:

See which of my friends are going to a show
– As a theatergoer
– So that I can enjoy the show with my friends
– I want to see which of my Facebook friends are attending a given show

Every feature story should include an "As a / I want to / Because" block, 
which illustrates the motivation behind a story.
Some people prefer "So that" instead of "Because", but in most cases "Because"
helps drive out motivation — the Final Cause — whereas "So that" may only
drive out the Effective Cause, which is less useful for understanding the story. 

Example:

Feature: Shopping Cart
  As a Shopper
  I want to put items in my shopping cart
  Because I want to manage items before I check out

Every story title should include the word "should". NEVER use the word "can"

User story refers to single feature

Feature has ≥1 scenarios that show different ways a feature is used

Scenario has 3-8 steps that describe scenario

1.Given steps represent state of world before event: preconditions
2.When steps represent event – e.g., simulate user pushing a button
3.Then steps represent expected postconditions; check if true
4/5. And & But extend previous step

Useful articles

Cucumber anti-patterns (part one)
https://cucumber.io/blog/2016/07/01/cucumber-antipatterns-part-one

Cucumber anti-patterns (part two)
https://cucumber.io/blog/2016/08/31/cucumber-anti-patterns-part-two

Writing Better Cucumber Scenarios; or, Why We're Deprecating FactoryGirl's 
Cucumber Steps
https://robots.thoughtbot.com/writing-better-cucumber-scenarios-or-why-were

Write Great Cucumber Tests
https://saucelabs.com/blog/write-great-cucumber-tests

Cucumber Best Practices
https://github.com/strongqa/howitzer/wiki/Cucumber-Best-Practices

Cucumber Backgrounder
https://github.com/cucumber/cucumber/wiki/Cucumber-Backgrounder

Capybara
https://github.com/teamcapybara/capybara