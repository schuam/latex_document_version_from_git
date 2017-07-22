# Latex Document Version From Git

Since I've been using git as version control system for pretty much all my
projects (including latex documents), I've been wondering how to inject version
information from git into a latex document. I finally took the time to think
about how to do it and came up with a solution that works fine for me.


## Background

I wanted to include the version of a document that I created using latex (or
pdflatex to be correct, since that's what I use pretty much all the time) into
the document. So, for example on the titlepage of the document underneath the
title there should be a line like this: 'v1.0' or what ever. One way to archive
this is to manually change that number every time before pdflatex is called.
But this is tedious and error prone. I use git as a version control system, so
it seemed locigal to get the version information from there and somehow inject
it into the latex document. I looked around the internet, but couldn't find a
solution that pleased me. Maybe I didn't look long enough, but oh well... I
came up with my one solution and maybe you're interessted in it.


## Solution

My solution involves the git describe command and make to automate the build
process. I work on a Linux machine, so I don't know how easy it would be to
port this to Windows or Mac or what ever OS you might use.

First of all, when ever a new version of a document is done, I tag it, e.g. like
this:

    git tag v1.0

Then the command

    git describe --tags --dirty --always

can be used to retrieve usefull information that can be used as the version of a document. In addition
the the last tag, additional information is given. In case the commit that is
checked out is ahead of the one with the last tag, git describe displays the
number of commits the current one is ahead of the one with the tag and the
commit hash. The '--dirty' option adds '-dirty' to the output of the command,
in case the working directory is not clean. And '--always' makes sure that in
case there are no tags in the repo yet, that at least the commit hash is
printed out.

I re-direct the output of git describe into a new tex file:

    git describe ---tags --dirty --always > document_version_from_git.tex

I make sure git ignores this file by adding it into .gitignore. Otherwise,
after each commit the last command would change the content of that file, which
in turn would lead to a dirty working directory and git would tell there are
changed that haven't been commited. If you commit them, the next call of the
last command changes the content of the file again and so forth.

In my main latex file, I might have a line like this:

    \title{Document Version Test\\\input{document_version_from_git.tex}}

When 

    \maketitle

is called at the beginning of the actual document, the output of git describe
is added as a line on the titlepage.

To automate the process, I wrote a Makefile that whenever I call make, it
invokes the git describe command and pdflatex afterwards. In addition it does
some extra work like cleaning up and add a timestamp the the output file name.
Check it out if you like.
