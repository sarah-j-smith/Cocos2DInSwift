Cocos2D In Swift
================

Template project to code a Cocos2D for iOS app in Swift.

Why?  At present even tho' the Cocos2D project supports Swift in principle, there is no practical support for using Swift to actually write a game with Cocos2D.

At present if you use either the XCode templates installed by the Cocos2D projects install script, or use SpriteBuilder - the GUI builder tool - you get an Objective-C project.

I have seen one other how-to but it was a bit vague and used the "Mix-and-Match" feature of Swift to just dump all the Objective-C code in with the main project files.

The approach here is to build Cocos2D as a static library, and then use the Swift briding header technique to bring the headers in.

How Was This Built?

The project was built by

1) Create a standard Objective-C Cocos2D project by 
    File > New Project > iOS > Cocos2D v3.x
    Name "Cocos2DTemplate"

2) Create a Swift Project
    File > New Project > iOS > Single View + Swift
    Name "Cocos2DInSwift"

3) Go to finder, copy the Libraries & Resources directory
    from Cocos2DTemplate
    to Cocos2DInSwift
   via option-drag (don't use XCode for this)

4) Create a Target
   Static library 
   Name "Chipmunk"
   Build Settings > Apple LLVM 6.0 - Language - Objective-C
       Objective-C Automatic Reference Counting: No
   File > "Add files..." > Libraries/Chipmunk
       Add it only to the "Chipmunk" target
   Build Settings > Header Search Paths
       Add:
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/Chipmunk/chipmunk/include"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/Chipmunk/objectivec/include"

5) Create a Target
   Static library
   Name "Cocos2D"
   File > "Add files..." 
       Add all the directories/files other than Chipmunk
       Add them only to the "Cocos2D" target
   Build Settings > Header Search Paths
       Add:
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/Chipmunk/chipmunk/include"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/Chipmunk/objectivec/include"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/cocos2d"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/CCBReader"

6) Click on the main Target "Cocos2DSwift"
   Build Settings > Linking > Other Linker Flags
       -all_load
       without this categories in the Objective-C static libs will not work

   Build Settings > Header Search Paths
       Add:
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/Chipmunk/chipmunk/include"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/Chipmunk/objectivec/include"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/cocos2d"   > Recursive
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/CCBReader"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/cocos2d-ui"
       "$(SRCROOT)/$(PROJECT_NAME)/Libraries/ObjectAL"   > Recursive

   File > New File > iOS > Source > Header File
      Name: "Cocos2DInSwift-Bridging-Header.h"

   Build Settings > Swift Compiler - Code Generation
       Objective-C Bridging Header
       "$(PROJECT_NAME)/Cocos2DInSwift-Bridging-Header.h"

7) Edit the file to contain all headers required:

    #import "cocos2d.h"
    #import "CCBuilderReader.h"
    #import "ObjectiveChipmunk.h"
    #import "ObjectAL.h"

8) Build Settings > Build Phases > Link Binary with Libraries

    Add:
        GLKit.framework
        OpenAL.framework
        libz.dylib
        libCocos2D.a
        libChipmunk.a

9) Should now be able to build the two static libraries and compile the main Swift project
   cleanly.

10) Modify the Swift project to call Cocos2D.  See the file AppDelegate in this project for examples.
   Read the Apple book (on iBooks) "Using Swift with Cocoa and Objective-C".  You can remove the
   storyboard and controller file.  

   Don't forget to go to the Info tab for the "Cocos2DInSwift" target and remove the key which
   references the storyboard file.
