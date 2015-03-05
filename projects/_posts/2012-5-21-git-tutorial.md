---
layout: post
title: Git Tutorial
---

Learning git was difficult for me because I couldn't find any good tutorials by example. So this is my attempt.

First, I will start with an overview of some commands and what they do. You'll likely be confused, but I will then show by example how to use them in your workflow.

## Basic Commands

When browsing around [Github](http://www.github.com){: .link}, you may find some code that looks useful that you want to play with. To copy a git repository (a git version-controlled directory), you'll use `clone`.

    $ git clone <url/path to git repo>

If you make any changes to the repo, you can use `status` to view what changes have been made.

    $ git status

The `status` command will only tell you the files that have changed. So if you want to see the specific line-by-line changes of each file, you can use the `diff` command.

    $ git diff

To update changes to your local git repository, you want to first add all the files, directories and subdirectories that you want to be tracked (version-controlled).

    $ git add .

Sometimes there are files you will not want to save to your git repo. This is what the `.gitignore` file is for. Compiled binaries are a perfect example of something you might want to ignore. Otherwise, git will try to line-by-line determine the difference with the previous binary which will add a lot of garbage when you `diff`. I will typically always have this in my `.gitignore` file:

    **.DS_Store
    **.pyc

Watch out for training spaces and use `**` to use this pattern for all directories and subdirectories. I dont know what .DS_Store is, but its really annoying on Macs. And you'll never need to version control compiled python files.

To save a version of the files you just addes, you'll use the `commit` command.

    $ git commit -m "A meaningful message about what was changed"

These changes are only committed to the local git repository. If you cloned the repository from somewhere else, you'll need to `push` the changes to the remote "origin" repository.

    $ git push origin <branch>

Every git repository is initialized with a "master" branch. Branches allow you to develop multiple versions of your code. You may have a different branch for each of several different designs. Branching allows you to keep track of the the differences in these designs and quickly change between the designs. To make a new branch, you'll use the `branch` command.

    $ git branch <name>

This will create a new branch that is a copy of the current branch you are on. You can check which branch you are on by not including a name.

    $ git branch

To move to another branch, you have to use `checkout`.

    $ git checkout <name>

To view a list of previous commits, you use `log`.

    $ git log

You can also checkout a previous commit using the commit id. To reset everything back to the previous commit, use `reset` with the `--hard` tag.

    $ git reset --hard





## Git Workflow

Here I am going to cover a general workflow when using git (at least this is they way I have learned). There are two ways you will typically start with git. Either you will clone another repo or initialize one of your own.

Typically, to initialize a git repo, use `init`.

    $ git init

You will typically also want to initialize your `.gitignore` as well at this point.

    $ touch .gitignore

Change the `.gitignore` to ignore certain files like the `.DS_Store` files on Mac OSX. Then `add` all the files you want to track and `commit` the changes.

    $ git add .
    $ git commit -m "first commit"

You will likely want to put this code on Github so you can share the code with others and develop together. Go onto Github to create a new repository. The link the "remote origin" of your local repository to the Github repo.

    $ git remote add origin <github url>
    $ git push -u origin master

The other way you may start with git is my simply cloning an existing repository.

    $ git clone <github url or path>

Now that you have the repo, you you'll want to create a branch to start writing your own code. You'll probably want to always branch from master because master should be guaranteed to be workable code, but if you are extending another branch, you can branch from whatever branch you want. Checkout the branch you want to branch from, pull the most recent commits from origin to make sure you are not behind, make a branch, and name the branch something meaningful.

    $ git checkout master
    $ git pull origin master
    $ git branch adding_login

This creates the branch locally which you can verify.

    $ git branch

We are still on the master branch so we still need to checkout the new branch.

    $ git checkout adding_login

Now that I an on my own branch, I can make all the changes I want without messing up anyone else who is also working with this codebase. I make changes and what not. I add files, I frequently commit locally to leave a trace of what I did.

    $ git add .
    $ git commit -m "Something very specific was done"

Now suppose I am not done with this branch but I dont have time to continue working on it. I could push this branch to origin so others can continue to work on it.

    $ git push origin adding_login

Or, suppose I am finished with this branch, its workable code, and no one else will ever need to see this branch. In this case, I want to push it to origin master. But first, I'll want to make sure I have the latest master branch.

    $ git checkout master
    $ git pull origin master
    $ git merge master
    $ git push origin master

Now if there are any conflicts, you will have to search them out, manually deal with them, make a new commit, and then push back to origin. Otherwise, if there are no conflicts, the push will be successful. The next section will walk you through how to deal with merge conflicts.

## Conflicts

This is a walk through to help you understand git and how to resolve conflicts. We will set up a repo on your local machine that will act as Github, a repo representing you, and a repo representing other users working on the project. Once everything is set up, we will walk through how branch, merge, and push back to origin master. Then we will simulate someone else pushing commits to origin master while you are working on your own code making your master branch out of date with origin master creating a conflict when you merge.

Open Terminal and execute the following commands to create some directories and initialize a git repo as follows.

    $ cd ~/Desktop/
    $ mkdir github
    $ cd github
    $ mkdir project
    $ cd project
    $ git init --bare

This makes a folder called "github" with a folder called "project" inside it. Then we initialized a bare git repo inside the project folder. Github repositories are bare repos, and this will simplify things for us in this tutorial.

Now we want to copy this git repo over from "github".

    $ cd ~/Desktop/
    $ mkdir me
    $ cd me
    $ git clone ~/Desktop/github/project

Here, you made a folder called "me" which will represent you in this example. Then you clone the project from "github". This will copy the repository into your "me" folder. You will see that there is a warning that you just copied an empty repo, so lets make a file and add it to the repo.

    $ cd project
    $ touch file.txt

In `file.txt`, write, "this is the initial file". Then we want to add all of the files and subdirectories of the project folder to the git repo using the `add` command. A period signifies all files and subdirectories. You could add individual files if you wanted but I just use the `.gitignore` file to ignore all files I don't want to add. Then you want to commit the change to the repo using a descriptive message of what you did. The message can be as long as you want it. For the sake of this work through, I will use simple messages though. Then to push this file to the remote repo, you want to use the `push` command. `origin` signifies the remote repository. `master` signifies that we want to push the master branch of the repo.

    $ git add .
    $ git commit -m "first commit"
    $ git push origin master

We just initialized the repo with a file for the sake of this example. We made a file, added it to the local repo, committed the change locally, and pushed the commit to origin/master. Now play with the following commands.

    $ git status
    $ git log

You'll see that we are on the master branch, everything is updated and we have one commit, the "first commit". Now try this command.

    $ git remote show origin

This will show you the path to github project which is the `remote origin` to this repository. That basically means that this is where the project came from and where we sync the project to.

So now we are done with setting everything up and now we get to the point of this work through -- how to use git when working on a project with others. 

If we want to work on the code to perhaps add a feature, we are going to want to first make a branch off of master. The point of branching is that the master branch should always have workable code. Thus if you are working on something which may have several commits where the code isn't workable, then you definitely want to branch. You want to commit often, with descriptive messages to leave a trail of what was done. If you are simply changing a minor bug which will only require one commit, then you could work on the master branch, but otherwise, always make a new branch. Also, it helps if you name the branch in terms of what you are working on in that branch. 

So lets make "some change".

    $ git branch

This shows you are on the master branch, so we are branching from master. Lets make a new branch.

    $ git branch making_some_change

You'll see that we are still on master branch though.

    $ git branch

To change branches, you have to `checkout` that branch.

    $ git checkout making_some_change

And now verify that you are on the correct branch.

    $ git branch

This branch has all of the contents of master since we just created it. Now lets make our changes.

Open `file.txt` and append the "me making a good change" to a new line at the end.

    $ git add .
    $ git commit -m "me making a change"
    $ git log

Now, assuming that this is a good change and that this code is now workable, we will then want to merge back to master before we push to origin/master. So switch to the master branch.

    $ git checkout master
    $ git log

Verify that the commit made on `making_some_change` is not on the master branch. Try opening up the `file.txt` and you will see it is the old file. Then merge the branch back to master.

    $ git merge making_some_change
    $ git log

You will now see that that commit was added to the file and that file has been changed. Then try:

    $ git status

You will see that it says your branch is ahead of origin/master by 1 commit. This means that github (or the folder in this instance) has not been updated with this commit. Go to the github folder and check it out for yourself if you want. To update the github repo, we will want to push to origin/master (origin is github, and master is the branch that we are pushing).

    $ git push origin master
    $ git status

You will now see that there is nothing to commit and that we are synced with origin master. This was a piece of cake - even ideal. There was no one else working on this code and there were no conflict. Now lets simulate a conflict.

Lets suppose we came back to this project some time later and want to work on another feature. We are going to want to make another branch off of master, but first, we want to make sure we have the most up to date master branch because perhaps at some point while we were away someone else updated origin master.

    $ git pull origin master

You will see that your master branch is already up-to-date. If it wasn't, you'd want check the log to see what was added. So lets make another change.

    $ git branch making_another_change
    $ git checkout making_another_change

Open `file.txt` and add "me making another change" to the bottom of the file. So the file should look something like this.

> this is the initial file
>
> me making a good change
>
> me making another change

Then lets commit the change.

    $ git add .
    $ git commit -m "me making another change"

Meanwhile, on the other side of the world, someone is also working on their own branch off of master adding their own feature. Lets simulate someone else working on this project at the same time.

    $ cd ~/Desktop/
    $ mkdir someone
    $ cd someone
    $ git clone ~/Desktop/github/project
    $ cd project

Try the following.

    $ git log
    $ git status
    $ cat file.txt

Verify that we just copied the same file over from origin master. Now lets assume that someone wants to make a change so they create a branch, etc...

    $ git branch someone_making_some_change
    $ git checkout someone_making_some_change

Open `file.txt` and write "someone made another good change" on a new line at the end. So now the file should have the following.

> this is the initial file
>
> me making a good change
>
> someone made another good change

Now, lets merge and push...

    $ git add .
    $ git commit -m "someone making a change"
    $ git checkout master
    $ git merge someone_making_some_change
    $ git push origin master

So now, lets go back to "me" and try merging `making_another_change` into master and pushing to origin/master. You can already tell this is going to get ugly right?

    $ cd ~/Desktop/me/project

Try these commands on master and `making_another_change` to verify that we were right where we left off.

    $ git branch
    $ git status
    $ git log
    $ cat file.txt

Note that your repo has no knowledge of someone's commit because the local repo hasn't been updated. Now, here we can do one of two things. We can merge to master, then push to origin master, deal with the conflict then and push back to origin master (which is what I will do), or pull the most recent origin master, merge to master, deal with the conflicts, and then push back to origin master.

    $ git checkout master
    $ git merge making_another_change
    $ git log

You will see that we are missing the commit made by someone...

    $ git push origin master

This is where git it both useful, and interestingly difficult to learn. We have a conflict. Our master is behind origin master. We are missing the commit made by someone else. So we what we want to do is pull the repo from origin master, merge the repos, and the recommit to origin master.

    $ git status

Verify we have the same problem. First we are going to do a pull. Pull executes a fetch and a merge. Basically, it takes origin master and tries to apply the commits we dont have onto master.

    $ git pull origin master

You will see that the merge failed because there is a conflict in `file.txt`. Open it and you wwill see the conflict between the `<<<<<<<   =======   >>>>>>>>`.

Where it says head, we will see the changes that we made on out local git repo that hasn't been added to master. Then under ===== we will see the changes that we don't have in our repo that is on origin master along with the commit id. 

This is where we manually fix the changes. In practice, we want to make sure everything is functional. Remember, master is always going to have workable code. Notice that this merge is only local, so we don't have to worry about messing it up so long as we don;t push back to origin master. If we fuck up, we still have our code on the other branch, and if we don't like what we did and someone already fixed it, we can just delete the branch.

So lets delete the garbage so the file now looks like this:

> this is the initial file
>
> me making a good change
>
> me making another change
>
> someone made another good change

Lets commit our work.

    $ git add .
    $ git commit -m "merge success"
    $ git status
    $ git log

You'll see that we are 3 commits ahead of master now. And note the order of the commits. Your commits from "me" we put on top of those from "someone" because "someone" pushed to origin master before you. Then you'll see your merge success commit. 

Now, you could have done anything you wanted in that merge. You could have deleted the stuff that "someone" did. The point is that you want the code to be workable persisting someone's work before you push back to origin master. So once you are done working on the code and think it is workable you should push to origin master.

    $ git push origin master

And there ya go. One thing I didn't mention is that you can push other branches to origin. They do';t have to be workable, only master does (best practices). Pushing other branches allows other people to work off that branch with you.

    $ git push origin <name of branch>

## Suggestions

Commit often. The more often you commit, the easier it is to back track to where something went wrong. If something does go wrong, you can always revert back to a prior commit.

Always keep workable code in origin master. If you are working with a group, branch before making any changes so you can merge back to other branches.

You don't always have to branch to make changes especially if you are not working in a large group. However, I would recommend branching if it is something you may eventually trash or might not work out.

Also, I would recommend using https rather than ssh with Github. This is much less a hassle than dealing with ssh keys. You can also use the Mac keychain to remember your username and password. So when you clone a repo, clone from the https url and not the ssh url. To allow your keychain to remember your github authentication run the following command.

    $ git-credential-osxkeychain

## Quirks

Some things I've learned over the days...

### Orphaned Repo Files
If you run `git status` and find that there are changes to be committed that are all files you deleted, that is because deleting a file in Finder does not delete a file from the git repo. If you have not yet deleted a file from your Finder but want to, you and use one of the following commands.

    $ git rm path/to/file
    $ git rm -rf path/to/folder

However, if you have already deleted these files from the Finder, you can delete them from the repo with this command.

    $ git rm $(git ls-files --deleted)

Then commit with a message like "clean up deleted files". I found this command online and it has been very useful...

### Gitignore Isn't Working?
Sometimes git will not ignore some of the files you specified. Make sure comments are after a `#`. Also, make sure there are no trailing spaces. Lastly, sometimes this issue is caused by files cached by git. To fix that, do the following.

    $ git rm -r --cached
    $ git add .
    $ git commit -m "fixed gitignore"

In fact, I do this a lot. In my `~.bash_profile`, I have and alias for this.

    alias gitclean="git rm -r --cached . && git add ."

Now I run `gitclean` whenever I need.

### Reverting

If you mess up and want to just go back to the latest commit, then user `reset --hard`.

    $ git reset --hard

Sometimes you'll want to see a previous commit. Run `git log`, copy the commit id, then

    $ git checkout <commit id>

Sometimes you'll just want to say fuck it and replace the branch with a previous commit.

    $ git reset --hard <commit id>

Then to update origin master with the new repo, you can force a push to origin/master.

    $ git push origin master --force
