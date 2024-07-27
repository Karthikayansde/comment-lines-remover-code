import 'package:comment_lines_remover/components/Dropdown/Controller/chip_config.dart';
import 'package:comment_lines_remover/components/Dropdown/Controller/value_item.dart';
import 'package:flutter/material.dart';

/// [SelectionChip] is a selected option chip builder.
/// It is used to build the selected option chip.
class SelectionChip extends StatelessWidget {
  final ChipConfig chipConfig;
  final Function(ValueItem) onItemDelete;
  final ValueItem item;

  const SelectionChip({
    super.key,
    required this.chipConfig,
    required this.item,
    required this.onItemDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: chipConfig.padding,
      label: Text(item.label),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(chipConfig.radius),
      ),
      deleteIcon: chipConfig.deleteIcon,
      deleteIconColor: chipConfig.deleteIconColor,
      labelPadding: chipConfig.labelPadding,
      backgroundColor:
          chipConfig.backgroundColor ?? Theme.of(context).primaryColor,
      labelStyle: chipConfig.labelStyle ??
          TextStyle(color: chipConfig.labelColor, fontSize: 14),
      onDeleted: () => onItemDelete(item),
    );
  }
}
