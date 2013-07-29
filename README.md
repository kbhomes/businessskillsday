Business Skills Day
===================

Introduction
------------

A web interface to manage an [FBLA][1] conference with various events, chapters, students, results, etc.

Built for [Arizona State University Phi Beta Lambda][2]'s annual Business Skills Day event.
Sits atop Ruby on Rails 4 and PostgreSQL.

[1]: http://fbla-pbl.org/ "Future Business Leaders of America"
[2]: http://asupbl.org/

Requirements
------------

* Ruby (2.0 or greater)
* PostgreSQL (9.0 or greater)


Getting Started
---------------

1.  Clone the repository.

2.  Copy `.env.example` into a new file, `.env`, and change the various environment variables.

    As mentioned in the .example file, I have to stress that you should keep these values safe
    and secret. The application may become vulnerable to attack if you distribute these values.
    This repository includes `.env` in the `.gitignore` file, so you should be good to go.

    Most importantly, remember to generate a new secret token, via the `rake secret` task. Not
    doing so could render the application vulnerable to session tampering.

3.  Copy `config/database.yml.example` into a new file, `config/database.yml`, and change the
    various database access values.

    To note, there are four environments in this application: __development__, __staging__, __production__,
    and __test__. Staging is expected to be a similar environment to production. If you wish to
    exclude the staging environment:

    *   Delete `config/environments/staging.rb`
    *   Remove the staging section from `config/database.yml`
    *   Remove any `STAGING_` variables from `.env`

4.  Run `bundler install` to install all of the required gems for this application.

5.  Run `rake db:create`, `rake db:migrate` and `rake db:seed` to populate the development database.

    A default administrative account is created with the credentials:

        Username: admin@example.com
        Password: password

6.  Run `rails server` and visit the application at http://localhost:3000/.

License
-------

The MIT License (MIT)

Copyright (c) 2013 Sajid Anwar

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



