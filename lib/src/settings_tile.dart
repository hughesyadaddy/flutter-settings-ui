import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings_ui/src/cupertino_settings_item.dart';
import 'package:settings_ui/src/extensions.dart';

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget leading;
  final Widget trailing;
  final bool dense;
  final Color backgroundOverridenColor;
  final EdgeInsetsGeometry contentPadding;
  final VoidCallback onTap;
  final Function(bool value) onToggle;
  final bool switchValue;
  final bool enabled;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final Color switchActiveColor;
  final _SettingsTileType _tileType;

  const SettingsTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.dense,
    this.backgroundOverridenColor,
    this.contentPadding,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.enabled = true,
    this.switchActiveColor,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = null,
        super(key: key);

  const SettingsTile.switchTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.dense,
    this.backgroundOverridenColor,
    this.contentPadding,
    this.enabled = true,
    this.trailing,
    @required this.onToggle,
    @required this.switchValue,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.switchActiveColor,
  })  : _tileType = _SettingsTileType.switchTile,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (platform.isIOS) {
      return iosTile();
    } else {
      return androidTile();
    }
  }

  Widget iosTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return CupertinoSettingsItem(
        contentPadding: contentPadding,
        enabled: enabled,
        type: SettingsItemType.toggle,
        label: title,
        leading: leading,
        switchValue: switchValue,
        onToggle: onToggle,
        backgroundOverridenColor: backgroundOverridenColor,
        labelTextStyle: titleTextStyle,
        switchActiveColor: switchActiveColor,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
      );
    } else {
      return CupertinoSettingsItem(
        contentPadding: contentPadding,
        enabled: enabled,
        type: SettingsItemType.modal,
        label: title,
        value: subtitle,
        trailing: trailing,
        hasDetails: false,
        backgroundOverridenColor: backgroundOverridenColor,
        leading: leading,
        onPress: onTap,
        labelTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
      );
    }
  }

  Widget androidTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return Container(
        color: backgroundOverridenColor ?? null,
        child: SwitchListTile(
          contentPadding: contentPadding,
          secondary: leading,
          value: switchValue,
          activeColor: switchActiveColor,
          onChanged: enabled ? onToggle : null,
//        title: Text(title, style: titleTextStyle),
          title: title,
//        subtitle:
//            subtitle != null ? Text(subtitle, style: subtitleTextStyle) : null,
          subtitle: subtitle != null ? subtitle : null,
          dense: dense,
        ),
      );
    } else {
      return Container(
        color: backgroundOverridenColor ?? null,
        child: ListTile(
          contentPadding: contentPadding,
//        title: Text(title, style: titleTextStyle),
          title: title,
//        subtitle:
//            subtitle != null ? Text(subtitle, style: subtitleTextStyle) : null,
          subtitle: subtitle != null ? subtitle : null,
          leading: leading,
          enabled: enabled,
          trailing: trailing,
          onTap: onTap,
          dense: dense,
        ),
      );
    }
  }
}
