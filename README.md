# Redeemify: let users redeem "bundles" of offers

How it works:

0. A user receives a "redemption code" (like a gift card code) as a
result of buying something, or whatever.

0. User logs in to Redeemify by presenting that redemption code and then
"linking" it to whatever SSO they login with (Google, GitHub, Facebook,
etc.)

0. That redemption code "unlocks" a list of additional redemption codes
to be redeemed at their respective sites.

# Terminology and model names

For this discussion, we'll use the following specific use case:

0. User buys a copy of "Engineering Software as a
Service" on Amazon

0. user receives a redemption code via separate email
from Amazon after purchase

0. user logs in here with that code, and
receives a set of codes for geting free trials on SaaS-developer-focused
services like GitHub, CodeClimate, etc.

In this scenario:

* A `User` is someone who has an account on Redeemify. An `AdminUser`
(different model) is a user who can administer the site.

* Amazon.com is the `Provider`: the entity that provides a redemption
code that will allow the user to sign up here.  A Provider provides a
list of valid redemption codes that are handed out one by one as the 

* GitHub, CodeClimate, etc. are each a `Vendor`: an entity that provides
a 
