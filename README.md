# ExpandGridView
A grid view written in QML that expand an area under an item when clicked

# Usage
This component is meant to be used the same way as the regular Qt's GridView.
Meaning, you provide a `ListModel` or a `QVariant<Qlist>` or a C++ object
that subclass `QAbstractItemModel` through the component's variable `model`
along with two delegate, one for the item in each cell (through `delegate`
variable) and one for the item displayed in the expanded zone under the cell
clicked (through `expandDelegate` varaible).

Those are the only mandatory properties but many other one can be used to fit
one's preference.

# Parameters
**\<PropertyName\>** (\<type\> {*required*|\<defaultValue\>}): \<Description\>

## Spacing management
* **rowSpacing** (int 0): Space between two rows
* **colSpacing** (int 0): Space between two columns
* **expandSpacing** (int 0): Space between a row and the expanded zone
* **fillWidth** (bool false): Should the space between cols been maximized
* **fillHeight** (bool false): Should the space between rows been maximized
* **expandFillWidth** (bool false): Should the width of the expanded zone be
the root's width (true) or the row's width (false) (different when there is
space left at end of row)

## Componenent sizes management
* **cellHeight** (int 0): Height of a cell (define only the space available,
the delegate itself can have a different height)
* **cellWidth** (int 0): Width of a cell (define only the space available, the
delegate itself can have a different width)
* **expandHeight** (int 0): Height of the expanded zone (define only the space
available, the expand delegate itself can have a different height)

## Timing management
* **expandDelay** (int 0): The delay before the expanding animation starts
(in ms)
* **collapseDelay** (int 0): The delay before the collapsing animation starts
(in ms)
* **expandDuration** (int 0): The time the expanding animation lasts (in ms)
* **collapseDuration** (int 0): The time the collapsing animation lasts (in ms)

## Model and delegates
* **model** (var *required*): The model (data) to use
* **delegate** (Component *required*): The delegate for the cells
* **expandDelegate** (Component *required*): The delegate for the expanding zone

# Example and testing
An example with all parameters is available at [Example.qml]. It can be used to test how different parameters works and interact with each other
