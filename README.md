puppet-ticket-face
==================

Description
-----------

A Puppet Face for creating Redmine tickets via the Faces API.

Requirements
------------

* `puppet ~> 2.7.0`
* `activeresource` gem
* A [Puppet Labs Redmine account](http://projects.puppetlabs.com).

Installation
------------

1. Install puppet-ticket-face as a module in your Puppet master's module
path.

2. Install the activeresource gem:

        $ sudo gem install activeresource

Usage
-----

### Listing tickets

To list some details about a ticket run the `puppet ticket` command 
like so:

    $ puppet ticket list --ticket 1234

Where 1234 is the number of the ticket you wish to view.  Some
information and a URL for the ticket will be returned.

    Issue 1234 is 'incorrect autotest info on wiki/WritingTests' in the
    Puppet project and has a status of 'status'.
    You can find it at http://projects.puppetlabs.com/issues/1234

You don't need to specify a Redmine user token to return ticket
information.

### Creating tickets

To create a ticket run the `puppet ticket` command like so:

    $ puppet ticket create --token 123456780ABCDEF

You will need to specify your Redmine user token. You will be prompted 
to specify the name of the project to log the ticket in, the title of 
the ticket and the description of the ticket.

You can end entry for each value with the `<Enter>` key or with `^C` to
cancel creation of the ticket.

    Create a new Redmine ticket specifing the project, a title and a
    description. End each entry with <Enter> or ^C to cancel
    Project to log a ticket to, for example Puppet or Facter
    Project: Puppet
    Ticket title: This is a ticket title...
    Ticket Description: This is a ticket description.

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
