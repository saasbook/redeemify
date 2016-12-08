Development Process
------------------

Our default working branch is `master`.  We do work by creating branches off `master` for new features and bugfixes.  Any feature should include appropriate Cucumber acceptance tests and RSpec unit tests.  We try to avoid view and controller specs, and focus purely on unit tests at the model and service level where possible. A bugfix may include an acceptance test depending on where the bug occurred, but fixing a bug should start with the creation of a test that replicates the bug, so that any bugfix submission will include an appropriate test as well as the fix itself.

Each developer will usually work with a [fork](https://help.github.com/articles/fork-a-repo/) of the [main repository on Strawberry Canyon](https://github.com/strawberrycanyon/redeemify). Before starting work on a new feature or bugfix, please ensure you have [synced your fork to upstream/develop](https://help.github.com/articles/syncing-a-fork/):

```
git pull upstream master
```

Note that you should be re-syncing daily (even hourly at very active times) on your feature/bugfix branch to ensure that you are always building on top of very latest develop code.

Every pull request should be for a corresponding GitHub issue or Pivotal Tracker story.

Please ensure that each commit in your pull request makes a single coherent change and that the overall pull request only includes commits related to the specific GitHub issue that the pull request is addressing.  This helps the project managers understand the PRs and merge them more quickly.

Whatever you are working on, or however far you get please do open a "Work in Progress" (WIP) [pull request](https://help.github.com/articles/creating-a-pull-request/) (just prepend your PR title with "[WIP]" ) so that others in the team can comment on your approach.  Even if you hate your horrible code :-) please throw it up there and we'll help guide your code to fit in with the rest of the project.


Before you make a pull request it is a great idea to sync again to the upstream develop branch to reduce the chance that there will be any merge conflicts arising from other PRs that have been merged to develop since you started work:

```
git pull upstream master
```

In your pull request description please include a sensible description of your code and a tag `fixes #<issue-id>` e.g. :

```
This PR adds a CONTRIBUTING.md file and a docs directory
fixes #799
```

which will associate the pull request with the issue in GitHub or the story in Pivatol Tracker.

See also [more details on submitting pull requests](https://github.com/AgileVentures/WebsiteOne/blob/develop/docs/how_to_submit_a_pull_request_on_github.md).

Pull Request Review
-------------------

Currently @tansaku and @mattlindsey are pairing on the project management of Redeemify.  The project managers will review your pull request as soon as possible.  The project managers can merge unilaterally if necessary, but in general both project managers will need to sign off on a pull request before it is merged.

The project managers will review the pull request for coherence with the specified feature or bug fix, and give feedback on code quality, user experience, documentation and git style.  Please respond to comments from the project managers with explanation, or further commits to your pull request in order to get merged in as quickly as possible.

To maximize flexibility add the project managers as collaborators to your Redeemify fork in order to allow them to help you fix your pull request, but this is not required.

Code Style
-------------

We recommend the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

Developer Tips
--------------

1. Follow the following steps to try out and debug Redeemify in development connecting to Google+ using OAuth. There might be an easier way, but this works!

    a. Submit a PR to add the following line to db/seeds.rb, adding your Google/Google+ ID (or just add temporarily):
    ```
    Provider.create!(name: "Google", provider: "google_oauth2", email: "your_id@gmail.com")
    ```
    
    b. Get and save your GOOGLE_KEY and GOOGLE_SECRET for "your_id@gmail.com" by following instructions at [Google: Authorizing API requests](https://developers.google.com/+/web/api/rest/oauth).
   
   c. In your local repo, create or modify config/application.yml to contain the GOOGLE_KEY and GOOGLE_SECRET for your Google+ account as follows:
    ```
    # Google account: your_id@gmail.com
    GOOGLE_KEY:    [key].apps.googleusercontent.com
    GOOGLE_SECRET: [secret]
    ```
    
    d. Temporarily modify the file config/environments/development.rb to comment out the following line, but don't commit it:
    ```
    # OmniAuth.config.test_mode = true
    ```
    
    e. Run `rake db:reset`, `rake db:migrate`, restart the app, clear any application cookies in your browser, and try logging in to Reedemify http://localhost:3000 with Google+.
    > To configure in cloud9 [follow these steps](http://pastebin.com/bFwzGPUs).

2. To use Amazon instead of Google, and a Vendor instead of Provider.
Note that below is a Work-In-Progress as it's complicated to setup a new Amazon 'application' under your developer id.

    a. Submit a PR to add the following line to db/seeds.rb, adding your Amazon ID (or just add temporarily):
    ```
    Vendor.create!(name: "Amazon", provider: "amazon_oath2", email: "matthew.r.lindsey@gmail.com",  description: "AWS Testing", website: "matthewrlindsey.org", helpLink: "matthewrlindsey.org/help", cashValue: "$8")
    ```

    b. Get and save your AMAZON_KEY and AMAZON_SECRET for "your_id@amazon.com"
    1. [Setup yourself as an 'Amazon Developer'](https://developer.amazon.com/lwa/sp/overview.html)
    2. Follow [Managing Access Keys for your AWS Account](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) to create an access key

    c. In your local repo, create or modify config/application.yml to contain the AMAZON_KEY and AMAZON_SECRET for your Amazon account as follows:
    ```
    AMAZON_KEY:     amzn1.application-oa2-client.[key]
    AMAZON_SECRET:  [secret]
    ```

    d. (as above in 1)

    e. (as above in 1.)
