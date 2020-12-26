#!/bin/sh

# iTerm2
defaults write com.googlecode.iterm2 DisableWindowSizeSnap -integer 1

# Retctangle
defaults write com.knollsoft.Rectangle snapEdgeMarginTop -int 6
defaults write com.knollsoft.Rectangle snapEdgeMarginBottom -int 6
defaults write com.knollsoft.Rectangle snapEdgeMarginLeft -int 6
defaults write com.knollsoft.Rectangle snapEdgeMarginRight -int 6

defaults write com.knollsoft.Rectangle screenEdgeGapTop -int 30
defaults write com.knollsoft.Rectangle screenEdgeGapBottom -int 0
defaults write com.knollsoft.Rectangle screenEdgeGapLeft -int 0
defaults write com.knollsoft.Rectangle screenEdgeGapRight -int 0
