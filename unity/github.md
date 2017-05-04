# Using GitHub with Unity

This article discusses how to effectively use [GitHub](https://github.com) with [Unity](https://unity3d.com/) to prevent as many headaches as possible.

## Initial Setup

So, you're trying to use Unity with Git/GitHub?

If you've never tried before, it's usually a pain. Unity uses plenty of [binary files](https://en.wikipedia.org/wiki/Binary_file) by default, which cannot be merged together by Git without a conflict. Luckily, Unity has some convenient options that cause most of these binary files to instead be written as text files, which can be merged! Additionally, it's very important to acquire a functioning `.gitignore` file, in order to avoid committing the thousands of files that Unity autogenerates. Let's talk about these two things!

## `.gitignore`

The first thing you'll need to do is setup your repository. If you're confused about how to setup a repository, go ahead and check out the wiki article on GitHub [here]().

Before you start committing your Unity project into the repository, it's pretty important to first get a functioning `.gitignore` file. Luckily, GitHub actually has a built in Unity `.gitignore`, which is located in a dropdown menu on repository creation!

However, if your project folder is nested inside the repository folder (such that your project hierarchy looks like `/Repository/UnityProject/Assets/...`), you'll need to make a few edits to the given `.gitignore`. Below, I've provided a link to the basic Unity `.gitignore` and the edited Unity `.gitignore`, so you can see the differences (and so you can download and use the edited version easily).

### Basic Unity `.gitignore`

[Base Unity .gitignore](https://gist.github.com/ferociouself/f0baf721090ca7a6cbcc4ced3f27ba3d)

This is the basic Unity `.gitignore` file. However, there are some problems...

### Edited Unity `.gitignore`

[Edited Unity .gitignore](https://gist.github.com/ferociouself/b2d7b6e58092afec275f3f8ed59762d1)

This is the edited version of the Unity `.gitignore` file. As you can see, all that I've added is the stars in front of the various directory pointers, which allows the `.gitignore` to successfully traverse down to your files.

There may be some other changes you need to make to the `.gitignore`, depending on your specific project, but the provided edited version of the `.gitignore` should satisfy most of your project cleanliness needs.

It should be noted that if you have your base Unity folder set as the repository folder itself (such that your project hierarchy looks like `/repository_name/Assets/...`), then you can just use the basic Unity `.gitignore`. However, for readability purposes and ease of use, it might make sense to separate the repository folder from the Unity folder itself (for example, if you want to provide a folder for 3D models to be placed, in preparation for proper importing). It's totally up to you!

## After the `.gitignore`

Now that you have your `.gitignore` file in place and committed to the repository, you can set up your Unity project! Go ahead and clone the repository to your computer through whatever means you are comfortable with.

Next, we need to create the project. Go ahead and create the project in Unity, and make sure that the project is being created in your repository folder.

Once you're in Unity, find your way to the Editor settings in Project Settings. On my Mac, the path to this option is `Edit -> Project Settings -> Editor`. Once you're here, you'll notice that the Inspector now shows a bunch of dropdown options. There are two options you'll want to change; **Version Control** and **Asset Serialization**. **Version Control** should be set to *Visible Meta Files*, and **Asset Serialization** should be set to *Force Text*. More on this later.

Once you've done this, your project is ready to go! The `.gitignore` file should ignore everything that Unity autogenerates, and there shouldn't be nearly as many binary files.

## Binary Files to Text Files

But why are binary files bad? Well, for one, binary files cannot be merged together at all. Git is great and will often merge together text files automatically, assuming that the two users did not edit the same lines. However, there is no way for Git to tell whether or not two different users have edited separate parts of a binary file, due to the structure of these files.

This most often comes up with scene files in Unity (denoted with the .unity extension). If two users were to work in one scene, such as your main scene, at the same time, then a merge conflict would occur. With binary files, one user will ALWAYS lose their changes; there's just no way around this. With text files, there is a possibility of recovery.

## Dealing with Conflicts

However, this possibility is not a certainty. Unity does a lot of work behind the scenes to create these files, and as such, changes that seem like they shouldn't conflict might end up conflicting. So, what should you do when they do conflict?

There are two options: manually merge the files together, or choose one file to move forward with. With the first option, is it theoretically possible to keep both user's changes. However, especially with Unity generated text files, it may be extremely difficult or even impossible to understand what the various changes actually mean. If you're still determined to get this to work, go ahead and check out the article on merge conflicts in the main GitHub wiki heading for more information on manually merging.

In the vast majority of merge conflicts with Unity, you'll likely want to move forward with just one item. This should again be discussed under the GitHub wiki, but I will also quickly discuss it here for your convenience.

The biggest challenge with doing this will be working with the Git terminal or shell. Don't worry though; it's really not that hard! In fact, here are the 5 commands you'll need.

1. `git status`
   My first advice would be to run this command to see exactly what is conflicting. The conflicting files will show up in red, and git should tell you exactly what is wrong with them (added by both, deleted by both, added by us, etc.).

2. `git checkout --ours/theirs path/to/the/file`
   What this command will do is overwrite the file in question with either the file you are pulling in, or the file you are trying to push. The safest option is generally to use the `--theirs` option; hopefully, you know what changes you made. However, if you don't remember, or if the changes were of too large a scale, go ahead and talk to your team and figure out what the conflicting changes actually are. Most of the time it's not a huge deal, in which case you're free to use the `--ours` option to overwrite their changes with yours.

   Make sure to run this command for every conflicting file.

3. `git add .`
   This adds all changes detected in the repository to your commit.

4. `git commit -m "Message Goes Here"`
   This will create the commit with the given message. I usually use "Merge Changes" or "Merge Conflict", but it's obviously up to you.

5. `git push`
   This pushes your commit to the GitHub. It's sort of like syncing on GitHub Desktop.

Once you've run all of these commands, go ahead and jump back to the GitHub Desktop client and sync again, just to make sure that everything went through properly.

## Aside: Meta Files

One other problem you'll run into quite often are `.meta` files. These files are used by Unity on importing to organize files. They are especially useful on sprites, where they store the data that determines how spritesheets are sliced, how the editor should draw these sprites, etc. Each `.meta` file contains data on when the file was imported/created, among other things. This means that if these `.meta` files are generated by different users at different times for the same file, then a merge conflict will occur.

The biggest problem that will occur with these merge conflicts will come when users commit changes that they don't fully understand. Because these `.meta` files are text files, Git will allow the users to merge the text manually by adding >>>>>>>HEAD to the file, among other things. This will confuse the heck out of Unity, and will likely break any changes that these `.meta` files were keeping track of. The solution to this problem is really to just educate your team members about what `.meta` files are and why they need to actually resolve the conflict by manually merging the files together (or using `git checkout`).

One last thing about `.meta` files; in order to actually create a folder in the repository from Unity, the folder in Unity must have something in it. In other words, Unity will create a `.meta` file for a folder, but it won't actually create the folder until a file is inside of it. I usually put a dummy file in each of my folders, just to make sure that Unity creates the folder and that it will commit into the repository. Otherwise you'll probably have some merge conflicts at the beginning related to people creating folders of the same name.

## Conclusion

So that's it! Those are really the biggest problems when it comes to using Git/GitHub with Unity. I'm sure there will probably be other problems you encounter along the way, likely related to GitHub. Hopefully you can find an answer either in the GitHub section of our wiki, or online!

[Back](./index.md)
