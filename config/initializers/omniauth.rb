Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '4bUmNUQl5SgJuuuWcWuzIULkS', 'CvFiQWRNvAO7JXWFFDyiNsLVvPbUhyGUOmsBSMUsmGw2CDtJYQ'
  provider :google_oauth2, '850083876126-h3r2ujqiu1e6enifhjeb5uo2uidhguer.apps.googleusercontent.com', '8ixrZnsfH8NFCpLHEFqktmrM'
  provider :facebook, '289615254495412', '94cdb6552e5e5e19236fbd7d6b0c521e'
  provider :github, 'd96e7456c937578c846c', '5487bfe9b27116a7b351421cb355202b30d3c17f'
  provider :amazon, 'amzn1.application-oa2-client.6369331ae5954f8cb33edddc537da147', 'a1a09475af7f444ba1c37f2679692802c289563020ca894efed575949afe598f'
  #provider :youtube, '850083876126-h3r2ujqiu1e6enifhjeb5uo2uidhguer.apps.googleusercontent.com', '8ixrZnsfH8NFCpLHEFqktmrM'
end
