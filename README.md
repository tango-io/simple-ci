# Simple-CI

[![Code Climate](https://codeclimate.com/github/tangosource/simple-ci.png)](https://codeclimate.com/github/tangosource/simple-ci)

A continuous integration tool for github ruby projects

## Getting started

The services that you need to run are pretty straight forward

```bash
bundle exec rails s

// In another tab

bundle exec sidekiq

// In another tab
bundle exec rackup websocket.ru -env production
```

And that's it, you're going to be able to use the application


## CONTRIBUTING

You can send us pull requests or issues found.

The MIT License (MIT)

Copyright (c) 2013 TangoSource LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
