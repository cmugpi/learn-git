# Learn Git

Ariel Davis

## Some questions

- I swear, this was working just a few minutes ago. What did I change to break
  it?
- I'm working on a side project with my friend, but I hate having to email our
  code back and forth. How can I avoid this?
- When did I implement this?
- Who implemented this?
- I'd like to start implementing this feature, but I'll probably have to change
  a bunch of files in my project. Is there a way I could switch between
  "working on the feature" mode and "stable" mode?
- How am I supposed to prove I'm the one who made this?
- What did I change since last week?

## The answer: a Version Control System (VCS)

A system to control versions.

Specifially, versions of _a project_, as it changes through time.

## git: A popular VCS

The VCS we'll be learning about today is called [git][1].

[1]: http://tom.preston-werner.com/2009/05/19/the-git-parable.html

git is very widely used. It was originally created to manage the development of
the Linux kernel, arguably one of the largest and most important software
projects in existence.

Anyone can use git. It is free and open-source software.

On the command line, the program name for working with git is called `git`. Try
this out to see if you have git installed:

	$ git --version
	git version <something>

## Set up your information with git

You'll only have to do this once per computer that you use:

	$ git config --global user.name 'Your Name'
	$ git config --global user.email 'your_email@example.com'

We'll see why you have to do this later.

## A sample project

Let's grab a sample project to work with.

	$ curl -sO https://azdavis.xyz/sample-project.zip
	$ unzip -q sample-project.zip
	$ cd sample-project
	$ ls -a
	.  ..  main.py  readme.md

This project isn't yet managed by git. We can prove that to ourselves with:

	$ git status
	fatal: Not a git repository (or any of the parent directories): .git

## Initializing a git repository

We want to start managing this project with Git. We can do this with:

	$ git init
	Initialized empty git repository in <current directory>

Ok, what changed?

	$ ls -a
	.  ..  .git  main.py  readme.md

## The `.git` directory

We can see that `git` created a special directory inside our project directory
called `.git`.

You should NEVER do the following:

- Rename the `.git` directory.
- Remove the `.git` directory.
- `cd` into the `.git` directory.
- Make your own `.git` directory.
- (Directly) modify the contents of the `.git` directory.

It is enough to know that the `.git` directory is important, and that you
should not interfere with it (directly).

Of course, you _will_ be interfering with the `.git` directory indirectly: by
using `git` commands. `git` knows how to modify the `.git` directory correctly,
so we'll ask it to do that for us.

## Knowing the status

Now that `git` is managing our project, we can inquire as to what the state of
our project is.

	$ git status
	On branch master

	No commits yet

	Untracked files:
	  (use "git add <file>..." to include in what will be committed)

		main.py
		readme.md

	nothing added to commit but untracked files present
	(use "git add" to track)

This seems to be talking quite a bit about something called a "commit." What is
that?

## Commit: The unit of change

We know that git is a VCS, and that VCS means Version Control System.

So we have some project we want to manage with a VCS.

How does the VCS know what the different versions of our project are?

We have to tell it by making "commits." This process of making commits is
called "committing." Once we make a commit of some version of our project, that
version has been "committed."

## The information in a commit

- Root tree
- Author & author date
- Committer & committer date
- Message
- Previous commit(s)

## The index

In order for a change to a file to be part of the next commit, we need to add
those changes to the index. The command to do that is `git add`. Let's add
every file in the current directory to the index.

	$ git add .

Let's look at the status again.

	$ git status
	On branch master

	No commits yet

	Changes to be committed:
	  (use "git rm --cached <file>..." to unstage)

		new file:   main.py
		new file:   readme.md

## Making a commit

OK, let's commit it. We can use the `-m` option of `git commit` to add a
message.

	$ git commit -m 'Start the project'
	[master (root-commit) 9f0c312] Start the project
	 2 files changed, 8 insertions(+)
	 create mode 100644 main.py
	 create mode 100644 readme.md

And another look at the status:

	$ git status
	On branch master
	nothing to commit, working tree clean

## Viewing the commit log

We can see what commits have been made in the past with `git log`.

	$ git log
	commit 9f0c312408966a1aff04726b75e6eb5a01694be1 (HEAD -> master)
	Author: Ariel Davis <ariel.z.davis@icloud.com>
	Date:   2017-09-04 18:19:12 -0400

	    Start the project

Right now it's just the one.
