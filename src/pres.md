# git

15-131

## Some questions

- This was working just a few minutes ago. What did I change to break it?
- I'm working on a side project with my friend. How can I avoid having to email
  our code back and forth?
- When did I implement this?
- Who implemented this?
- I'd like to start implementing this feature, but I'll probably have to change
  a bunch of files in my project. Is there a way I could switch between
  "working on the feature" mode and "stable" mode?
- How am I supposed to prove I'm the one who made this?

## The answer: a Version Control System

A system to control versions.

Specifially, versions of _a project_, as it changes through time.

"VCS" stands for "Version Control System."

## git: A popular VCS

The VCS we'll be learning about today is called git.

git is very widely used. It was originally created to manage the development of
the Linux kernel, arguably one of the largest and most important software
projects in existence.

Anyone can use git. It is free and open-source software.

On the command line, the program name for working with git is called `git`. Try
this out to see if you have git installed:

	$ git --version
	git version <something>

## Get help with git

The first git command to learn is the one that gives you information about all
the other ones.

	$ git help

Suppose we learn about a command called `git add`. We could get help for that
specific command.

	$ git help add

## Set up your information with git

You'll only have to do this once per computer that you use:

	$ git config --global user.name 'Your Name'
	$ git config --global user.email 'your_email@example.com'

We'll see why you have to do this later.

## A sample project

Let's grab a sample project to work with.

	$ curl -fsSL https://git.io/v5ief | sh
	checking user is not 'root'
	checking deps are installed
	downloading and unzipping '...' to 'sample-project'
	finishing
	$ cd sample-project
	$ ls -a
	.  ..  main.py  readme.md

This project isn't yet managed by git. We can prove that to ourselves with:

	$ git status
	fatal: Not a git repository (or any of the parent directories): .git

## Initializing a git repository

We want to start managing this project with Git.

	$ git init
	Initialized empty git repository in <current directory>

OK, what changed?

	$ ls -a
	.  ..  .git  main.py  readme.md

## The `.git` directory

We can see that `git init` created a special directory inside our project
directory called `.git`.

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

## Index: What goes into the next commit

In order for a change to a file to be part of the next commit, we need to add
those changes to the index. Let's add the changes to every file in the current
directory, to the index.

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

OK, let's commit it.

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

We can see what commits have been made in the past.

	$ git log
	commit 9f0c312408966a1aff04726b75e6eb5a01694be1 (HEAD -> master)
	Author: Ariel Davis <ariel.z.davis@icloud.com>
	Date:   2017-09-04 18:19:12 -0400

	    Start the project

Right now it's just the one.

## Making more changes

We can make changes to files.

	$ echo 'print(3)' >> main.py
	$ echo 'why hello there' >> readme.md

Then ask about the status again.

	$ git status
	On branch master
	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git checkout -- <file>..." to discard changes in working directory)

		modified:   main.py
		modified:   readme.md

	no changes added to commit (use "git add" and/or "git commit -a")

## Seeing what the changes are

We can find out exactly _what_ changed in a given file.

	$ git diff main.py
	diff --git a/main.py b/main.py
	index 7411cd6..33939f2 100644
	--- a/main.py
	+++ b/main.py
	@@ -3,3 +3,4 @@ def sayHello(x):

	 sayHello("user")
	 sayHello("world")
	+print(3)

## Removing changes from the index

As usual, we can add changes to the index.

	$ git add main.py readme.md

Let's suppose, however, that we regret our actions, and want to remove the
changes to `readme.md` _from the index_. Important note: we don't want to
discard the changes altogether, we just don't want the changes to be in the
index.

	$ git reset readme.md

## Removing changes from the working tree

Different from the previous scenario, let's suppose we have changes to a file
(say `readme.md`), and we want to completely get rid of those changes.

	$ git checkout readme.md

You should be very careful with this command, since it can discard uncommitted
changes.

## Another commit

After all those commands, `main.py` remains in the index. So we can make
another commit as usual.

	$ git commit -m 'print 3'
	[master f62b85f] print 3
	 1 file changed, 1 insertion(+)

## Ignoring files

We might want to have files in our working tree that we don't want git to worry
about.

	$ echo 'overthrow jacobo' >> secret_plans.txt

We can ignore these with a file called `.gitignore`.

	$ echo 'secret_plans.txt' >> .gitignore

Since `.gitignore` itself is a file, we must add _that_ to the git repository.

	$ git add .gitignore
	$ git commit -m 'add .gitignore'
	[master 64449c0] add .gitignore
	 1 file changed, 1 insertion(+)
	 create mode 100644 .gitignore

## `add`, `reset`, `checkout` with 'patches'

Suppose we want to `add`, `reset`, or `checkout` only _part_ of a file. How can
we select the parts of the file to operate on?

Use the `-p` (also `--patch`) option of those commands.
