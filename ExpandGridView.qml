import QtQuick 2.0

Flickable {
    id: root

    property int rowSpacing: 0          // Space between two rows
    property int colSpacing: 0          // Space between two columns
    property int expandSpacing: 0       // Space between a row and the expanded zone
    property bool fillWidth: false      // Should the space between cols been maximized
    property bool fillHeight: false     // Should the space between rows been maximized

    property int cellHeight: 0          // Height of a cell
    property int cellWidth: 0           // Width of a cell
    property int expandHeight: 0        // Height of the expanded zone

    // Should the width of the expanded zone be the root's width (true)
    // or the row's width (false) (different when there is space left at end of row)
    property bool expandFillWidth: false

    property int expandDelay: 0         // The delay before the expanding animation starts (in ms)
    property int collapseDelay: 0       // The delay before the collapsing animation starts (in ms)
    property int expandDuration: 0      // The time the expanding animation lasts (in ms)
    property int collapseDuration: 0    // The time the collapsing animation lasts (in ms)

    property var model                  // The model (data) to use
    property Component delegate         // The delegate for the cells
    property Component expandDelegate   // The delegate for the expanding zone
    
    QtObject {
        id: priv
        property int itemsPerRow: Math.floor( width/(cellWidth+colSpacing) )
        property int nbLines: Math.ceil( root.model.count / itemsPerRow )
        property int expandItemIndex: -1
    }

    function calc_begin(row_num) {
        return row_num * priv.itemsPerRow;
    }
    function calc_end(row_num) {
        return Math.min(
            calc_begin(row_num+1) - 1,
            model.count - 1
        );
    }
    function calc_row_spacing() {
        if (fillHeight) {
            if (priv.expandItemIndex != -1)
                return Math.floor( (root.height-expandHeight-expandSpacing-priv.nbLines*cellHeight) / (priv.nbLines-1) )
            else
                return Math.floor( (root.height-priv.nbLines*cellHeight) / (priv.nbLines-1) )
        } else {
            return rowSpacing
        }
    }
    function calc_content_height () {
        if (fillHeight) {
            return height;
        } else {
            if (priv.expandItemIndex != -1)
                return priv.nbLines*(cellHeight+rowSpacing) - rowSpacing + expandSpacing + expandHeight;
            else
                return priv.nbLines*(cellHeight+rowSpacing) - rowSpacing;
        }
    }

    function toggleExpandAll( i ) {
        if (i != priv.expandItemIndex && i >= 0 && i <= model.count )
            priv.expandItemIndex = i;
        else
            priv.expandItemIndex = -1;
    }

    contentHeight: calc_content_height();
    contentWidth: width
    
    Column {
        anchors.fill: parent

        spacing : calc_row_spacing()

        Repeater {
            model: priv.nbLines

            ExpandGridViewRow {
                beginIndex: calc_begin(index)
                endIndex: calc_end(index)
                expandItemIndex: priv.expandItemIndex

                model: root.model
                delegate: root.delegate
                expandDelegate: root.expandDelegate

                colSpacing: root.colSpacing
                rowSpacing: root.rowSpacing
                expandSpacing: root.expandSpacing
                fillWidth: root.fillWidth
                fillHeight: root.fillHeight

                cellHeight: root.cellHeight
                cellWidth: root.cellWidth
                expandHeight: root.expandHeight

                expandFillWidth: root.expandFillWidth
                rootMaxWidth: root.width

                expandDelay: root.expandDelay
                collapseDelay: root.collapseDelay
                expandDuration: root.expandDuration
                collapseDuration: root.collapseDuration

                itemsPerRow: priv.itemsPerRow

                function toggleExpand(i) {
                    toggleExpandAll(i);
                }
            }
        }

    }
}