# Hoard

Hoard is a commission tracker. It's like FurAffinity or another image gallery,
but it also lets you track your commission ideas, regardless of whether they've
resulted in art yet. And it's like that one spreadsheet you've tried to keep
on Google Drive, except it is a bit nicer to maintain for you, and a whole lot
harder for me.

This repository is public for two reasons:
* Portfolio building in case people want to check my source code
* Collecting feature requests and bug reports in one place

You're probably here for the latter, in which case you should try the
[issues page.](https://github.com/cschuijt/hoard/issues)

What follows below are technical details in case you want to clone this
repository and try to get it working for yourself.

## Technical stuff

Hoard runs on **Rails 6.0.2.2, Ruby 2.7.1p83**. Other versions of Ruby should
work just fine as well. In production, the database is currently configured to
use Postgres, but should be reconfigurable to SQLite or something else. File
uploading and storage uses the S3 API to talk to Backblaze B2, but again, freely
interchangeable if you know what you're doing.

### System configuration and dependencies

Hoard uses rbenv to ensure it will be on the right Ruby version, and rbenv's
[gemset plugin](https://github.com/jf/rbenv-gemset) to keep its gems together.
After cloning into the repository, just use `bundle` to get set up.

### Database

Configuration is in the usual places, initialize with `rails db:schema:load` as usual.

### Configuring the app

To get set up, you will need to supply your own master key and secrets. Since my file
is encrypted using my master key, you should probably get rid of it and generate your own:

```
rm config/secrets.yml.enc
bin/rails credentials:edit
```

This will set you up with a new master key and an empty credentials file. A template for
all the credentials Hoard expects to be provided through here will be placed in the
repository at a later point in time.

### Test suite

There's no tests yet, oops.

### Deployment

Deployment is done through Capistrano. Change the server details in
`config/deploy/production.rb` and run `cap production deploy` for the magic to happen.
