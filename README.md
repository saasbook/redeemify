[![Code Climate](https://codeclimate.com/github/strawberrycanyon/redeemify/badges/gpa.svg)](https://codeclimate.com/github/strawberrycanyon/redeemify)
[![Issue Count](https://codeclimate.com/github/strawberrycanyon/redeemify/badges/issue_count.svg)](https://codeclimate.com/github/strawberrycanyon/redeemify)
<a href="https://travis-ci.org/strawberrycanyon/redeemify"><img src="https://travis-ci.org/strawberrycanyon/redeemify.svg?branch=master"></a>

# Redeemify: let users redeem "bundles" of offers

How it works:

0. A user receives a "redemption code" (like a gift card code), perhaps
because they paid for it, or perhaps as a
result of buying something.  

0. User creates an account on Redeemify by presenting that redemption
code and then 
"linking" it to whatever SSO they login with (Google, GitHub, Facebook,
etc.)  (Without a redemption code, a user can't create an account.)

0. That redemption code "unlocks" a list of additional redemption codes
from different vendors, to be redeemed at their respective sites.

# Terminology and model names

For this discussion, we'll use the following specific use case:

0. User buys a copy of "Engineering Software as a
Service" on Amazon

0. User receives a redemption code via separate email
from Amazon after purchase

0. User signs up on Redeemify with that code and their Facebook
credentials.  

0. Once in their account, user sees promo codes for 
GitHub (1 month of free Micro), CodeClimate (1 seat for 1 month), and
TravisCI (Premium account for 1 month).

0. The user logs in or signs up on GitHub, CodeClimate, and Travis, and
redeems the respective codes.

In this scenario:

* A `User` is someone who has an account on Redeemify. An `AdminUser`
(different model) is a user who can administer the site.

* Amazon.com is the `Provider`: the entity that provides a redemption
code that will allow the user to sign up here.  A Provider provides a
list of valid redemption codes.  The idea is one code is handed out with
each purchase, and that code enables a `User` to login to Redeemify with
their choice of 3rd party auth.  Once a particular code has been
associated with an identity on Redeemify, it can't be associated with
another identity, i.e. a `ProviderCode` can only be redeemed once.

* GitHub, CodeClimate, etc. are each a `Vendor`: an entity that provides
some promotion that is part of a redemption bundle.  The promotion is
represented by a `VendorCode`.  For example, a GitHub `VendorCode` might
be a string that can be redeemed as a promo code on GitHub for a month
of free Micro account.

