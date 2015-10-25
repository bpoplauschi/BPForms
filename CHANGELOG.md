## [2.1.0 Framework and static lib on Oct 25th, 2015](https://github.com/bpoplauschi/BPForms/releases/tag/2.1.0)
- Added a Framework and a static library target
- Custom insets for headers and footers [#25](https://github.com/bpoplauschi/BPForms/pull/25)

## [2.0.4 Patch release for 2.0.0 (improved) on Oct 22nd, 2015](https://github.com/bpoplauschi/BPForms/releases/tag/2.0.4)
- Fixed the clear button position on float labels [8b1f68a](https://github.com/bpoplauschi/BPForms/commit/8b1f68a)
- Padding fixes, including the ones for the clear button [f954c9e](https://github.com/bpoplauschi/BPForms/commit/f954c9e)
- Added CHANGELOG
- Updated documentation

## [2.0.3 Patch release for 2.0.0 (improved) on Feb 17th, 2015](https://github.com/bpoplauschi/BPForms/releases/tag/2.0.3)
- Created a `BPForms.h` generic header including all core headers - [9348df3](https://github.com/bpoplauschi/BPForms/commit/9348df3)
- Fixed a button size issue - [6460300](https://github.com/bpoplauschi/BPForms/commit/6460300) [0f2c599](https://github.com/bpoplauschi/BPForms/commit/0f2c599)
- Fix bottom inset after keyboard disappears if there is a toolbar - [#23](https://github.com/bpoplauschi/BPForms/pull/23)
- Exposed ways to force the validation on a FormViewController: `forceValidation` and `updateInfoCellBelowInputCell:` - [18d9e80](https://github.com/bpoplauschi/BPForms/commit/18d9e80)
- Info cell aligns to the center (useful on iPad devices) - [c4200a3](https://github.com/bpoplauschi/BPForms/commit/c4200a3)

## [2.0.2 Patch release for 2.0.0 (improved) on Sep 1st, 2014](https://github.com/bpoplauschi/BPForms/releases/tag/2.0.2)
- Allow custom `BPFormCell` to become First Responder - [#16](https://github.com/bpoplauschi/BPForms/pull/16) - [@fabb](https://github.com/fabb)
- Fixed issue with the keyboard height when app is launched in landscape - [#20](https://github.com/bpoplauschi/BPForms/issues/20)
- Fixed crash `[BPFormInfoCell validationState]: unrecognized selector sent to instance` - [#21](https://github.com/bpoplauschi/BPForms/issues/21)

## [2.0.1 Patch release for 2.0.0 on May 28th, 2014](https://github.com/bpoplauschi/BPForms/releases/tag/2.0.1)
Fixed a bunch of issues:
- Fixed: jumping from one cell to the next repeatedly changes the button cells dimensions [#10](https://github.com/bpoplauschi/BPForms/issues/10) [#14](https://github.com/bpoplauschi/BPForms/issues/14)
- Fixed: Resizing TableView Height when Keyboard Appears Ruins Keyboard Transparency in iOS 7 [#12](https://github.com/bpoplauschi/BPForms/issues/12). Thanks to [@fabb](https://github.com/fabb) for the original implementation [#13](https://github.com/bpoplauschi/BPForms/pull/13)
- Fixed: info cell should not be selectable [#15](https://github.com/bpoplauschi/BPForms/issues/15)
- Changed keyboard notification from `didShow` to `willShow`

## [2.0.0 New architecture and easier customisation of cell dimensions on May 8th, 2014](https://github.com/bpoplauschi/BPForms/releases/tag/2.0.0)
The 2.0.0 release brings in a [new class architecture](https://github.com/bpoplauschi/BPForms/raw/master/BPFormsSimpleClassDiagram.jpeg), a `TextView` based input, mechanisms for cell customisation and bug fixes:

- [class architecture refactoring](https://github.com/bpoplauschi/BPForms/raw/master/BPFormsSimpleClassDiagram.jpeg) [87d7230](https://github.com/bpoplauschi/BPForms/commit/87d7230)
  - `BPFormInfoCell` no longer subclasses `BPFormCell`, but `UITableViewCell`
  - `BPFormCellProtocol` contains all the methods for a cell that is member of a `BPFormViewController` table. At this point, implemented by `BPFormCell` and `BPFormInfoCell`
  - `BPFormInputCell` became an abstract class, with usable subclasses `BPFormInputTextFieldClass` and `BPFormInputTextViewClass`
  - renamed `BPFormFloatLabelInputCell` to `BPFormFloatInputTextFieldCell` (subclass of `BPFormInputTextFieldCell`)
  - renamed `BPFormMultiLineFloatLabelInputCell` to `BPFormFloatInputTextViewCell` (subclass of `BPFormInputTextViewCell`)
- cell dimensions customization: easy to achieve using `customCellHeight`, `spaceToNextCell`, `customContentHeight`, `customContentWidth`
- Moved validation icon outside the text input control (textfield, textview) [c4f7bba](https://github.com/bpoplauschi/BPForms/commit/c4f7bba)
- Added keyboard mode to help with using the form view controller in a UIPopover with auto layout [#2](https://github.com/bpoplauschi/BPForms/pull/2) thanks [@snown](https://github.com/snown)
- fixed keyboard disappear table view animation [499177a](https://github.com/bpoplauschi/BPForms/commit/499177a) [4c95725](https://github.com/bpoplauschi/BPForms/commit/4c95725)
- updated input cell validation, for optional cells, so that they aren't validated if empty [8a88078](https://github.com/bpoplauschi/BPForms/commit/8a88078)
- Renamed `BPTextFieldValidateBlockWithPatternAndMessage` to `BPValidateBlockWithPatternAndMessage` [85eb9d3](https://github.com/bpoplauschi/BPForms/commit/85eb9d3)

## [1.1.0 Integration with JVFloatLabeledTextField on Mar 13th, 2014](https://github.com/bpoplauschi/BPForms/releases/tag/1.1.0)
- Integration with [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField) via subspec - [00d45a7](https://github.com/bpoplauschi/BPForms/commit/00d45a7) [6eee6bd](https://github.com/bpoplauschi/BPForms/commit/6eee6bd) [01676aa](https://github.com/bpoplauschi/BPForms/commit/01676aa)
- added text field regex validation convenience method `BPTextFieldValidateBlockWithPatternAndMessage` - [#1](https://github.com/bpoplauschi/BPForms/pull/1) - thanks [@andrei512](https://github.com/andrei512)
- corrected UIKit bad practice - [45d98a5](https://github.com/bpoplauschi/BPForms/commit/45d98a5)

## [1.0.1 Patch for 1.0.0 - fixed UIButton missing on Mar 7th, 2014](https://github.com/bpoplauschi/BPForms/releases/tag/1.0.1)
- `UIButton` missing if frame was not set - fixed by [7fc2af2](https://github.com/bpoplauschi/BPForms/commit/7fc2af2)

## [1.0.0 First release - basic implementation of forms on Mar 6th, 2014](https://github.com/bpoplauschi/BPForms/releases/tag/1.0.0)
- `BPFormViewController` + `BPFormCell` subclasses (input, info and button)
- `BPAppearance` for customisation
