export THEOS=/var/theos/makefiles/tweak.mk

include THEOS=/var/theos/makefiles/common.mk
ARCHS = arm64 

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

TWEAK_NAME = CODM

CODM_FRAMEWORKS =  UIKit Foundation Security QuartzCore CoreGraphics CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController

CODM_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
CODM_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

CODM_FILES = ImGuiDrawView.mm $(wildcard Esp/*.mm) $(wildcard Esp/*.m) $(wildcard KittyMemory/*.cpp) $(wildcard KittyMemory/*.mm) $(wildcard KittyMemory/*.m) $(wildcard las/*.m) 


#LQMNemOS_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

after-install::
   install.exec "killall -9 cod || :"


