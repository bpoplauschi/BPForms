## 2.0.3 Patch release for 2.0.0 (improved)
- Created a `BPForms.h` generic header including all core headers - 9348df3
- Fixed a button size issue - 6460300 0f2c599
- Fix bottom inset after keyboard disappears if there is a toolbar - #23 
- Exposed ways to force the validation on a FormViewController: `forceValidation` and `updateInfoCellBelowInputCell:` - 18d9e80
- Info cell aligns to the center (useful on iPad devices) - c4200a3

## 2.0.2 Patch release for 2.0.0 (improved)
- Allow custom `BPFormCell` to become First Responder - #16 - @fabb
- Fixed issue with the keyboard height when app is launched in landscape - #20 
- Fixed crash `[BPFormInfoCell validationState]: unrecognized selector sent to instance` - #21 

## 2.0.1 Patch release for 2.0.0
Fixed a bunch of issues:
- Fixed: jumping from one cell to the next repeatedly changes the button cells dimensions #10 #14 
- Fixed: Resizing TableView Height when Keyboard Appears Ruins Keyboard Transparency in iOS 7 #12. Thanks to @fabb for the original implementation #13 
- Fixed: info cell should not be selectable #15 
- Changed keyboard notification from `didShow` to `willShow`

## 2.0.0 New architecture and easier customisation of cell dimensions
The 2.0.0 release brings in a [new class architecture](https://github.com/bpoplauschi/BPForms/raw/master/BPFormsSimpleClassDiagram.jpeg), a `TextView` based input, mechanisms for cell customisation and bug fixes:

- [class architecture refactoring](https://github.com/bpoplauschi/BPForms/raw/master/BPFormsSimpleClassDiagram.jpeg) 87d7230
  - `BPFormInfoCell` no longer subclasses `BPFormCell`, but `UITableViewCell`
  - `BPFormCellProtocol` contains all the methods for a cell that is member of a `BPFormViewController` table. At this point, implemented by `BPFormCell` and `BPFormInfoCell`
  - `BPFormInputCell` became an abstract class, with usable subclasses `BPFormInputTextFieldClass` and `BPFormInputTextViewClass`
  - renamed `BPFormFloatLabelInputCell` to `BPFormFloatInputTextFieldCell` (subclass of `BPFormInputTextFieldCell`)
  - renamed `BPFormMultiLineFloatLabelInputCell` to `BPFormFloatInputTextViewCell` (subclass of `BPFormInputTextViewCell`)
- cell dimensions customization: easy to achieve using `customCellHeight`, `spaceToNextCell`, `customContentHeight`, `customContentWidth`
- Moved validation icon outside the text input control (textfield, textview) c4f7bba
- Added keyboard mode to help with using the form view controller in a UIPopover with auto layout #2 thanks @snown
- fixed keyboard disappear table view animation 499177a 4c95725
- updated input cell validation, for optional cells, so that they aren't validated if empty 8a88078
- Renamed `BPTextFieldValidateBlockWithPatternAndMessage` to `BPValidateBlockWithPatternAndMessage` 85eb9d3

## 1.1.0 Integration with JVFloatLabeledTextField
- Integration with [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField) via subspec - 00d45a7 6eee6bd 01676aa
- added text field regex validation convenience method BPTextFieldValidateBlockWithPatternAndMessage - #1 - thanks @andrei512
- corrected UIKit bad practice - 45d98a5

## 1.0.1 Patch for 1.0.0 - fixed UIButton missing
- UIButton missing if frame was not set - fixed by 7fc2af2

## 1.0.0 First release - basic implementation of forms
- BPFormViewController + BPFormCell subclasses (input, info and button)
- BPAppearance for customisation