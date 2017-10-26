# git

15-131

## Some questions

- This was working just a few minutes ago. What did I change to break it?
- I'm working on a side project with my friend. How can I avoid having to email
  our code back and forth?
- When did I implement this?
- I'd like to start implementing this feature, but I'll probably have to change
  a bunch of files in my project. Is there a way I could switch between
  "working on the feature" mode and "stable" mode?
- How am I supposed to prove I'm the one who made this?
- If a pupper is a small doggo, and a doggo is a big ol' pupper, where does the
  mutual recursion end?

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

On the command line, the program name for working with git is called `git`.
It's available on the Andrew machines when you `ssh` in.

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

You'll only have to do this once per computer that you use.

	$ git config --global user.name 'Your Name'
	$ git config --global user.email 'your_email@example.com'

We'll see why you have to do this later.

## Cloning

If we want to start working on a project that's already on a git server
somewhere, we can clone the repository to our local machine.

	$ git clone https://github.com/cmugpi/gpi-labs.git

But what if we have a project on our computer which isn't managed by git yet?

## A sample project

Let's look at a sample project.

	$ cd sample-project
	$ ls -a
	.  ..  main.py  readme.md

This project isn't yet managed by git.

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

We can see there is now a special directory, called `.git`, inside our project
directory.

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

- The state of all the files in the project
- Who committed this, and when
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

And another look at the status.

	$ git status
	On branch master
	nothing to commit, working tree clean

## Viewing the commit log

We can see what commits have been made in the past.

	$ git log
	commit 501482bfbfcf281e95090b058c3eeb71d3f93bef (HEAD -> master)
	Author: Ariel Davis <ariel.z.davis@icloud.com>
	Date:   2017-10-25 19:45:29 -0400

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

## Switching between commits

We saw earlier that `git checkout <file>` basically turns `<file>` in your
working directory to the way it was in a certain commit.

What should `git checkout <commit>` mean?, Well, that's basically like saying
we want to turn _every_ file in the working directory into the way it was at
`<commit>`. This basically "switches" us to looking `<commit>` in our working
directory.

We can use the special name `HEAD` to talk about the commit which is currently
checked out.

	$ git rev-parse HEAD
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35

## Identifying commits

How do we specify a commit? One way is with the unique identifier that git
assigns each commit.

	$ git log --format=oneline --no-decorate
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35 add .gitignore
	7615f0ccd31b1d4a28317e49f4f5bf35ee5775d1 print 3
	501482bfbfcf281e95090b058c3eeb71d3f93bef Start the project

But this can get a bit unwieldy.

## Branches...

Let's take another look at the status. (You should get in the habit of doing
this!)

	$ git status
	On branch master
	nothing to commit, working tree clean

Indeed, we have nothing to commit. That is, there is no difference between
`HEAD` and the working tree.

But what's this? "On branch `master`?" What is a "branch?"

## ...are commits

In git, a branch is just a name for a certain commit.

	$ git rev-parse master
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35

We see that `master` and `HEAD` are the same commit. Indeed, that's why git
said we're "on branch `master`." Because the currently checked-out commit
(`HEAD`) is the same as the commit that `master` refers to.

## Making a branch

Let's see what branches there are.

	$ git branch
	* master

We can make a new branch.

	$ git branch research-doggos

And check again.

	$ git branch
	* master
	  research-doggos

The `*` appears next to the currently checked-out branch.

## Switching to the new branch

As discussed, we can use `git checkout <commit>` to replace the entire working
tree with the stuff in `<commit>`, and update `HEAD` to be commit.

	$ git checkout research-doggos
	Switched to branch 'research-doggos'

We notice the following.

	$ git rev-parse HEAD research-doggos master
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35

All three of these refer to the same commit.

But now let's do something interesting.

## Making another commit

Let's make a commit.

	$ echo 'from whence do puppers ariseth?' >> pupper_investigation.txt
	$ git add pupper_investigation.txt
	$ git commit -m 'add research question'
	[research-doggos 77a89c4] add research question
	 1 file changed, 1 insertion(+)
	 create mode 100644 pupper_investigation.txt

## What happened?

Now let's look again.

	$ git rev-parse HEAD research-doggos master
	77a89c4adbca01263c73853b3a7c2933c0ff118a
	77a89c4adbca01263c73853b3a7c2933c0ff118a
	a99f9a7bb35682dc79b7b6701f0f348621a2cd35

We see that `HEAD` got updated to the new commit. That makes sense.

We also see that `research-doggos`, the "current branch," also got updated to
now refer to this new commit.

Finally, we see `master`, which is not the "current branch," remained the same.

## How `HEAD` and branches get updated

This points to some interesting ideas.

- Whenever you make a commit, `HEAD` will always be updated to refer to that
  new commit.
- Whenever `HEAD` refers to the same commit as a branch, the branch will also
  be updated to refer to any new commits.
- No other branches get affected.

## More examples of checkout

Remember what files are in our current directory?

	$ ls
	main.py  pupper_investigation.txt  readme.md  secret_plans.txt

What happens when we return to `master`?

	$ git checkout master
	Switched to branch 'master'
	$ ls
	main.py  readme.md  secret_plans.txt

## When a file shared between branches is changed

We can change a file common to both branches.

	$ git checkout research-doggos
	Switched to branch 'research-doggos'
	$ echo 'print("DOGGOS ARE GOOD")' >> main.py
	$ git add -A
	$ git commit -m 'note the goodness of doggos'
	[research-doggos b49f993] note the goodness of doggos
	 1 file changed, 1 insertion(+)

## When a file shared between branches is changed

	$ git checkout research-doggos
	Already on 'research-doggos'
	$ python main.py
	Hello, user
	Hello, world
	3
	DOGGOS ARE GOOD
	$ git checkout master
	Switched to branch 'master'
	$ python main.py
	Hello, user
	Hello, world
	3
