# A Complete Guide to Source Control

This guide is divided into three primary parts:
1. What is Source Control and Why is it Important?
2. Important Terms and Commands
3. Suggested Workflows
4. Which GUI is right for me?
5. The Git Terminal

### What is Source Control and Why is it Important?

Source Control, otherwise known as Version Source Control (VSC) describes a series of methodologies and softwares used to increase workflow productivity, safeguard progress, store files, and share work across multiple users and workstations. There are many VSC's and some of the one's worth being familiar with, at least by name, are Git, Subversion, Perforce, and Mercurial.

Using a VSC is important to all kinds of developers, from artists and programmers to composers and designers. Almost all the work we do as game makers is collaborative, and so having a way to easily trade files is important. But we could just use Google Drive or Dropbox for that. However, the additional functionality to look back on changes to files, who wrote (or broke) what, and the ability to retrieve a comprehensive history of files is what begins to set a VSC above traditional file methods. VSC's also, in many cases, allow multiple users to edit a file at the same time by merging the changes together later.

### Important Terms and Commands

For the rest of this guide, I'll be talking in terms of Github or Git, which is a single VSC among many. Many of the ideas of Git are shared among others, so this should simplify this tutorial without causing too much confusion.

We will be using these terms for the rest of the guide, so familiarize yourself with them. Additionally, these are terms used across the CS industry, so if you want to work pretty much anywhere which uses a VSC, now is the time to learn!

Some important terms to learn with Git are:

##### Geography

* Repository --> a.k.a. repo, this is the root (or top level) folder for the source control, and everything underneath will be under the reign of the VSC.
* Remote --> this describes the state of the repository that all members have access to. You can think of this as 'the cloud'. Changes are made locally and then 'Pushed' to the Remote so that others may have access to them.
* Local --> your local instance of the repo; until you Commit and Push any changes, others will not have access to them
* Branch --> think of a repository as a tree where the trunk is the Master and all branches and leaves are called Branches; Branches come out from the master but unlike trees they should almost always return to the Master eventually. Branches are used to preserve stability and safety of the contents of the Master while a developer adds new features or tries something risky. Creating a branch for this purpose is called 'Pulling a Branch'
* Master --> this is the most important branch in the repository. All other branches can be easily updated with the contents of the Master to share changes across branches and the final and most updated but safe version of the product should usually reside in the Master

##### Essentials

* Commit --> the act of adding any changes to a local branch
* Conflict --> these occur when more than one person edits a file, thus making 2 futures for the file that need to be reconciled into a single, new file; this can usually be fixed in text files with a merge
* Merge --> resolving conflicts across branches or commits; also returning a branch to the Master
* Push --> the act of sending your local committed changes to the remote version of that branch
* Pull --> retrieving the remote version and making any required changes to your local repository
* Sync --> a pull and then a push (retrieval and send)

##### Intermediate

* Stash --> storing any edits to files or deletions of files (but not the creation of new files) on a stack (stacks are first on, last off. This means that if you stash A, B, C. They will return to you as C, B, A)
* Stash Pop --> retrieving the last stash off the stack
* Staged --> changes you wish to commit or stash
* Unstaged --> changes you do not wish to commit or stash but do not with to discard
* Discard --> permanently throwing away a local change before commiting
* Revert --> undoing a push by returning the remote repository to an earlier state

### Suggested Workflows

It will be up to each project to decide which workflow is best for it. Almost always, an agreed-upon structure on each team is critical, but the exact nature of that structure is up to the needs and proficiencies of those involved. I have worked on projects where we pulled hundreds of branches and reviewed people's code before it could merge, and I've worked on R&D projects where the only thing I ever did was commit straight into the master without any branching at all. Each project is different, but here are some heuristics that have served me well:

##### Branch and Merge, With Leads Committing to Master

In this tactic, whenever anyone wants to do anything: add a feature, edit some code, upload art or music, delete a design document --they should pull a branch, commit changes into that branch, and then when they're ready to join everything back in, they should update that branch from the master branch and then submit a pull request (merge). Team leads, where appropriate, or the director, should then approve these. Usually these people can also commit straight into master, without cutting a branch, which will save the team time.

##### Code Review

Code Reviewing is the practice of having leads, usually engineers, look over peoples' code and suggesting fixes, changes, and bringing up possible bugs, edge cases, etc... that the original programmer may not have considered. Code Reviewers are usually skilled and experienced, but it may also be useful to have young programmers code review each others; even at a early stage, different programmers think differently and so this can be fruitful. The easiest way to code review is to look over commit history or check out pull requests (merges) from branches before approval.

##### Stash, Pull, Pop, Push

There are many kinds of conflicts in VSC; conflicts usually occur when two different people change the same file at once and then try to reconcile those separate changes together. Text-file based conflicts are simple and can usually be resolved by simply adding all of the changes together or else by cherry-picking the changes (either by hand or with a Diff Merge tool). However, binary files --like Unity's scenes or prefabs-- require a little more finesse. For these, we want to avoid conflicts altogether, as resolving them is much harder. Binary conflicts are much more common when branching and merging, especially when members forget to update from master before they submit a pull request, which is why lots of teams opt to commit straight into master. This will prevent many types of binary conflicts, but isn't a veyr safe practice, as now anybody at all can 'corrupt' or break the master code. Instead, let's talk about Stash, Pull, Pop, and Push. 

The first command here, Stash, will be used to store our current changes so they don't go away. Next, we will Pull; this brings all recent commit changes from our branch into our working, local repository. Next, we will Pop, which restores our stashed changes. In some GUI's, you will then have to stage all these files next. After that, we can commit and Push. This accomplishes the task of adding our work to the remote repository but is a drastically different, much safer workflow than commit straight into master. This can be done in any branch and combined with earlier mentioned workflows for even greater productivity.

### Which GUI is right for me?

For beginners, I'm going to recommend [Github for Desktop](https://desktop.github.com/). This has your basic branching, push, pull, sync, commit, and merge commands built in and is really simple for first-timers. Quickly, you'll outgrow this, especially if you're a programmer. 

For the brave, I think you're up for [GitKraken](https://www.gitkraken.com/), a javascript-based GUI that has all the basic commands plus easy buttons for stashing, poping, staging and unstaging changes! GitKraken also has an nice branching and merging visualizer along the side, but if you find yourself truly in need of this vis, GitKraken maxes out at 6 branches at a time. 

For the braver, [SourceTree](https://www.sourcetreeapp.com/) is an industry standard, widely-used, incredibly-competent, smooth, sexy GUI. Pretty much every professional I know that doesn't use the Terminal uses SourceTree. Honestly, the only reason I'm not recommending it sooner is that the UI is a little busy for noobs. 

Finally, if you're really feeling underpowered by these GUIs or desirous of a new challenge, check out ...

### The Git Terminal

So you think you can dance? Seriously, the Git Terminal isn't that bad. Sorry I've been creating so much anticipation. The Git Terminal is great because it has all the commands we've gone over (most by name) and tons of other handing ones --like looking up logs or easily accessing git blames, even handling messy merges are often easier in the Terminal. Let's go over some Git Terminal commands:

* git config -> Sets configuration values for your user name, email, gpg key, preferred diff algorithm, file formats and more. Example: git config --global user.name "My Name" git config --global user.email "user@domain.com" cat ~/.gitconfig [user] name = My Name email = user@domain.com
* git init -> Initializes a git repository – creates the initial ‘.git’ directory in a new or in an existing project. Example: cd /home/user/myNewGitFolder/ git init
* git clone -> Makes a Git repository copy from a remote source. Also adds the original location as a remote so you can fetch from it again and push to it if you have permissions. Example: git clone git@github.com:user/test.git
* git add -> Adds files changes in your working directory to your index. Example: git add .
* git rm -> Removes files from your index and your working directory so they will not be tracked. Example: git rm filename
* git commit -> Takes all of the changes written in the index, creates a new commit object pointing to it and sets the branch to point to that new commit. Examples: git commit -m ‘committing added changes’ git commit -a -m ‘committing all changes, equals to git add and git commit’
* git status -> Shows you the status of files in the index versus the working directory. It will list out files that are untracked (only in your working directory), modified (tracked but not yet updated in your index), and staged (added to your index and ready for committing). Example: git status # On branch master # # Initial commit # # Untracked files: # (use "git add <file>..." to include in what will be committed) # # README nothing added to commit but untracked files present (use "git add" to track)
* git branch -> Lists existing branches, including remote branches if ‘-a’ is provided. Creates a new branch if a branch name is provided. Example: git branch -a * master remotes/origin/master
* git checkout -> Checks out a different branch – switches branches by updating the index, working tree, and HEAD to reflect the chosen branch. Example: git checkout newbranch
* git merge -> Merges one or more branches into your current branch and automatically creates a new commit if there are no conflicts. Example: git merge newbranchversion
* git reset -> Resets your index and working directory to the state of your last commit. Example: git reset --hard HEAD
* git stash -> Temporarily saves changes that you don’t want to commit immediately. You can apply the changes later. Example: git stash Saved working directory and index state "WIP on master: 84f241e first commit" HEAD is now at 84f241e first commit (To restore them type "git stash apply")
* git tag -> Tags a specific commit with a simple, human readable handle that never moves. Example: git tag -a v1.0 -m 'this is version 1.0 tag'
* git fetch -> Fetches all the objects from the remote repository that are not present in the local one. Example: git fetch origin
* git pull -> Fetches the files from the remote repository and merges it with your local one. This command is equal to the git fetch and the git merge sequence. Example: git pull origin
* git push -> Pushes all the modified local objects to the remote repository and advances its branches. Example: git push origin master
* git remote -> Shows all the remote versions of your repository. Example: git remote origin
* git log -> Shows a listing of commits on a branch including the corresponding details. Example: git log commit 84f241e8a0d768fb37ff7ad40e294b61a99a0abe Author: User <user@domain.com> Date: Mon May 3 09:24:05 2010 +0300 first commit
* git show -> Shows information about a git object. Example: git show commit 84f241e8a0d768fb37ff7ad40e294b61a99a0abe Author: User <user@domain.com> Date: Mon May 3 09:24:05 2010 +0300 first commit diff --git a/README b/README new file mode 100644 index 0000000..e69de29
* git ls-tree -> Shows a tree object, including the mode and the name of each item and the SHA-1 value of the blob or the tree that it points to. Example: git ls-tree master^{tree} 100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 README
* git cat-file -> Used to view the type of an object through the SHA-1 value. Example: git cat-file -t e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 blob
* git grep -> Lets you search through your trees of content for words and phrases. Example: git grep "www.siteground.com" -- *.php
* git diff -> Generates patch files or statistics of differences between paths or files in your git repository, or your index or your working directory. Example: git diff
* git archive -> Creates a tar or zip file including the contents of a single tree from your repository. Example: git archive --format=zip master^ README >file.zip
* git gc -> Garbage collector for your repository. Optimizes your repository. Should be run occasionally. Example: git gc Counting objects: 7, done. Delta compression using up to 2 threads. Compressing objects: 100% (5/5), done. Writing objects: 100% (7/7), done. Total 7 (delta 1), reused 0 (delta 0)
* git fsck -> Does an integrity check of the Git file system, identifying corrupted objects. Example: git fsck
* git prune -> Removes objects that are no longer pointed to by any object in any reachable branch. Example: git prune

If you're looking for more tips and tricks, check out [https://github.com/git-tips/tips](https://github.com/git-tips/tips) and [http://nuclearsquid.com/writings/git-tricks-tips-workflows/](http://nuclearsquid.com/writings/git-tricks-tips-workflows/) especially the sections on *.gitignore* and *.gitattributes*, which we haven't gone over at all!

### Large File Storage

If you're on Mac, this is super easy. If not, sorry. First, install Homebrew if you don't already have it. The terminal command is:

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Next, let's brew us up some lfs with the command:

brew install git-lfs

After this runs, you can ensure it worked by seeing if lfs initalized. Try the command:

git lfs install

Finally, if you want to use LFS on a file (that is more than 100MBs), then simply track it before you add and commit it. Use the command:

git lfs track <file-name>

[Back](./index.md)
