library multiselect_dropdown;

import 'dart:convert';

import 'package:comment_lines_remover/commons/colors.dart';
import 'package:comment_lines_remover/components/Dropdown/Controller/chip_config.dart';
import 'package:comment_lines_remover/components/Dropdown/Controller/network_config.dart';
import 'package:comment_lines_remover/components/Dropdown/Controller/value_item.dart';
import 'package:comment_lines_remover/components/Dropdown/Enum/app_enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



typedef OnOptionSelected = void Function(List<ValueItem> selectedOptions);

class MultiSelectDropDown2 extends StatefulWidget {
  final SelectionType selectionType;

  // Hint
  final String hint;
  final Color? hintColor;
  final double? hintFontSize;
  final TextStyle? hintStyle;

  // Options
  final List<ValueItem> options;
  final List<ValueItem> selectedOptions;
  final List<ValueItem> disabledOptions;

  final OnOptionSelected? onOptionSelected;

  // selected option
  final Icon? selectedOptionIcon;
  final Color? selectedOptionTextColor;
  final Color? selectedOptionBackgroundColor;
  final Widget Function(BuildContext, ValueItem)? selectedItemBuilder;

  // chip configuration
  final bool showChipInSingleSelectMode;
  final ChipConfig chipConfig;

  // options configuration
  final Color? optionsBackgroundColor;
  final TextStyle? optionTextStyle;
  final Widget? optionSeperator;
  final double dropdownHeight;
  final Widget? optionSeparator;
  final bool alwaysShowOptionIcon;

  // dropdownfield configuration
  final Color? backgroundColor;
  final Icon? suffixIcon;
  final Icon? clearIcon;
  final Decoration? inputDecoration;
  final double? borderRadius;
  final BorderRadiusGeometry? radiusGeometry;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderWidth;
  final double? focusedBorderWidth;
  final EdgeInsets? padding;
  final bool showClearIcon;
  final int? maxItems;

  // network configuration
  final NetworkConfig? networkConfig;
  final Future<List<ValueItem>> Function(dynamic)? responseParser;
  final Widget Function(BuildContext, dynamic)? responseErrorBuilder;
 ///ignore: prefer_typing_uninitialized_variables
  final firstone;
  /// focus node
  final FocusNode? focusNode;

  /// Controller for the dropdown
  /// [controller] is the controller for the dropdown. It can be used to programmatically open and close the dropdown.
  final MultiSelectController? controller;

  /// Enable search
  /// [searchEnabled] is the flag to enable search in dropdown. It is used to show search bar in dropdown.
  final bool searchEnabled;

  /// MultiSelectDropDown is a widget that allows the user to select multiple options from a list of options. It is a dropdown that allows the user to select multiple options.
  ///
  ///  **Selection Type**
  ///
  ///   [selectionType] is the type of selection that the user can make. The default is [SelectionType.single].
  /// * [SelectionType.single] - allows the user to select only one option.
  /// * [SelectionType.multi] - allows the user to select multiple options.
  ///
  ///  **Options**
  ///
  /// [options] is the list of options that the user can select from. The options need to be of type [ValueItem].
  ///
  /// [selectedOptions] is the list of options that are pre-selected when the widget is first displayed. The options need to be of type [ValueItem].
  ///
  /// [disabledOptions] is the list of options that the user cannot select. The options need to be of type [ValueItem]. If the items in this list are not available in options, will be ignored.
  ///
  /// [onOptionSelected] is the callback that is called when an option is selected or unselected. The callback takes one argument of type `List<ValueItem>`.
  ///
  /// **Selected Option**
  ///
  /// [selectedOptionIcon] is the icon that is used to indicate the selected option.
  ///
  /// [selectedOptionTextColor] is the color of the selected option.
  ///
  /// [selectedOptionBackgroundColor] is the background color of the selected option.
  ///
  /// [selectedItemBuilder] is the builder that is used to build the selected option. If this is not provided, the default builder is used.
  ///
  /// **Chip Configuration**
  ///
  /// [showChipInSingleSelectMode] is used to show the chip in single select mode. The default is false.
  ///
  /// [chipConfig] is the configuration for the chip.
  ///
  /// **Options Configuration**
  ///
  /// [optionsBackgroundColor] is the background color of the options. The default is [Colors.white].
  ///
  /// [optionTextStyle] is the text style of the options.
  ///
  /// [optionSeperator] is the seperator between the options.
  ///
  /// [dropdownHeight] is the height of the dropdown options. The default is 200.
  ///
  ///  **Dropdown Configuration**
  ///
  /// [backgroundColor] is the background color of the dropdown. The default is [Colors.white].
  ///
  /// [suffixIcon] is the icon that is used to indicate the dropdown. The default is [Icons.arrow_drop_down].
  ///
  /// [inputDecoration] is the decoration of the dropdown.
  ///
  /// [dropdownHeight] is the height of the dropdown. The default is 200.
  ///
  ///  **Hint**
  ///
  /// [hint] is the hint text to be displayed when no option is selected.
  ///
  /// [hintColor] is the color of the hint text. The default is [Colors.grey.shade300].
  ///
  /// [hintFontSize] is the font size of the hint text. The default is 14.0.
  ///
  /// [hintStyle] is the style of the hint text.
  ///
  ///  **Example**
  ///
  /// ```dart
  ///  final List<ValueItem> options = [
  ///     ValueItem(label: 'Option 1', value: '1'),
  ///     ValueItem(label: 'Option 2', value: '2'),
  ///     ValueItem(label: 'Option 3', value: '3'),
  ///   ];
  ///
  ///   final List<ValueItem> selectedOptions = [
  ///     ValueItem(label: 'Option 1', value: '1'),
  ///   ];
  ///
  ///   final List<ValueItem> disabledOptions = [
  ///     ValueItem(label: 'Option 2', value: '2'),
  ///   ];
  ///
  ///  MultiSelectDropDown(
  ///    onOptionSelected: (option) {},
  ///    options: const <ValueItem>[
  ///       ValueItem(label: 'Option 1', value: '1'),
  ///       ValueItem(label: 'Option 2', value: '2'),
  ///       ValueItem(label: 'Option 3', value: '3'),
  ///       ValueItem(label: 'Option 4', value: '4'),
  ///       ValueItem(label: 'Option 5', value: '5'),
  ///       ValueItem(label: 'Option 6', value: '6'),
  ///    ],
  ///    selectionType: SelectionType.multi,
  ///    selectedOptions: selectedOptions,
  ///    disabledOptions: disabledOptions,
  ///    onOptionSelected: (List<ValueItem> selectedOptions) {
  ///      debugPrint('onOptionSelected: $option');
  ///    },
  ///    chipConfig: const ChipConfig(wrapType: WrapType.scroll),
  ///    );
  /// ```

  const MultiSelectDropDown2(
      {super.key,
        required this.onOptionSelected,
        required this.options,
        this.selectedOptionTextColor,
        this.optionSeperator,
        this.chipConfig = const ChipConfig(),
        this.selectionType = SelectionType.multi,
        this.hint = 'Select',
        this.hintColor = Colors.grey,
        this.hintFontSize = 14.0,
        this.selectedOptions = const [],
        this.disabledOptions = const [],
        this.alwaysShowOptionIcon = false,
        this.optionTextStyle,
        this.selectedOptionIcon = const Icon(Icons.check),
        this.selectedOptionBackgroundColor,
        this.optionsBackgroundColor,
        this.backgroundColor = Colors.white,
        this.dropdownHeight = 200,
        this.showChipInSingleSelectMode = false,
        this.suffixIcon = const Icon(Icons.arrow_drop_down),
        this.clearIcon = const Icon(Icons.close_outlined, size: 14),
        this.selectedItemBuilder,
        this.optionSeparator,
        this.inputDecoration,
        this.hintStyle,
        this.padding,
        this.focusedBorderColor = Colors.black54,
        this.borderColor = Colors.grey,
        this.borderWidth = 0.4,
        this.focusedBorderWidth = 0.4,
        this.borderRadius = 12.0,
        this.radiusGeometry,
        this.showClearIcon = true,
        this.maxItems,
        this.focusNode,
        required this.firstone,
        this.controller,
        this.searchEnabled = false})
      : networkConfig = null,
        responseParser = null,
        responseErrorBuilder = null;

  /// Constructor for MultiSelectDropDown that fetches the options from a network call.
  /// [networkConfig] is the configuration for the network call.
  /// [responseParser] is the parser that is used to parse the response from the network call.
  /// [responseErrorBuilder] is the builder that is used to build the error widget when the network call fails.

  const MultiSelectDropDown2.network(
      {super.key,
        required this.networkConfig,
        required this.responseParser,
        this.responseErrorBuilder,
        required this.onOptionSelected,
        this.selectedOptionTextColor,
        this.optionSeperator,
        this.chipConfig = const ChipConfig(),
        this.selectionType = SelectionType.multi,
        this.hint = 'Select',
        this.hintColor = Colors.grey,
        this.hintFontSize = 14.0,
        this.selectedOptions = const [],
        this.disabledOptions = const [],
        this.alwaysShowOptionIcon = false,
        this.optionTextStyle,
        this.selectedOptionIcon = const Icon(Icons.check),
        this.selectedOptionBackgroundColor,
        this.optionsBackgroundColor,
        this.backgroundColor = Colors.white,
        this.dropdownHeight = 200,
        this.showChipInSingleSelectMode = false,
        this.suffixIcon = const Icon(Icons.arrow_drop_down),
        this.clearIcon = const Icon(Icons.close_outlined, size: 14),
        this.selectedItemBuilder,
        this.optionSeparator,
        this.inputDecoration,
        this.hintStyle,
        this.padding,
        this.borderColor = Colors.grey,
        this.focusedBorderColor = Colors.black54,
        this.borderWidth = 0.4,
        this.focusedBorderWidth = 0.4,
        this.borderRadius = 12.0,
        this.radiusGeometry,
        this.showClearIcon = true,
        this.maxItems,
        this.focusNode,
        this.controller,
        required this.firstone,
        this.searchEnabled = false})
      : options = const [];

  @override
  State<MultiSelectDropDown2> createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown2> {
  /// Options list that is used to display the options.
  final List<ValueItem> _options = [];

  /// Selected options list that is used to display the selected options.
  final List<ValueItem> _selectedOptions = [];

  /// Disabled options list that is used to display the disabled options.
  final List<ValueItem> _disabledOptions = [];

  /// The controller for the dropdown.
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _selectionMode = false;

  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();

  /// Response from the network call.
  dynamic _reponseBody;

  /// value notifier that is used for controller.
  MultiSelectController? _controller;

  /// search field focus node
  FocusNode? _searchFocusNode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.controller != null) {
      _controller = widget.controller;
    }
  }

  /// Initializes the options, selected options and disabled options.
  /// If the options are fetched from the network, then the network call is made.
  /// If the options are passed as a parameter, then the options are initialized.
  void _initialize() async {
    if (!mounted) return;
    if (widget.networkConfig?.url != null) {
      await _fetchNetwork();
    } else {
      _options.addAll(widget.options);
    }
    _addOptions();
   ///ignore: use_build_context_synchronously
    _overlayState ??= Overlay.of(context);
    _focusNode.addListener(_handleFocusChange);

    if (widget.searchEnabled) {
      _searchFocusNode = FocusNode();
      _searchFocusNode!.addListener(_handleFocusChange);
    }
  }

  /// Adds the selected options and disabled options to the options list.
  void _addOptions() {
    setState(() {
      _selectedOptions.addAll(widget.selectedOptions);
      _disabledOptions.addAll(widget.disabledOptions);
    });

    if (_controller != null) {
      _controller!.setOptions(_options);
      _controller!.setSelectedOptions(_selectedOptions);
      _controller!.setDisabledOptions(_disabledOptions);

      _controller!.addListener(_handleControllerChange);
    }
  }

  /// Handles the focus change to show/hide the dropdown.
  _handleFocusChange() {
    if (_focusNode.hasFocus && mounted) {
      _overlayEntry = _reponseBody != null && widget.networkConfig != null
          ? _buildNetworkErrorOverlayEntry()
          : _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      return;
    }

    if ((_searchFocusNode == null || _searchFocusNode?.hasFocus == false) &&
        _overlayEntry != null) {
      _overlayEntry?.remove();
    }

    if (mounted) {
      setState(() {
        _selectionMode =
            _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
      });
    }

    if (_controller != null) {
      _controller!.value._isDropdownOpen =
          _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
    }
  }

  /// Handles the widget rebuild when the options are changed externally.
  @override
  void didUpdateWidget(covariant MultiSelectDropDown2 oldWidget) {
    // If the options are changed externally, then the options are updated.
    if (listEquals(widget.options, oldWidget.options) == false) {
      _options.clear();
      _options.addAll(widget.options);

      // If the controller is not null, then the options are updated in the controller.
      if (_controller != null) {
        _controller!.setOptions(_options);
      }
    }

    // If the selected options are changed externally, then the selected options are updated.
    if (listEquals(widget.selectedOptions, oldWidget.selectedOptions) ==
        false) {
      _selectedOptions.clear();
      _selectedOptions.addAll(widget.selectedOptions);

      // If the controller is not null, then the selected options are updated in the controller.
      if (_controller != null) {
        _controller!.setSelectedOptions(_selectedOptions);
      }
    }

    // If the disabled options are changed externally, then the disabled options are updated.
    if (listEquals(widget.disabledOptions, oldWidget.disabledOptions) ==
        false) {
      _disabledOptions.clear();
      _disabledOptions.addAll(widget.disabledOptions);

      // If the controller is not null, then the disabled options are updated in the controller.
      if (_controller != null) {
        _controller!.setDisabledOptions(_disabledOptions);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Calculate offset size for dropdown.
  List _calculateOffsetSize() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    var size = renderBox?.size ?? Size.zero;
    var offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

    final availableHeight = MediaQuery.of(context).size.height - offset.dy;

    return [size, availableHeight < widget.dropdownHeight];
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        canRequestFocus: true,
        skipTraversal: true,
        focusNode: _focusNode,
        child: InkWell(
          overlayColor: const WidgetStatePropertyAll(MyColors.transparent),
          focusColor: MyColors.transparent,
          hoverColor: MyColors.transparent,
          splashColor: null,
          splashFactory: null,
          onTap: () {
            _toggleFocus();
          },
          child:
          Container(
          width: 200,
            padding: _getContainerPadding(),
            child: Row(
              children: [
                Text(widget.firstone),
                const Spacer(),
                  AnimatedRotation(
                    turns: _selectionMode ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: widget.suffixIcon,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Dispose the focus node and overlay entry.
  @override
  void dispose() {
    if (_overlayEntry?.mounted == true) {
      if (_overlayState != null && _overlayEntry != null) {
        _overlayEntry?.remove();
      }
      _overlayEntry = null;
      _overlayState?.dispose();
    }
    _focusNode.dispose();
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  /// Util method to map with index.
  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }


  /// Handle the focus change on tap outside of the dropdown.
  void _onOutSideTap() {
    if (_searchFocusNode != null) {
      _searchFocusNode!.unfocus();
    }
    _focusNode.unfocus();
  }


  /// Method to toggle the focus of the dropdown.
  void _toggleFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }


  /// Create the overlay entry for the dropdown.
  OverlayEntry _buildOverlayEntry() {
    // Calculate the offset and the size of the dropdown button
    final values = _calculateOffsetSize();
    // Get the size from the first item in the values list
    final size = values[0] as Size;
    // Get the showOnTop value from the second item in the values list
    final showOnTop = values[1] as bool;

    // Get the visual density of the theme
    // final visualDensity = Theme.of(context).visualDensity;

    // Calculate the height of the tile
    // final tileHeight = 48.0 + visualDensity.vertical;
    // Calculate the current height of the dropdown button
    // final currentHeight = tileHeight * _options.length;

    // Check if the dropdown height is less than the current height and greater than 0
    // final bool isScrollable =
    //     widget.dropdownHeight < currentHeight && widget.dropdownHeight > 0;
    // Calculate the offset in the Y direction
    // final _offsetY = showOnTop
    //     ? isScrollable
    //         ? -widget.dropdownHeight - 5
    //         : -currentHeight - 5
    //     : size.height + 5;

    return OverlayEntry(builder: (context) {
      List<ValueItem> options = _options;
      List<ValueItem> selectedOptions = [..._selectedOptions];

      return StatefulBuilder(builder: ((context, dropdownState) {
        return Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
                  onTap: _onOutSideTap,
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: true,
              targetAnchor:
              showOnTop ? Alignment.topLeft : Alignment.bottomLeft,
              followerAnchor:
              showOnTop ? Alignment.bottomLeft : Alignment.topLeft,
              child: Material(
                  elevation: 4,
                  shadowColor: Colors.black,
                  child: Container(
                    constraints: BoxConstraints.loose(
                        Size(size.width, widget.options.length<5?widget.options.length*50:widget.dropdownHeight)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return widget.optionSeparator ??
                                  const SizedBox(height: 0);
                            },
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options[index];
                              final isSelected =
                              selectedOptions.contains(option);
                              final primaryColor =
                                  Theme.of(context).primaryColor;

                              return _buildOption(option, primaryColor,
                                  isSelected, dropdownState, selectedOptions);
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        );
      }));
    });
  }

  ListTile _buildOption(ValueItem option, Color primaryColor, bool isSelected,
      StateSetter dropdownState, List<ValueItem> selectedOptions) {
    return ListTile(
        title: Text(option.label),
       );
  }

  /// Make a request to the provided url.
  /// The response then is parsed to a list of ValueItem objects.
  Future<void> _fetchNetwork() async {
    final result = await _performNetworkRequest();
    http.get(Uri.parse(widget.networkConfig!.url));
    if (result.statusCode == 200) {
      final data = json.decode(result.body);
      final List<ValueItem> parsedOptions = await widget.responseParser!(data);
      _reponseBody = null;
      _options.addAll(parsedOptions);
    } else {
      _reponseBody = result.body;
    }
  }

  /// Perform the network request according to the provided configuration.
  Future _performNetworkRequest() async {
    switch (widget.networkConfig!.method) {
      case RequestMethod.get:
        return await http.get(
          Uri.parse(widget.networkConfig!.url),
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.post:
        return await http.post(
          Uri.parse(widget.networkConfig!.url),
          body: widget.networkConfig!.body,
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.put:
        return await http.put(
          Uri.parse(widget.networkConfig!.url),
          body: widget.networkConfig!.body,
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.patch:
        return await http.patch(
          Uri.parse(widget.networkConfig!.url),
          body: widget.networkConfig!.body,
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.delete:
        return await http.delete(
          Uri.parse(widget.networkConfig!.url),
          headers: widget.networkConfig!.headers,
        );
      default:
        return await http.get(
          Uri.parse(widget.networkConfig!.url),
          headers: widget.networkConfig!.headers,
        );
    }
  }

  /// Builds overlay entry for showing error when fetching data from network fails.
  OverlayEntry _buildNetworkErrorOverlayEntry() {
    final values = _calculateOffsetSize();
    final size = values[0] as Size;
    final showOnTop = values[1] as bool;

    // final offsetY = showOnTop ? -(size.height + 5) : size.height + 5;

    return OverlayEntry(builder: (context) {
      return StatefulBuilder(builder: ((context, dropdownState) {
        return Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
                  onTap: _onOutSideTap,
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
            CompositedTransformFollower(
                link: _layerLink,
                targetAnchor:
                showOnTop ? Alignment.topLeft : Alignment.bottomLeft,
                followerAnchor:
                showOnTop ? Alignment.bottomLeft : Alignment.topLeft,
                child: Material(
                    elevation: 4,
                    child: Container(
                        width: size.width,
                        constraints: BoxConstraints.loose(
                            Size(size.width, widget.dropdownHeight)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.responseErrorBuilder != null
                                ? widget.responseErrorBuilder!(
                                context, _reponseBody)
                                : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  'Error fetching data: $_reponseBody'),
                            ),
                          ],
                        ))))
          ],
        );
      }));
    });
  }

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clear() {
    if (_controller != null) {
      _controller!.clearAllSelection();
    } else {
      setState(() {
        _selectedOptions.clear();
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  /// handle the controller change.
  void _handleControllerChange() {
    // if the controller is null, return.
    if (_controller == null) return;

    // if current disabled options are not equal to the controller's disabled options, update the state.
    if (_disabledOptions != _controller!.value._disabledOptions) {
      setState(() {
        _disabledOptions.clear();
        _disabledOptions.addAll(_controller!.value._disabledOptions);
      });
    }

    // if current options are not equal to the controller's options, update the state.
    if (_options != _controller!.value._options) {
      setState(() {
        _options.clear();
        _options.addAll(_controller!.value._options);
      });
    }

    // if current selected options are not equal to the controller's selected options, update the state.
    if (_selectedOptions != _controller!.value._selectedOptions) {
      setState(() {
        _selectedOptions.clear();
        _selectedOptions.addAll(_controller!.value._selectedOptions);
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }

    if (_selectionMode != _controller!.value._isDropdownOpen) {
      if (_controller!.value._isDropdownOpen) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    }
  }

  // get the container padding.
  EdgeInsetsGeometry _getContainerPadding() {
    if (widget.padding != null) {
      return widget.padding!;
    }
    return widget.selectionType == SelectionType.single
        ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
        : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0);
  }
}

/// MultiSelect Controller class.
/// This class is used to control the state of the MultiSelectDropdown widget.
/// This is just base class. The implementation of this class is in the MultiSelectController class.
/// The implementation of this class is hidden from the user.
class _MultiSelectController {
  final List<ValueItem> _disabledOptions = [];
  final List<ValueItem> _options = [];
  final List<ValueItem> _selectedOptions = [];
  bool _isDropdownOpen = false;
}

/// implementation of the MultiSelectController class.
class MultiSelectController extends ValueNotifier<_MultiSelectController> {
  MultiSelectController() : super(_MultiSelectController());

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clearAllSelection() {
    value._selectedOptions.clear();
    notifyListeners();
  }

  /// clear specific selected option
  /// [MultiSelectController] is used to clear specific selected option.
  void clearSelection(ValueItem option) {
    if (!value._selectedOptions.contains(option)) return;

    if (value._disabledOptions.contains(option)) {
      throw Exception('Cannot clear selection of a disabled option');
    }

    if (!value._options.contains(option)) {
      throw Exception(
          'Cannot clear selection of an option that is not in the options list');
    }

    value._selectedOptions.remove(option);
    notifyListeners();
  }

  /// select the options
  /// [MultiSelectController] is used to select the options.
  void setSelectedOptions(List<ValueItem> options) {
    if (options.any((element) => value._disabledOptions.contains(element))) {
      throw Exception('Cannot select disabled options');
    }

    if (options.any((element) => !value._options.contains(element))) {
      throw Exception('Cannot select options that are not in the options list');
    }

    value._selectedOptions.clear();
    value._selectedOptions.addAll(options);
    notifyListeners();
  }

  /// add selected option
  /// [MultiSelectController] is used to add selected option.
  void addSelectedOption(ValueItem option) {
    if (value._disabledOptions.contains(option)) {
      throw Exception('Cannot select disabled option');
    }

    if (!value._options.contains(option)) {
      throw Exception('Cannot select option that is not in the options list');
    }

    value._selectedOptions.add(option);
    notifyListeners();
  }

  /// set disabled options
  /// [MultiSelectController] is used to set disabled options.
  void setDisabledOptions(List<ValueItem> disabledOptions) {
    if (disabledOptions.any((element) => !value._options.contains(element))) {
      throw Exception(
          'Cannot disable options that are not in the options list');
    }

    value._disabledOptions.clear();
    value._disabledOptions.addAll(disabledOptions);
    notifyListeners();
  }

  /// setDisabledOption method
  /// [MultiSelectController] is used to set disabled option.
  void setDisabledOption(ValueItem disabledOption) {
    if (!value._options.contains(disabledOption)) {
      throw Exception('Cannot disable option that is not in the options list');
    }

    value._disabledOptions.add(disabledOption);
    notifyListeners();
  }

  /// set options
  /// [MultiSelectController] is used to set options.
  void setOptions(List<ValueItem> options) {
    value._options.clear();
    value._options.addAll(options);
    notifyListeners();
  }

  /// get disabled options
  List<ValueItem> get disabledOptions => value._disabledOptions;

  /// get enabled options
  List<ValueItem> get enabledOptions => value._options
      .where((element) => !value._disabledOptions.contains(element))
      .toList();

  /// get options
  List<ValueItem> get options => value._options;

  /// get selected options
  List<ValueItem> get selectedOptions => value._selectedOptions;

  /// get is dropdown open
  bool get isDropdownOpen => value._isDropdownOpen;

  /// show dropdown
  /// [MultiSelectController] is used to show dropdown.
  void showDropdown() {
    if (value._isDropdownOpen) return;
    value._isDropdownOpen = true;
    notifyListeners();
  }

  /// hide dropdown
  /// [MultiSelectController] is used to hide dropdown.
  void hideDropdown() {
    if (!value._isDropdownOpen) return;
    value._isDropdownOpen = false;
    notifyListeners();
  }
}