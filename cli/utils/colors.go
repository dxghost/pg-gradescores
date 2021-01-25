package utils

import "github.com/fatih/color"

// Green color
var Green = color.New(color.FgHiGreen).SprintFunc()
// Red color
var Red = color.New(color.FgRed).SprintFunc()
// Yellow color
var Yellow = color.New(color.FgHiYellow).SprintFunc()
// Cyan color
var Cyan = color.New(color.FgHiCyan).SprintFunc()
// BlinkingMagenta for prompt
var BlinkingMagenta = color.New(color.FgMagenta,color.BlinkSlow).SprintFunc()