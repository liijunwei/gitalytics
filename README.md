## Gitalytics

Get commits statistics for your git repository
Based on gist by Tobin Harris: https://gist.github.com/tobinharris/396634

[![Gem Version](https://badge.fury.io/rb/gitalytics.png)](http://badge.fury.io/rb/gitalytics)
[![Dependency Status](https://gemnasium.com/pepito2k/gitalytics.png)](https://gemnasium.com/pepito2k/gitalytics)
[![Build Status](https://travis-ci.org/pepito2k/gitalytics.png)](https://travis-ci.org/pepito2k/gitalytics)

[![Coverage Status](https://coveralls.io/repos/pepito2k/gitalytics/badge.png?branch=master)](https://coveralls.io/r/pepito2k/gitalytics?branch=master)
[![Code Climate](https://codeclimate.com/github/pepito2k/gitalytics.png)](https://codeclimate.com/github/pepito2k/gitalytics)
[![codebeat badge](https://codebeat.co/badges/166f8f5d-5596-44ef-a762-4b89fc5b531f)](https://codebeat.co/projects/github-com-pepito2k-gitalytics)

[![GitHub forks](https://img.shields.io/github/forks/pepito2k/gitalytics.svg)](https://github.com/pepito2k/gitalytics/network)
[![GitHub stars](https://img.shields.io/github/stars/pepito2k/gitalytics.svg)](https://github.com/pepito2k/gitalytics/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/pepito2k/gitalytics.svg)](https://github.com/pepito2k/gitalytics/issues)

![Total Downloads](http://ruby-gem-downloads-badge.herokuapp.com/gitalytics?type=total)

![Gitalytics Screenshot](http://photos.gonzalo.robaina.me.s3.amazonaws.com/gitalytics_screen.png "Gitalytics Screenshot")

## Installation

### Manual installation

    gem install gitalytics

### Using bundler
Add gitalytics to your Gemfile

    gem "gitalytics"

Install  the gem

    bundle install

## Usage
Open a terminal window pointing to your git repository and just run the gitalytics command:

    $ gitalytics

If you'd like to get a fancy html report like the one in the screenshot above, you will need to run the following command:

    $ gitalytics -h

If you want to have the html report but don't want it to be opened right away just write:

    $ gitalytics -n

Note that gitalytics groups authors by name, you can change that and group by email using:

    $ gitalytics -e

## License
Copyright (c) 2016 Gonzalo Robaina

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
