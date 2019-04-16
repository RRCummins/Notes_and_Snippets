# Swift - Git and Bash Notes

## Terms

## The following bash for cloning a file

<pre><code>
Ryans-MacBook-Pro:Development ryancummins$ cd /Users/ryancummins/Development/AppBrewery 
Ryans-MacBook-Pro:AppBrewery ryancummins$ mkdir Open_Source_Apps
Ryans-MacBook-Pro:AppBrewery ryancummins$ cd Open_Source_Apps
Ryans-MacBook-Pro:Open_Source_Apps ryancummins$ git clone https://github.com/austinzheng/swift-2048.git
Cloning into 'swift-2048'...
remote: Enumerating objects: 287, done.
remote: Total 287 (delta 0), reused 0 (delta 0), pack-reused 287
Receiving objects: 100% (287/287), 93.70 KiB | 1.27 MiB/s, done.
Resolving deltas: 100% (155/155), done.
Ryans-MacBook-Pro:Open_Source_Apps ryancummins$ 

</code></pre>

## Git commands in bash

<pre><code>
git diff chapter3.txt

git init

touch .gitignore

ls -a   'This list all file, even hidden ones'

git status

git add chapter3.txt

git commit -m -> "Some Commit Notes Here"

git log

git checkout chapter3.txt
</code></pre>

## Useful commands in Bash

<pre><code>
cd ~/Desktop/ -> 'goes to the desktop'

mkdir Testing -> 'Creates a folder called Testing'

touch Test.txt -> 'Creates a file called Test.txt'

open Test.txt -> 'Opens Test.txt is the default text editor'

cd ~ -> 'Goes to root'

cd .. -> 'Goes up a folder level'

clear -> 'Clears the terminal screen'

[Option/alt key] -> "Allows you to insert the cures while holding that key'



</code></pre>

## The following is bach for initializing git, then commiting, and then pushing to a remote server

<pre><code>
Ryans-MacBook-Pro:~ ryancummins$ cd /Users/ryancummins/Development/AppBrewery/GitTest 
Ryans-MacBook-Pro:GitTest ryancummins$ git init
Initialized empty Git repository in /Users/ryancummins/Development/AppBrewery/GitTest/.git/
Ryans-MacBook-Pro:GitTest ryancummins$ git add .
Ryans-MacBook-Pro:GitTest ryancummins$ git status
On branch master

No commits yet

Changes to be committed:
(use "git rm --cached <file>..." to unstage)

new file:   GitTest.xcodeproj/project.pbxproj
new file:   GitTest.xcodeproj/project.xcworkspace/contents.xcworkspacedata
new file:   GitTest.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
new file:   GitTest/AppDelegate.swift
new file:   GitTest/Assets.xcassets/AppIcon.appiconset/Contents.json
new file:   GitTest/Assets.xcassets/Contents.json
new file:   GitTest/Base.lproj/LaunchScreen.storyboard
new file:   GitTest/Base.lproj/Main.storyboard
new file:   GitTest/Info.plist
new file:   GitTest/ViewController.swift
new file:   GitTestTests/GitTestTests.swift
new file:   GitTestTests/Info.plist
new file:   GitTestUITests/GitTestUITests.swift
new file:   GitTestUITests/Info.plist

Ryans-MacBook-Pro:GitTest ryancummins$ git commit -m "Initial Commit"
Ryans-MacBook-Pro:GitTest ryancummins$ git remote add origin https://github.com/RRCummins/Story.git
Ryans-MacBook-Pro:GitTest ryancummins$ git push -u origin master
To https://github.com/RRCummins/Story.git

</code></pre>

## This is how you create a branch
<pre><code>
Ryans-MacBook-Pro:Story ryancummins$ git branch alien-plot
Ryans-MacBook-Pro:Story ryancummins$ git branch
  alien-plot
* master
</code></pre>

## Switching Branches

<pre><code>
Ryans-MacBook-Pro:Story ryancummins$ git checkout alien-plot
Switched to branch 'alien-plot'
</code></pre>

## Merging branches

<pre><code>
Ryans-MacBook-Pro:Story ryancummins$ git checkout alien-plot
Switched to branch 'alien-plot'
Ryans-MacBook-Pro:Story ryancummins$ git checkout master
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Ryans-MacBook-Pro:Story ryancummins$ git merge alien-plot

//Then you need to quit the merge VIM editor
 :q!

Merge made by the 'recursive' strategy.
 chapter1.txt | 2 +-
 chapter2.txt | 2 +-
 chapter3.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

 Then you need to quit the merge VIM editor
 :q!
</code></pre>

## VIM Save and Quit the merge VIM editor

<pre><code>
:q!
</code></pre>

## The following is my bash commands for creating a .gitignore file

<pre><code>
Ryans-MacBook-Pro:~ ryancummins$ cd /Users/ryancummins/Development/AppBrewery/GitTest 
Ryans-MacBook-Pro:GitTest ryancummins$ touch .gitignore
Ryans-MacBook-Pro:GitTest ryancummins$ open .gitignore
Ryans-MacBook-Pro:GitTest ryancummins$ git init
Initialized empty Git repository in /Users/ryancummins/Development/AppBrewery/GitTest/.git/
Ryans-MacBook-Pro:GitTest ryancummins$ git add .
Ryans-MacBook-Pro:GitTest ryancummins$ git status
On branch master

No commits yet

Changes to be committed:
(use "git rm --cached <file>..." to unstage)

new file:   .gitignore
new file:   GitTest.xcodeproj/project.pbxproj
new file:   GitTest.xcodeproj/project.xcworkspace/contents.xcworkspacedata
new file:   GitTest.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
new file:   GitTest/AppDelegate.swift
new file:   GitTest/Assets.xcassets/AppIcon.appiconset/Contents.json
new file:   GitTest/Assets.xcassets/Contents.json
new file:   GitTest/Base.lproj/LaunchScreen.storyboard
new file:   GitTest/Base.lproj/Main.storyboard
new file:   GitTest/Info.plist
new file:   GitTest/ViewController.swift
new file:   GitTestTests/GitTestTests.swift
new file:   GitTestTests/Info.plist
new file:   GitTestUITests/GitTestUITests.swift
new file:   GitTestUITests/Info.plist

Ryans-MacBook-Pro:GitTest ryancummins$ git commit -m "Initial Commit"
[master (root-commit) 5cd775f] Initial Commit
15 files changed, 1071 insertions(+)
create mode 100644 .gitignore
create mode 100644 GitTest.xcodeproj/project.pbxproj
create mode 100644 GitTest.xcodeproj/project.xcworkspace/contents.xcworkspacedata
create mode 100644 GitTest.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
create mode 100644 GitTest/AppDelegate.swift
create mode 100644 GitTest/Assets.xcassets/AppIcon.appiconset/Contents.json
create mode 100644 GitTest/Assets.xcassets/Contents.json
create mode 100644 GitTest/Base.lproj/LaunchScreen.storyboard
create mode 100644 GitTest/Base.lproj/Main.storyboard
create mode 100644 GitTest/Info.plist
create mode 100644 GitTest/ViewController.swift
create mode 100644 GitTestTests/GitTestTests.swift
create mode 100644 GitTestTests/Info.plist
create mode 100644 GitTestUITests/GitTestUITests.swift
create mode 100644 GitTestUITests/Info.plist
Ryans-MacBook-Pro:GitTest ryancummins$ 

</code></pre>

## The Following is the GitHub recommended contents of a .gitignore file for Swift
[GitHub Swift .gitignore Repo](https://github.com/github/gitignore/blob/master/Swift.gitignore)

<pre><code>
# Xcode
#
# gitignore contributors: remember to update Global/Xcode.gitignore, Objective-C.gitignore & Swift.gitignore

## Build generated
build/
DerivedData/

## Various settings
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata/

## Other
*.moved-aside
*.xccheckout
*.xcscmblueprint

## Obj-C/Swift specific
*.hmap
*.ipa
*.dSYM.zip
*.dSYM

## Playgrounds
timeline.xctimeline
playground.xcworkspace

# Swift Package Manager
#
# Add this line if you want to avoid checking in source code from Swift Package Manager dependencies.
# Packages/
# Package.pins
# Package.resolved
.build/

# CocoaPods
#
# We recommend against adding the Pods directory to your .gitignore. However
# you should judge for yourself, the pros and cons are mentioned at:
# https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
#
# Pods/
#
# Add this line if you want to avoid checking in source code from the Xcode workspace
# *.xcworkspace

# Carthage
#
# Add this line if you want to avoid checking in source code from Carthage dependencies.
# Carthage/Checkouts

Carthage/Build

# fastlane
#
# It is recommended to not store the screenshots in the git repo. Instead, use fastlane to re-generate the
# screenshots whenever they are needed.
# For more information about the recommended setup visit:
# https://docs.fastlane.tools/best-practices/source-control/#source-control

fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/**/*.png
fastlane/test_output

# Code Injection
#
# After new code Injection tools there's a generated folder /iOSInjectionProject
# https://github.com/johnno1962/injectionforxcode

iOSInjectionProject/
</code></pre>
